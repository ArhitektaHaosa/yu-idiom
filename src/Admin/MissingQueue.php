<?php
declare(strict_types=1);

namespace YuIdiom\Admin;

use PDO;
use YuIdiom\Config;
use YuIdiom\I18n\Normalizer;

final class MissingQueue
{
    private PDO $pdo;

    public function __construct(?PDO $pdo = null)
    {
        $this->pdo = $pdo ?? Config::pdo();
    }

    public function record(string $display, ?string $sourceLang): void
    {
        $display = trim(mb_substr($display, 0, 190));
        if ($display === '') {
            return;
        }
        $norm = Normalizer::key($display);
        if ($norm === '') {
            return;
        }
        $st = $this->pdo->prepare(
            "INSERT INTO missing_words (query_display, query_normalized, source_lang, hit_count, status)
             VALUES (?, ?, ?, 1, 'open')
             ON DUPLICATE KEY UPDATE
               hit_count = hit_count + 1,
               query_display = VALUES(query_display)"
        );
        $st->execute([$display, $norm, $sourceLang]);
    }

    public function list(string $status = 'open'): array
    {
        $allowed = ['open', 'ignored', 'added', 'all'];
        if (!in_array($status, $allowed, true)) {
            $status = 'open';
        }
        if ($status === 'all') {
            return $this->pdo->query(
                'SELECT * FROM missing_words ORDER BY hit_count DESC, updated_at DESC LIMIT 200'
            )->fetchAll();
        }
        $st = $this->pdo->prepare(
            'SELECT * FROM missing_words WHERE status = ? ORDER BY hit_count DESC, updated_at DESC LIMIT 200'
        );
        $st->execute([$status]);
        return $st->fetchAll();
    }

    public function setStatus(int $id, string $status): void
    {
        if (!in_array($status, ['open', 'ignored', 'added'], true)) {
            return;
        }
        $st = $this->pdo->prepare('UPDATE missing_words SET status = ? WHERE id = ?');
        $st->execute([$status, $id]);
    }
}
