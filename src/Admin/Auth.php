<?php
declare(strict_types=1);

namespace YuIdiom\Admin;

use YuIdiom\Security\Csrf;

final class Auth
{
    public static function check(): bool
    {
        Csrf::boot();
        return !empty($_SESSION['admin']);
    }

    public static function attempt(string $user, string $password): bool
    {
        Csrf::boot();
        $okUser = hash_equals(yu_env('ADMIN_USER', 'admin'), $user);
        $hash = yu_env('ADMIN_PASSWORD_HASH');
        $okPass = $hash !== '' && password_verify($password, $hash);
        if ($okUser && $okPass) {
            $_SESSION['admin'] = 1;
            return true;
        }
        return false;
    }

    public static function logout(): void
    {
        Csrf::boot();
        unset($_SESSION['admin']);
    }

    public static function requireLogin(): void
    {
        if (!self::check()) {
            header('Location: /admin/login', true, 302);
            exit;
        }
    }
}
