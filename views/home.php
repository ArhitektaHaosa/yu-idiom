<?php $source=$source??'sr'; $target=$target??'en'; $result=$result??null; $text=(string)($_POST['text']??''); ?>
<section class="hero">
<h1>How the region actually says it</h1>
<p class="lede">Translator + dictionary + phrasebook + SR/HR/BS/ME/SL/MK compare.</p>
</section>
<form class="translator" method="post" action="/translate">
<input type="hidden" name="_csrf" value="<?= yu_h(\YuIdiom\Security\Csrf::token()) ?>">
<div class="translator-grid">
<label>Source <select name="source"><?php foreach ($languages as $code=>$label): ?><option value="<?= yu_h($code) ?>" <?= $code===$source?'selected':'' ?>><?= yu_h($label) ?></option><?php endforeach; ?></select></label>
<label>Target <select name="target"><?php foreach ($languages as $code=>$label): ?><option value="<?= yu_h($code) ?>" <?= $code===$target?'selected':'' ?>><?= yu_h($label) ?></option><?php endforeach; ?></select></label>
</div>
<label class="block">Text <textarea name="text" id="source-text" rows="5" maxlength="2000" required><?= yu_h($text) ?></textarea></label>
<div class="actions"><button type="submit">Translate</button>
<button type="button" class="js-listen" data-target="#source-text" data-lang="<?= yu_h($source) ?>">Listen</button></div>
</form>
<?php if (is_array($result)): ?>
<section class="result">
<?php if (!$result['items']): ?><p>No verified local hit. Machine layer stays off unless OPUSMT_URL is set.</p>
<?php else: foreach ($result['items'] as $item): ?>
<article class="hit"><p class="main-tr"><?= yu_h($item['text']) ?></p>
<p class="meta"><?= yu_h($item['kind']??'natural') ?> · <?= yu_h($item['source']) ?><?php if (!empty($item['verified'])): ?> · verified<?php endif; ?></p>
<button type="button" class="js-listen" data-text="<?= yu_h($item['text']) ?>" data-lang="<?= yu_h($target) ?>">Listen</button>
</article>
<?php endforeach; endif; ?>
<?php if (!empty($result['entry'])): ?><p><a href="/<?= yu_h($result['entry']['language_code']??$source) ?>-en/<?= yu_h($result['entry']['slug']) ?>">Open dictionary entry</a></p><?php endif; ?>
</section>
<?php endif; ?>
<section class="starters"><h2>Start here</h2>
<ul>
<li><a href="/sr-en/kititi-se-tudjim-perjem">kititi se tuđim perjem</a></li>
<li><a href="/compare/hleb">hleb / kruh / hljeb</a></li>
<li><a href="/compare/voz">voz / vlak</a></li>
<li><a href="/compare/paradajz">paradajz / rajčica</a></li>
</ul></section>
