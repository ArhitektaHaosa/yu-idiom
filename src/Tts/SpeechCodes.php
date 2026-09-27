<?php
declare(strict_types=1);

namespace YuIdiom\Tts;

final class SpeechCodes
{
    public static function forLanguage(string $code): array
    {
        return match ($code) {
            'sr' => ['sr-RS', 'sr-Latn-RS', 'hr-HR'],
            'hr' => ['hr-HR', 'sr-RS'],
            'bs' => ['bs-BA', 'hr-HR', 'sr-RS'],
            'cnr' => ['sr-ME', 'sr-RS', 'hr-HR'],
            'sl' => ['sl-SI'],
            'mk' => ['mk-MK', 'sr-RS'],
            'en' => ['en-GB', 'en-US'],
            default => ['en-US'],
        };
    }
}
