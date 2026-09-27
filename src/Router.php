<?php
declare(strict_types=1);

namespace YuIdiom;

final class Router
{
    private array $routes = [];

    public function add(string $method, string $pattern, callable $handler): void
    {
        $this->routes[] = compact('method', 'pattern', 'handler');
    }

    public function dispatch(string $method, string $path): void
    {
        $path = rawurldecode($path);
        $path = $path === '' ? '/' : $path;
        foreach ($this->routes as $route) {
            if ($route['method'] !== $method && $route['method'] !== 'ANY') {
                continue;
            }
            $regex = '#^' . $route['pattern'] . '$#u';
            if (preg_match($regex, $path, $m)) {
                unset($m[0]);
                ($route['handler'])($m);
                return;
            }
        }
        http_response_code(404);
        $title = 'Not found';
        $page = '404';
        require dirname(__DIR__) . '/views/layout.php';
    }
}
