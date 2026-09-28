<?php
declare(strict_types=1);
$error = $error ?? '';
?>
<article>
    <h1>Admin</h1>
    <p>Missing-words queue. Hash lives in <code>.env</code>, not in git.</p>
    <?php if ($error !== ''): ?>
        <p class="note"><?= yu_h($error) ?></p>
    <?php endif; ?>
    <form method="post" action="/admin/login">
        <input type="hidden" name="_csrf" value="<?= yu_h(\YuIdiom\Security\Csrf::token()) ?>">
        <label class="block">User
            <input type="text" name="user" required autocomplete="username">
        </label>
        <label class="block">Password
            <input type="password" name="password" required autocomplete="current-password">
        </label>
        <button type="submit">Sign in</button>
    </form>
</article>
