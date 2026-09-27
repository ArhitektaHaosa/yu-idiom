<?php
declare(strict_types=1);

namespace YuIdiom\Translation;

use YuIdiom\Dictionary\EntryRepository;

final class LocalDictionaryProvider implements TranslationProviderInterface
{
    public function __construct(private readonly EntryRepository $entries)
    {
    }

    public function name(): string
    {
        return 'local_dictionary';
    }

    public function supports(string $source, string $target): bool
    {
        return true;
    }

    public function translate(string $text, string $source, string $target): array
    {
        $entry = $this->entries->lookup($text, $source, $target);
        if ($entry === null) {
            return [];
        }
        $out = [];
        foreach ($entry['translations'] as $row) {
            if (($row['target_code'] ?? '') !== $target) {
                continue;
            }
            $out[] = [
                'text' => $row['text'],
                'confidence' => (float) $row['confidence'],
                'source' => $row['source'],
                'kind' => $row['kind'],
                'verified' => (int) $row['verified'] === 1,
                'entry' => $entry,
            ];
        }
        return $out;
    }
}
