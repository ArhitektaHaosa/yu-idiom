<?php
declare(strict_types=1);

namespace YuIdiom\Security;

final class Csrf
{
    public static function boot(): void
    {
        if (session_status() !== PHP_SESSION_ACTIVE) {
            session_name(yu_env('SESSION_NAME', 'yuidiom'));
            session_start([
                'cookie_httponly' => true,
                'cookie_secure' => yu_env('COOKIE_SECURE', '1') === '1',
                'cookie_samesite' => yu_env('COOKIE_SAMESITE', 'Lax'),
            ]);
        }
        if (empty($_SESSION['_csrf'])) {
            $_SESSION['_csrf'] = bin2hex(random_bytes(16));
        }
    }

    public static function token(): string
    {
        self::boot();
        return (string) $_SESSION['_csrf'];
    }

    public static function check(?string $token): bool
    {
        self::boot();
        return is_string($token) && hash_equals((string) $_SESSION['_csrf'], $token);
    }
}
