-- Editorial seed for architecture demos. Not a scraped dictionary dump.
SET NAMES utf8mb4;

INSERT INTO concepts (id, slug, gloss_en) VALUES
  (1, 'bread', 'bread'),
  (2, 'train', 'train (railway)'),
  (3, 'tomato', 'tomato'),
  (4, 'borrowed-plumes', 'to take credit for another person''s work')
ON DUPLICATE KEY UPDATE gloss_en = VALUES(gloss_en);

INSERT INTO words (id, language_id, concept_id, lemma, display_form, normalized, slug, script, pos, is_phrase, register_tag) VALUES
  (1, 1, 1, 'hleb', 'hleb', 'hleb', 'hleb', 'Latn', 'noun', 0, NULL),
  (2, 1, 1, 'хлеб', 'хлеб', 'хлеб', 'hleb', 'Cyrl', 'noun', 0, NULL),
  (3, 2, 1, 'kruh', 'kruh', 'kruh', 'kruh', 'Latn', 'noun', 0, NULL),
  (4, 3, 1, 'hljeb', 'hljeb', 'hljeb', 'hljeb', 'Latn', 'noun', 0, NULL),
  (5, 4, 1, 'hljeb', 'hljeb', 'hljeb', 'hljeb', 'Latn', 'noun', 0, NULL),
  (6, 5, 1, 'kruh', 'kruh', 'kruh', 'kruh', 'Latn', 'noun', 0, NULL),
  (7, 6, 1, 'леб', 'леб', 'леб', 'leb', 'Cyrl', 'noun', 0, NULL),
  (8, 7, 1, 'bread', 'bread', 'bread', 'bread', 'Latn', 'noun', 0, NULL),
  (9, 1, 2, 'voz', 'voz', 'voz', 'voz', 'Latn', 'noun', 0, NULL),
  (10, 2, 2, 'vlak', 'vlak', 'vlak', 'vlak', 'Latn', 'noun', 0, NULL),
  (11, 3, 2, 'voz', 'voz', 'voz', 'voz', 'Latn', 'noun', 0, NULL),
  (12, 4, 2, 'voz', 'voz', 'voz', 'voz', 'Latn', 'noun', 0, NULL),
  (13, 5, 2, 'vlak', 'vlak', 'vlak', 'vlak', 'Latn', 'noun', 0, NULL),
  (14, 6, 2, 'воз', 'воз', 'воз', 'voz', 'Cyrl', 'noun', 0, NULL),
  (15, 7, 2, 'train', 'train', 'train', 'train', 'Latn', 'noun', 0, NULL),
  (16, 1, 3, 'paradajz', 'paradajz', 'paradajz', 'paradajz', 'Latn', 'noun', 0, NULL),
  (17, 2, 3, 'rajčica', 'rajčica', 'rajcica', 'rajcica', 'Latn', 'noun', 0, NULL),
  (18, 2, 3, 'paradajz', 'paradajz', 'paradajz', 'paradajz', 'Latn', 'noun', 0, 'colloquial'),
  (19, 3, 3, 'paradajz', 'paradajz', 'paradajz', 'paradajz', 'Latn', 'noun', 0, NULL),
  (20, 4, 3, 'paradajz', 'paradajz', 'paradajz', 'paradajz', 'Latn', 'noun', 0, NULL),
  (21, 5, 3, 'paradižnik', 'paradižnik', 'paradiznik', 'paradiznik', 'Latn', 'noun', 0, NULL),
  (22, 6, 3, 'домат', 'домат', 'домат', 'domat', 'Cyrl', 'noun', 0, NULL),
  (23, 7, 3, 'tomato', 'tomato', 'tomato', 'tomato', 'Latn', 'noun', 0, NULL),
  (24, 1, 4, 'kititi se tuđim perjem', 'kititi se tuđim perjem', 'kititi se tudjim perjem', 'kititi-se-tudjim-perjem', 'Latn', 'idiom', 1, 'literary'),
  (25, 1, 4, 'китити се туђим перјем', 'китити се туђим перјем', 'китити се туђим перјем', 'kititi-se-tudjim-perjem', 'Cyrl', 'idiom', 1, 'literary'),
  (26, 2, 4, 'kititi se tuđim perjem', 'kititi se tuđim perjem', 'kititi se tudjim perjem', 'kititi-se-tudjim-perjem', 'Latn', 'idiom', 1, 'literary'),
  (27, 7, 4, 'take credit for someone else''s work', 'take credit for someone else''s work', 'take credit for someone elses work', 'take-credit-for-someone-elses-work', 'Latn', 'idiom', 1, NULL)
ON DUPLICATE KEY UPDATE display_form = VALUES(display_form);

INSERT INTO phrases (word_id, phrase_type, literal_gloss, figurative_gloss, origin_note) VALUES
  (24, 'idiom',
   'to adorn oneself with another''s feathers',
   'to present another person''s work, status, or merit as one''s own',
   'Shared South Slavic idiom. English literary counterpart is “to adorn oneself with borrowed plumes”. Do not treat “steal someone''s thunder” as a perfect match.')
ON DUPLICATE KEY UPDATE figurative_gloss = VALUES(figurative_gloss);

INSERT INTO definitions (word_id, language_id, text, sense_order, source, confidence, verified) VALUES
  (1, 1, 'Osnovna pečena hrana od brašna i vode.', 1, 'dictionary_source', 1.00, 1),
  (9, 1, 'Šinsko vozilo za prevoz putnika ili robe.', 1, 'dictionary_source', 1.00, 1),
  (16, 1, 'Plod paradajza, povrće.', 1, 'dictionary_source', 1.00, 1),
  (24, 1, 'Prikazivati tuđi rad, zasluge ili ugled kao sopstvene.', 1, 'dictionary_source', 1.00, 1),
  (24, 7, 'To claim another person''s merit, work, or reputation as one''s own.', 1, 'dictionary_source', 1.00, 1);

INSERT INTO translations (source_word_id, target_language_id, text, kind, source, confidence, verified) VALUES
  (1, 7, 'bread', 'natural', 'dictionary_source', 1.00, 1),
  (3, 7, 'bread', 'natural', 'dictionary_source', 1.00, 1),
  (4, 7, 'bread', 'natural', 'dictionary_source', 1.00, 1),
  (9, 7, 'train', 'natural', 'dictionary_source', 1.00, 1),
  (10, 7, 'train', 'natural', 'dictionary_source', 1.00, 1),
  (16, 7, 'tomato', 'natural', 'dictionary_source', 1.00, 1),
  (17, 7, 'tomato', 'natural', 'dictionary_source', 1.00, 1),
  (21, 7, 'tomato', 'natural', 'dictionary_source', 1.00, 1),
  (22, 7, 'tomato', 'natural', 'dictionary_source', 1.00, 1),
  (24, 7, 'to take credit for someone else''s work', 'idiomatic', 'dictionary_source', 1.00, 1),
  (24, 7, 'to adorn oneself with borrowed plumes', 'literal', 'dictionary_source', 0.90, 1),
  (24, 7, 'to strut in borrowed feathers', 'alternative', 'dictionary_source', 0.80, 1);

INSERT INTO examples (word_id, language_id, sentence, translation, source, confidence, verified) VALUES
  (24, 1, 'Ne kiti se tuđim perjem — reci šta si sam uradio.', 'Do not take credit for other people''s work — say what you did yourself.', 'dictionary_source', 1.00, 1),
  (1, 1, 'Kupio je svež hleb.', 'He bought fresh bread.', 'dictionary_source', 1.00, 1),
  (10, 2, 'Vlak kasni deset minuta.', 'The train is ten minutes late.', 'dictionary_source', 1.00, 1);

INSERT INTO regional_variants (concept_id, word_id, country_code, note, difference_type) VALUES
  (1, 1, 'RS', 'Standard Serbian form.', 'different_word'),
  (1, 3, 'HR', 'Standard Croatian form.', 'different_word'),
  (1, 4, 'BA', 'Common Bosnian form.', 'spelling'),
  (1, 5, 'ME', 'Common Montenegrin form.', 'spelling'),
  (1, 6, 'SI', 'Slovenian.', 'different_word'),
  (1, 7, 'MK', 'Macedonian.', 'different_word'),
  (2, 9, 'RS', 'Standard Serbian form.', 'different_word'),
  (2, 10, 'HR', 'Standard Croatian form.', 'different_word'),
  (2, 11, 'BA', 'Common Bosnian form.', 'different_word'),
  (2, 12, 'ME', 'Common Montenegrin form.', 'different_word'),
  (3, 16, 'RS', 'Standard Serbian form.', 'different_word'),
  (3, 17, 'HR', 'Standard Croatian form.', 'different_word'),
  (3, 18, 'HR', 'Also heard; not the school-book headword.', 'frequency'),
  (3, 19, 'BA', 'Common Bosnian form.', 'different_word'),
  (3, 20, 'ME', 'Common Montenegrin form.', 'different_word'),
  (3, 21, 'SI', 'Slovenian.', 'different_word'),
  (3, 22, 'MK', 'Macedonian.', 'different_word'),
  (4, 24, 'RS', 'Shared idiom; Latin lemma.', 'regionalism'),
  (4, 26, 'HR', 'Same idiom is used in Croatian.', 'regionalism');

INSERT INTO pages (word_id, pair, canonical_path, title, meta_description, indexable) VALUES
  (24, 'sr-en', '/sr-en/kititi-se-tudjim-perjem', 'Kititi se tuđim perjem – značenje, prevod i primeri', 'Šta znači kititi se tuđim perjem, kako se prevodi na engleski, primeri, doslovni i idiomski ekvivalenti.', 1),
  (1, 'sr-en', '/sr-en/hleb', 'Hleb – značenje i prevod na engleski', 'Hleb na srpskom, kruh na hrvatskom, hljeb u Bosni i Crnoj Gori. Engleski: bread.', 1),
  (9, 'sr-en', '/sr-en/voz', 'Voz – značenje i prevod na engleski', 'Voz u Srbiji, vlak u Hrvatskoj. Engleski: train.', 1),
  (16, 'sr-en', '/sr-en/paradajz', 'Paradajz – značenje i regionalne varijante', 'Paradajz, rajčica, paradižnik, домат — kako se kaže širom regiona.', 1);

INSERT INTO word_search_keys (word_id, search_key, key_type) VALUES
  (24, 'kititi se tudjim perjem', 'ascii'),
  (24, 'kititi se tudim perjem', 'ascii'),
  (24, 'kititi se tuđim perjem', 'normalized'),
  (1, 'hleb', 'normalized'),
  (2, 'hleb', 'translit'),
  (3, 'kruh', 'normalized'),
  (9, 'voz', 'normalized'),
  (10, 'vlak', 'normalized'),
  (16, 'paradajz', 'normalized'),
  (17, 'rajcica', 'ascii'),
  (17, 'rajčica', 'normalized');
