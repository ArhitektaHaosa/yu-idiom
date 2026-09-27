<?php
declare(strict_types=1);

namespace YuIdiom\I18n;

final class Normalizer
{
    public static function key(string $text): string
    {
        $text = trim(mb_strtolower($text, 'UTF-8'));
        $text = strtr($text, [
            'đ' => 'dj', 'Đ' => 'dj',
            'č' => 'c', 'ć' => 'c', 'š' => 's', 'ž' => 'z',
            'Č' => 'c', 'Ć' => 'c', 'Š' => 's', 'Ž' => 'z',
        ]);
        $text = preg_replace('/[^\p{L}\p{N}\s-]+/u', '', $text) ?? $text;
        $text = preg_replace('/\s+/u', ' ', $text) ?? $text;
        return $text;
    }

    public static function slug(string $text): string
    {
        $key = self::key($text);
        $key = str_replace(' ', '-', $key);
        $key = preg_replace('/-+/', '-', $key) ?? $key;
        return trim($key, '-');
    }
}
