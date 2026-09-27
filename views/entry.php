<?php /** @var array $entry */ ?>
<article class="entry">
<nav class="crumbs"><a href="/">Home</a> › <?= yu_h($entry['name_en']??'') ?> › <?= yu_h($entry['display_form']) ?></nav>
<h1><?= yu_h($entry['display_form']) ?></h1>
<p class="pos"><?= yu_h($entry['pos']??'') ?><?php if (!empty($entry['register_tag'])): ?> · <?= yu_h($entry['register_tag']) ?><?php endif; ?></p>
<div class="actions">
<button type="button" class="js-listen" data-text="<?= yu_h($entry['display_form']) ?>" data-lang="<?= yu_h($entry['language_code']) ?>">Listen</button>
<a href="/compare/<?= yu_h($entry['slug']) ?>">Regional compare</a>
</div>
<?php if (!empty($entry['definitions'])): ?><section><h2>Značenje</h2><?php foreach ($entry['definitions'] as $def): ?><p><?= yu_h($def['text']) ?> <span class="src"><?= yu_h($def['source']) ?></span></p><?php endforeach; ?></section><?php endif; ?>
<?php if (!empty($entry['translations'])): ?><section><h2>English equivalents</h2><ul><?php foreach ($entry['translations'] as $tr): ?><li><strong><?= yu_h($tr['text']) ?></strong> — <?= yu_h($tr['kind']) ?></li><?php endforeach; ?></ul></section><?php endif; ?>
<?php if (!empty($entry['phrase'])): ?><section><h2>Literal vs idiomatic</h2>
<?php if (!empty($entry['phrase']['literal_gloss'])): ?><p><strong>Literal:</strong> <?= yu_h($entry['phrase']['literal_gloss']) ?></p><?php endif; ?>
<?php if (!empty($entry['phrase']['figurative_gloss'])): ?><p><strong>Idiomatic:</strong> <?= yu_h($entry['phrase']['figurative_gloss']) ?></p><?php endif; ?>
</section><?php endif; ?>
<?php if (!empty($entry['examples'])): ?><section><h2>Primeri</h2><?php foreach ($entry['examples'] as $ex): ?><blockquote><p><?= yu_h($ex['sentence']) ?></p><?php if (!empty($ex['translation'])): ?><p class="tr"><?= yu_h($ex['translation']) ?></p><?php endif; ?></blockquote><?php endforeach; ?></section><?php endif; ?>
<?php if (!empty($entry['variants'])): ?><section><h2>Kako se kaže širom regiona</h2><ul class="region-list"><?php foreach ($entry['variants'] as $v): ?><li><span class="cc"><?= yu_h($v['country_code']) ?></span> <?= yu_h($v['display_form']) ?> <small><?= yu_h($v['difference_type']) ?></small></li><?php endforeach; ?></ul></section><?php endif; ?>
</article>
