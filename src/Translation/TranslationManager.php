<?php
declare(strict_types=1);

namespace YuIdiom\Translation;

use YuIdiom\Config;

final class TranslationManager
{
    public function __construct(private readonly array $providers)
    {
    }

    public function translate(string $text, string $source, string $target): array
    {
        $text = trim($text);
        if ($text === '') {
            return ['items' => [], 'entry' => null];
        }
        $cached = $this->cacheGet($source, $target, $text);
        if ($cached !== null) {
            return $cached;
        }
        $items = [];
        $entry = null;
        foreach ($this->providers as $provider) {
            if (!$provider->supports($source, $target)) {
                continue;
            }
            $batch = $provider->translate($text, $source, $target);
            foreach ($batch as $row) {
                if (isset($row['entry']) && $entry === null) {
                    $entry = $row['entry'];
                    unset($row['entry']);
                }
                $items[] = $row;
            }
            foreach ($items as $row) {
                if (!empty($row['verified'])) {
                    $payload = ['items' => $items, 'entry' => $entry];
                    $this->cachePut($source, $target, $text, $payload);
                    return $payload;
                }
            }
        }
        $payload = ['items' => $items, 'entry' => $entry];
        if ($items) {
            $this->cachePut($source, $target, $text, $payload);
        }
        return $payload;
    }

    private function cacheGet(string $source, string $target, string $text): ?array
    {
        try {
            $st = Config::pdo()->prepare(
                'SELECT result_json FROM translation_cache
                 WHERE source_lang = ? AND target_lang = ? AND source_hash = ?'
            );
            $st->execute([$source, $target, hash('sha256', $text)]);
            $row = $st->fetch();
            if (!$row) {
                return null;
            }
            $json = json_decode($row['result_json'], true);
            return is_array($json) ? $json : null;
        } catch (\Throwable) {
            return null;
        }
    }

    private function cachePut(string $source, string $target, string $text, array $payload): void
    {
        try {
            $st = Config::pdo()->prepare(
                'INSERT INTO translation_cache (source_lang, target_lang, source_hash, source_text, result_json, provider)
                 VALUES (?,?,?,?,?,?)
                 ON DUPLICATE KEY UPDATE result_json = VALUES(result_json)'
            );
            $st->execute([
                $source,
                $target,
                hash('sha256', $text),
                $text,
                json_encode($payload, JSON_UNESCAPED_UNICODE),
                'mixed',
            ]);
        } catch (\Throwable) {
        }
    }
}
