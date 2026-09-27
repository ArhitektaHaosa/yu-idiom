<?php $didYouMean=$didYouMean??[]; ?>
<article><h1>That entry is not in the dictionary yet</h1>
<p>No indexable shell is created for unknown slugs.</p>
<?php if ($didYouMean): ?><h2>Did you mean?</h2><ul><?php foreach ($didYouMean as $row): ?>
<li><a href="/<?= yu_h($row['language_code']) ?>-en/<?= yu_h($row['slug']) ?>"><?= yu_h($row['display_form']) ?></a></li>
<?php endforeach; ?></ul><?php endif; ?>
<p><a href="/">Back to translator</a></p></article>
