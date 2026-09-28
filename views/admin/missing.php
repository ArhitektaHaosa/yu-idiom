<?php
declare(strict_types=1);
$status = $status ?? 'open';
?>
<article>
    <h1>Missing words</h1>
    <p>Queries with no local dictionary hit. Nothing here is published automatically.</p>
    <form method="get" action="/admin/missing">
        <label>Status
            <select name="status">
                <?php foreach (['open' => 'Open', 'ignored' => 'Ignored', 'added' => 'Added', 'all' => 'All'] as $code => $label): ?>
                    <option value="<?= yu_h($code) ?>" <?= $status === $code ? 'selected' : '' ?>><?= yu_h($label) ?></option>
                <?php endforeach; ?>
            </select>
        </label>
        <button type="submit">Filter</button>
    </form>
    <p>
        <form method="post" action="/admin/logout" style="display:inline">
            <input type="hidden" name="_csrf" value="<?= yu_h(\YuIdiom\Security\Csrf::token()) ?>">
            <button type="submit">Sign out</button>
        </form>
    </p>
    <?php if (empty($rows)): ?>
        <p>Queue is empty for this filter.</p>
    <?php else: ?>
        <table>
            <thead>
                <tr><th>Query</th><th>Lang</th><th>Hits</th><th>Status</th><th>Updated</th><th></th></tr>
            </thead>
            <tbody>
            <?php foreach ($rows as $row): ?>
                <tr>
                    <td><?= yu_h((string) $row['query_display']) ?></td>
                    <td><?= yu_h((string) ($row['source_lang'] ?? '')) ?></td>
                    <td><?= yu_h((string) $row['hit_count']) ?></td>
                    <td><?= yu_h((string) $row['status']) ?></td>
                    <td><?= yu_h((string) $row['updated_at']) ?></td>
                    <td>
                        <form method="post" action="/admin/missing">
                            <input type="hidden" name="_csrf" value="<?= yu_h(\YuIdiom\Security\Csrf::token()) ?>">
                            <input type="hidden" name="id" value="<?= yu_h((string) $row['id']) ?>">
                            <input type="hidden" name="filter" value="<?= yu_h($status) ?>">
                            <button type="submit" name="set_status" value="open">Open</button>
                            <button type="submit" name="set_status" value="ignored">Ignore</button>
                            <button type="submit" name="set_status" value="added">Mark added</button>
                        </form>
                    </td>
                </tr>
            <?php endforeach; ?>
            </tbody>
        </table>
    <?php endif; ?>
</article>
