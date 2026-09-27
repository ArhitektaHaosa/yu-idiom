# yu-idiom

Regional translator, dictionary, and phrasebook for the former Yugoslavia.

One search should explain not only how a word translates, but how people across the region actually say and use it.

Not a commercial translate clone. Local dictionary first. Optional localhost machine translation. Browser speech first.

Live target stack: Nginx + PHP-FPM + MariaDB on CloudPanel.

## Principle

Serbian, Croatian, Bosnian, and Montenegrin are not treated as one language with a flag swap.

When a form differs, the page says so.

Serbia: hleb  
Croatia: kruh  
Bosnia and Herzegovina: hljeb  
Montenegro: hljeb

Serbia: voz  
Croatia: vlak

## What ships in this repository

| Layer | Role |
| --- | --- |
| `docs/` | Architecture, URLs, SEO gate, providers, TTS, security, roadmap |
| `sql/` | MariaDB schema + seed entries |
| `public/` | Front controller, CSS, vanilla JS, PWA manifest |
| `src/` | Router, dictionary, script converter, providers, SEO |
| `views/` | Server-rendered templates |
| `services/opus-mt/` | Optional localhost Python translation service |

PHP is the public application. Python never binds to a public port.

## Languages

MVP pairs: `sr` / `hr` / `bs` / `cnr` ↔ `en`, plus Serbian Latin ↔ Cyrillic.

Ready to add without rewriting the schema: Slovenian, Macedonian, then other European languages.

Scripts: Latin and Cyrillic. Display form is never destroyed by normalization.

## Quick start

```bash
cp .env.example .env
mysql -u USER -p DB < sql/001_schema.sql
mysql -u USER -p DB < sql/002_seed.sql
```

Point CloudPanel document root at `public/`.

PHP 8.2+, MariaDB 10.11+ or MySQL 8. Redis is optional. The site works if the Python service is down.

Open `/`, `/sr-en/kititi-se-tudjim-perjem`, `/compare/hleb`, `/latinica-u-cirilicu/`.

## Translation order

Local dictionary, then cache, then localhost OPUS-MT if present. Machine rows stay labeled.

Phase 2 models: `Helsinki-NLP/opus-mt-tc-big-sh-en` and `Helsinki-NLP/opus-mt-tc-base-en-sh`.

## SEO rule

Index only pages that pass the quality gate. Thin URLs get `noindex,follow`. Unknown slugs are not fake dictionary pages.

## License

Source code: MIT. Seed text is editorial sample data, not a scraped dictionary dump.
