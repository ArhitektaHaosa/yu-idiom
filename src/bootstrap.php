<?php
declare(strict_types=1);

spl_autoload_register(static function (string $class): void {
    $prefix = 'YuIdiom\\';
    if (!str_starts_with($class, $prefix)) {
        return;
    }
    $rel = str_replace('\\', '/', substr($class, strlen($prefix)));
    $file = __DIR__ . '/' . $rel . '.php';
    if (is_file($file)) {
        require $file;
    }
});

function yu_env(string $key, string $default = ''): string
{
    static $loaded = false;
    static $map = [];
    if (!$loaded) {
        $path = dirname(__DIR__) . '/.env';
        if (is_file($path)) {
            foreach (file($path, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES) ?: [] as $line) {
                if ($line === '' || $line[0] === '#' || !str_contains($line, '=')) {
                    continue;
                }
                [$k, $v] = explode('=', $line, 2);
                $map[trim($k)] = trim($v);
            }
        }
        $loaded = true;
    }
    return $map[$key] ?? $default;
}

function yu_h(string $value): string
{
    return htmlspecialchars($value, ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8');
}
