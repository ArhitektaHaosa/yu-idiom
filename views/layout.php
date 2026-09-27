<?php
$description = $description ?? '';
$canonical = $canonical ?? (parse_url($_SERVER['REQUEST_URI'] ?? '/', PHP_URL_PATH) ?: '/');
$indexable = $indexable ?? true;
$base = \YuIdiom\Config::url();
?><!DOCTYPE html>
<html lang="sr-Latn">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title><?= yu_h($title) ?></title>
<?php if ($description !== ''): ?><meta name="description" content="<?= yu_h($description) ?>"><?php endif; ?>
<link rel="canonical" href="<?= yu_h($base.$canonical) ?>">
<?php if (empty($indexable)): ?><meta name="robots" content="noindex,follow"><?php endif; ?>
<link rel="stylesheet" href="/assets/css/app.css">
<link rel="manifest" href="/manifest.json">
</head>
<body>
<header class="site-header">
<a class="logo" href="/">yu-idiom</a>
<nav>
<a href="/">Translator</a>
<a href="/compare/hleb">Region</a>
<a href="/latinica-u-cirilicu/">Aa → Аа</a>
<a href="/sr-en/kititi-se-tudjim-perjem">Idiom</a>
</nav>
<button type="button" id="theme-toggle">Theme</button>
</header>
<main>
<?php $view = dirname(__FILE__).'/'.$page.'.php'; if (is_file($view)) require $view; ?>
</main>
<footer class="site-footer"><p>Local dictionary first. Browser speech first.</p></footer>
<script src="/assets/js/tts.js" defer></script>
<script src="/assets/js/app.js" defer></script>
</body></html>
