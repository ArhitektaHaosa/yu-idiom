<article class="compare"><h1>Kako se kaže: <?= yu_h($concept['slug']) ?></h1>
<?php if (!empty($concept['gloss_en'])): ?><p class="lede"><?= yu_h($concept['gloss_en']) ?></p><?php endif; ?>
<ul class="region-cards"><?php foreach ($concept['variants'] as $v): ?>
<li><p class="cc"><?= yu_h($v['country_code']) ?> · <?= yu_h($v['name_en']) ?></p>
<p class="form"><?= yu_h($v['display_form']) ?></p>
<p class="note"><?= yu_h($v['difference_type']) ?></p>
<p><a href="/<?= yu_h($v['language_code']) ?>-en/<?= yu_h($v['slug']) ?>">Open entry</a></p></li>
<?php endforeach; ?></ul></article>
