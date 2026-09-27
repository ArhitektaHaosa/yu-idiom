<?php
declare(strict_types=1);

namespace YuIdiom\Seo;

final class QualityGate
{
    public static function indexable(array $entry): bool
    {
        if (!empty($entry['page']['indexable'])) {
            return (int) $entry['page']['indexable'] === 1;
        }
        $hasDef = false;
        foreach ($entry['definitions'] ?? [] as $row) {
            if ((int) $row['verified'] === 1 || $row['source'] === 'dictionary_source') {
                $hasDef = true;
            }
        }
        $hasTr = false;
        foreach ($entry['translations'] ?? [] as $row) {
            if ((int) $row['verified'] === 1 || $row['source'] === 'dictionary_source') {
                $hasTr = true;
            }
        }
        return $hasDef && $hasTr;
    }
}
