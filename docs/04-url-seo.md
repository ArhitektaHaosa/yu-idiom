# URL and SEO architecture

`/sr-en/{slug}`, `/hr-en/{slug}`, `/bs-en/{slug}`, `/cnr-en/{slug}`, `/compare/{slug}`, `/latinica-u-cirilicu/`, `/cirilica-u-latinicu/`, `/sitemap.xml`.

Slugs are ASCII-folded. Display text keeps diacritics and Cyrillic.

Index only when the lemma exists, there is a verified or dictionary_source translation or definition, unique body, and `pages.indexable = 1`.

Unknown slugs: soft 404, never an indexable shell.

hreflang only for real alternates. No fake ratings. No FAQ schema without a FAQ.
