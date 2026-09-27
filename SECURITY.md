# Security

- Document root is `public/` only.
- `.env` is not committed.
- PDO prepared statements only.
- CSRF on POST.
- CSP is sent from `public/index.php`.
- Optional Python translation service binds to `127.0.0.1`.
- Do not put user input into a shell command.
- Admin password is a hash in the environment, not in git.

Report issues privately to the repository owner.
