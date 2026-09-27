<?php
declare(strict_types=1);

namespace YuIdiom\Dictionary;

use PDO;
use YuIdiom\Config;
use YuIdiom\I18n\Normalizer;

final class EntryRepository
{
    private PDO $pdo;

    public function __construct(?PDO $pdo = null)
    {
        $this->pdo = $pdo ?? Config::pdo();
    }

    public function findByPairSlug(string $sourceLang, string $slug): ?array
    {
        $sql = 'SELECT w.*, l.code AS language_code, l.bcp47, l.name_en, l.name_native
                FROM words w
                JOIN languages l ON l.id = w.language_id
                WHERE l.code = :lang AND w.slug = :slug
                ORDER BY w.script = \'Latn\' DESC
                LIMIT 1';
        $st = $this->pdo->prepare($sql);
        $st->execute(['lang' => $sourceLang, 'slug' => $slug]);
        $word = $st->fetch();
        if (!$word) {
            return null;
        }
        return $this->hydrate((int) $word['id'], $word);
    }

    public function suggest(string $q, int $limit = 8): array
    {
        $norm = Normalizer::key($q);
        if ($norm === '') {
            return [];
        }
        $st = $this->pdo->prepare(
            'SELECT w.display_form, w.slug, l.code AS language_code, w.is_phrase
             FROM words w
             JOIN languages l ON l.id = w.language_id
             LEFT JOIN word_search_keys k ON k.word_id = w.id
             WHERE w.normalized LIKE :q OR k.search_key LIKE :q OR w.display_form LIKE :raw
             GROUP BY w.id
             ORDER BY w.is_phrase DESC, CHAR_LENGTH(w.display_form) ASC
             LIMIT :lim'
        );
        $like = $norm . '%';
        $st->bindValue(':q', $like);
        $st->bindValue(':raw', $q . '%');
        $st->bindValue(':lim', $limit, PDO::PARAM_INT);
        $st->execute();
        return $st->fetchAll();
    }

    public function compare(string $slug): ?array
    {
        $st = $this->pdo->prepare(
            'SELECT c.* FROM concepts c
             JOIN words w ON w.concept_id = c.id
             WHERE c.slug = :slug OR w.slug = :slug
             LIMIT 1'
        );
        $st->execute(['slug' => $slug]);
        $concept = $st->fetch();
        if (!$concept) {
            return null;
        }
        $st = $this->pdo->prepare(
            'SELECT rv.*, w.display_form, w.slug, w.script, l.code AS language_code, l.name_en
             FROM regional_variants rv
             JOIN words w ON w.id = rv.word_id
             JOIN languages l ON l.id = w.language_id
             WHERE rv.concept_id = :id
             ORDER BY l.sort_order, rv.id'
        );
        $st->execute(['id' => $concept['id']]);
        $concept['variants'] = $st->fetchAll();
        return $concept;
    }

    public function lookup(string $text, string $source, string $target): ?array
    {
        $slug = Normalizer::slug($text);
        $norm = Normalizer::key($text);
        $st = $this->pdo->prepare(
            'SELECT w.*, l.code AS language_code
             FROM words w
             JOIN languages l ON l.id = w.language_id
             LEFT JOIN word_search_keys k ON k.word_id = w.id
             WHERE l.code = :lang AND (w.slug = :slug OR w.normalized = :norm OR k.search_key = :norm)
             LIMIT 1'
        );
        $st->execute(['lang' => $source, 'slug' => $slug, 'norm' => $norm]);
        $word = $st->fetch();
        if (!$word) {
            return null;
        }
        return $this->hydrate((int) $word['id'], $word);
    }

    public function indexablePages(): array
    {
        return $this->pdo->query(
            'SELECT canonical_path, title FROM pages WHERE indexable = 1 ORDER BY canonical_path'
        )->fetchAll();
    }

    private function hydrate(int $id, array $word): array
    {
        $word['definitions'] = $this->select('SELECT * FROM definitions WHERE word_id = ? ORDER BY sense_order', [$id]);
        $word['translations'] = $this->select(
            'SELECT t.*, l.code AS target_code FROM translations t
             JOIN languages l ON l.id = t.target_language_id
             WHERE t.source_word_id = ? ORDER BY t.kind, t.id',
            [$id]
        );
        $word['examples'] = $this->select('SELECT * FROM examples WHERE word_id = ?', [$id]);
        $word['phrase'] = $this->select('SELECT * FROM phrases WHERE word_id = ?', [$id])[0] ?? null;
        $word['page'] = $this->select('SELECT * FROM pages WHERE word_id = ? LIMIT 1', [$id])[0] ?? null;
        $word['variants'] = [];
        if (!empty($word['concept_id'])) {
            $word['variants'] = $this->select(
                'SELECT rv.*, w.display_form, l.code AS language_code, l.name_en
                 FROM regional_variants rv
                 JOIN words w ON w.id = rv.word_id
                 JOIN languages l ON l.id = w.language_id
                 WHERE rv.concept_id = ?
                 ORDER BY l.sort_order',
                [(int) $word['concept_id']]
            );
        }
        return $word;
    }

    private function select(string $sql, array $params): array
    {
        $st = $this->pdo->prepare($sql);
        $st->execute($params);
        return $st->fetchAll();
    }
}
