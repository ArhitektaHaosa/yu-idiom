<?php
declare(strict_types=1);

use YuIdiom\Config;
use YuIdiom\Dictionary\EntryRepository;
use YuIdiom\I18n\ScriptConverter;
use YuIdiom\Router;
use YuIdiom\Security\Csrf;
use YuIdiom\Seo\QualityGate;
use YuIdiom\Translation\LocalDictionaryProvider;
use YuIdiom\Translation\OpusMtProvider;
use YuIdiom\Translation\TranslationManager;

require dirname(__DIR__) . '/src/bootstrap.php';

header('X-Content-Type-Options: nosniff');
header('Referrer-Policy: strict-origin-when-cross-origin');
header("Content-Security-Policy: default-src 'self'; script-src 'self'; style-src 'self'; img-src 'self' data:; connect-src 'self'");

Csrf::boot();
$router = new Router();
$entries = new EntryRepository();
$translator = new TranslationManager([
    new LocalDictionaryProvider($entries),
    new OpusMtProvider(),
]);
$languages = ['sr'=>'Serbian','hr'=>'Croatian','bs'=>'Bosnian','cnr'=>'Montenegrin','sl'=>'Slovenian','mk'=>'Macedonian','en'=>'English'];

$router->add('GET', '/', function () use ($languages) {
    $title = 'yu-idiom — regional dictionary and translator';
    $description = 'How people across the former Yugoslavia say it.';
    $page = 'home'; $source = 'sr'; $target = 'en'; $result = null;
    require dirname(__DIR__) . '/views/layout.php';
});

$router->add('POST', '/translate', function () use ($languages, $translator) {
    if (!Csrf::check($_POST['_csrf'] ?? null)) { http_response_code(400); echo 'Bad CSRF token'; return; }
    $source = preg_replace('/[^a-z]/', '', (string)($_POST['source'] ?? 'sr')) ?: 'sr';
    $target = preg_replace('/[^a-z]/', '', (string)($_POST['target'] ?? 'en')) ?: 'en';
    $text = mb_substr(trim((string)($_POST['text'] ?? '')), 0, 2000);
    $result = $translator->translate($text, $source, $target);
    $title = 'Translation'; $description = ''; $page = 'home';
    require dirname(__DIR__) . '/views/layout.php';
});

$router->add('GET', '/api/v1/suggest', function () use ($entries) {
    header('Content-Type: application/json; charset=utf-8');
    echo json_encode($entries->suggest((string)($_GET['q'] ?? '')), JSON_UNESCAPED_UNICODE);
});

$router->add('GET', '/(sr|hr|bs|cnr|sl|mk)-en/([a-z0-9-]+)', function (array $args) use ($entries) {
    $lang = $args[1] ?? 'sr'; $slug = $args[2] ?? '';
    $entry = $entries->findByPairSlug($lang, $slug);
    if ($entry === null) {
        http_response_code(404); $title = 'Not found'; $page = '404';
        $didYouMean = $entries->suggest(str_replace('-', ' ', $slug));
        require dirname(__DIR__) . '/views/layout.php'; return;
    }
    $indexable = QualityGate::indexable($entry);
    if (!$indexable) header('X-Robots-Tag: noindex, follow');
    $title = $entry['page']['title'] ?? ($entry['display_form'] . ' — yu-idiom');
    $description = $entry['page']['meta_description'] ?? '';
    $canonical = $entry['page']['canonical_path'] ?? ('/' . $lang . '-en/' . $slug);
    $page = 'entry';
    require dirname(__DIR__) . '/views/layout.php';
});

$router->add('GET', '/compare/([a-z0-9-]+)', function (array $args) use ($entries) {
    $concept = $entries->compare($args[1] ?? '');
    if ($concept === null) { http_response_code(404); $title='Not found'; $page='404'; require dirname(__DIR__).'/views/layout.php'; return; }
    $title = 'Kako se kaže: ' . $concept['slug'] . ' — yu-idiom';
    $description = $concept['gloss_en'] ?? ''; $page = 'compare';
    require dirname(__DIR__) . '/views/layout.php';
});

$router->add('GET', '/latinica-u-cirilicu/', function () {
    $title='Latinica u ćirilicu'; $description='Local Serbian script conversion.'; $page='script'; $direction='lat2cyr'; $input=''; $output='';
    require dirname(__DIR__).'/views/layout.php';
});
$router->add('POST', '/latinica-u-cirilicu/', function () {
    if (!Csrf::check($_POST['_csrf'] ?? null)) { http_response_code(400); return; }
    $input=(string)($_POST['text']??''); $output=ScriptConverter::latinToCyrillic($input);
    $title='Latinica u ćirilicu'; $description=''; $page='script'; $direction='lat2cyr';
    require dirname(__DIR__).'/views/layout.php';
});
$router->add('GET', '/cirilica-u-latinicu/', function () {
    $title='Ćirilica u latinicu'; $description='Local Serbian script conversion.'; $page='script'; $direction='cyr2lat'; $input=''; $output='';
    require dirname(__DIR__).'/views/layout.php';
});
$router->add('POST', '/cirilica-u-latinicu/', function () {
    if (!Csrf::check($_POST['_csrf'] ?? null)) { http_response_code(400); return; }
    $input=(string)($_POST['text']??''); $output=ScriptConverter::cyrillicToLatin($input);
    $title='Ćirilica u latinicu'; $description=''; $page='script'; $direction='cyr2lat';
    require dirname(__DIR__).'/views/layout.php';
});
$router->add('GET', '/sitemap.xml', function () use ($entries) {
    header('Content-Type: application/xml; charset=utf-8');
    $base = Config::url();
    echo '<?xml version="1.0" encoding="UTF-8"?><urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">';
    echo '<url><loc>'.yu_h($base.'/').'</loc></url>';
    foreach ($entries->indexablePages() as $p) {
        echo '<url><loc>'.yu_h($base.$p['canonical_path']).'</loc></url>';
    }
    echo '</urlset>';
});

$path = parse_url($_SERVER['REQUEST_URI'] ?? '/', PHP_URL_PATH) ?: '/';
$router->dispatch($_SERVER['REQUEST_METHOD'] ?? 'GET', $path);
