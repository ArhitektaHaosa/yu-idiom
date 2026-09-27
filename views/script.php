<?php $direction=$direction??'lat2cyr'; $input=$input??''; $output=$output??''; $action=$direction==='lat2cyr'?'/latinica-u-cirilicu/':'/cirilica-u-latinicu/'; ?>
<article>
<h1><?= $direction==='lat2cyr' ? 'Latinica u ćirilicu' : 'Ćirilica u latinicu' ?></h1>
<p>Runs in PHP on this server. Digraphs lj, nj, dž first.</p>
<form method="post" action="<?= yu_h($action) ?>">
<input type="hidden" name="_csrf" value="<?= yu_h(\YuIdiom\Security\Csrf::token()) ?>">
<label class="block">Input <textarea name="text" rows="6"><?= yu_h($input) ?></textarea></label>
<button type="submit">Convert</button>
</form>
<?php if ($output!==''): ?><h2>Result</h2><textarea rows="6" readonly><?= yu_h($output) ?></textarea><?php endif; ?>
</article>
