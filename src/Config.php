<?php
declare(strict_types=1);

namespace YuIdiom;

final class Config
{
    public static function db(): array
    {
        return [
            'dsn' => sprintf(
                'mysql:host=%s;port=%s;dbname=%s;charset=utf8mb4',
                yu_env('DB_HOST', '127.0.0.1'),
                yu_env('DB_PORT', '3306'),
                yu_env('DB_NAME', 'yu_idiom')
            ),
            'user' => yu_env('DB_USER', 'yu_idiom'),
            'pass' => yu_env('DB_PASS', ''),
        ];
    }

    public static function pdo(): \PDO
    {
        static $pdo = null;
        if ($pdo instanceof \PDO) {
            return $pdo;
        }
        $c = self::db();
        $pdo = new \PDO($c['dsn'], $c['user'], $c['pass'], [
            \PDO::ATTR_ERRMODE => \PDO::ERRMODE_EXCEPTION,
            \PDO::ATTR_DEFAULT_FETCH_MODE => \PDO::FETCH_ASSOC,
            \PDO::ATTR_EMULATE_PREPARES => false,
        ]);
        return $pdo;
    }

    public static function url(): string
    {
        return rtrim(yu_env('APP_URL', ''), '/');
    }
}
