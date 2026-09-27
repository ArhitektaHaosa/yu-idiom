# System architecture

A CloudPanel PHP site that is a translator, a dictionary, a phrasebook, and a regional comparison engine.

```
Browser
  -> Nginx -> public/index.php
       PHP application + MariaDB
       Optional localhost OPUS-MT / Piper / Redis
```

If optional services are down, dictionary, script conversion, search, and SEO pages still work.

PHP is the public layer. Machine translation stays on 127.0.0.1.

Every translation, definition, example, and synonym row has source, confidence, verified, timestamps.

Serbian, Croatian, Bosnian, and Montenegrin are separate language codes. Script lives on the word row.

Regional comparison is a first-class concept cluster, not a flag swap.

Non-goals for Phase 1: React/Vue, paid TTS, required paid translate API, indexing raw user input, fake sr/hr/bs/cnr detection precision.
