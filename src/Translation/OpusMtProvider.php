<?php
declare(strict_types=1);

namespace YuIdiom\Translation;

final class OpusMtProvider implements TranslationProviderInterface
{
    public function name(): string
    {
        return 'opus_mt';
    }

    public function supports(string $source, string $target): bool
    {
        $url = yu_env('OPUSMT_URL');
        if ($url === '') {
            return false;
        }
        $pair = $source . '-' . $target;
        return in_array($pair, [
            'sr-en', 'hr-en', 'bs-en', 'cnr-en',
            'en-sr', 'en-hr', 'en-bs', 'en-cnr',
            'sl-en', 'mk-en', 'en-sl', 'en-mk',
        ], true);
    }

    public function translate(string $text, string $source, string $target): array
    {
        $base = rtrim(yu_env('OPUSMT_URL'), '/');
        if ($base === '') {
            return [];
        }
        $timeout = (float) yu_env('OPUSMT_TIMEOUT', '8');
        $payload = json_encode([
            'text' => $text,
            'source' => $source,
            'target' => $target,
        ], JSON_UNESCAPED_UNICODE);
        $ctx = stream_context_create([
            'http' => [
                'method' => 'POST',
                'header' => "Content-Type: application/json\r\n",
                'content' => $payload,
                'timeout' => $timeout,
            ],
        ]);
        $raw = @file_get_contents($base . '/translate', false, $ctx);
        if ($raw === false) {
            return [];
        }
        $json = json_decode($raw, true);
        if (!is_array($json) || empty($json['text'])) {
            return [];
        }
        return [[
            'text' => (string) $json['text'],
            'confidence' => 0.55,
            'source' => 'machine_translation',
            'kind' => 'natural',
            'verified' => false,
        ]];
    }
}
