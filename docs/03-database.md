# Database schema

MariaDB / MySQL, utf8mb4.

A word is a lemma in one language and one script.
A phrase is a multi-word unit.
A concept groups regional variants of the same meaning.

`normalized` is a search key. Never overwrite `display_form`.

`word_forms` stores only attested or editor-entered forms.
