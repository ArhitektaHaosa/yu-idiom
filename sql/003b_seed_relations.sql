SET NAMES utf8mb4;

INSERT INTO phrases (word_id, phrase_type, literal_gloss, figurative_gloss, origin_note) VALUES
  (73, 'idiom', 'to pull someone by the nose', 'to deceive or manipulate someone', 'Shared colloquial idiom across the region.'),
  (76, 'idiom', 'to throw pearls before swine', 'to give something valuable to someone unable or unwilling to appreciate it', 'Biblical image; used in Serbian and Croatian in this form.'),
  (79, 'idiom', 'who digs a pit for another falls into it himself', 'harm planned for someone else returns to the planner', 'Proverb. Croatian headword uses tko, Serbian ko.'),
  (82, 'idiom', 'to keep the tongue behind the teeth', 'to stay silent; not say what one knows', 'Shared colloquial idiom.'),
  (85, 'idiom', 'to buy a cat in a sack', 'to accept a deal without inspecting the goods', 'Serbian commonly džak; Croatian commonly vreća. English match is pig in a poke.'),
  (88, 'idiom', 'better a sparrow in the hand than a pigeon on the branch', 'a sure small thing is worth more than a larger uncertain one', 'Shared proverb. English bird-in-hand is the idiomatic match.')
ON DUPLICATE KEY UPDATE figurative_gloss = VALUES(figurative_gloss);

INSERT INTO definitions (word_id, language_id, text, sense_order, source, confidence, verified) VALUES
  (30, 1, 'Krtola, jestivo podzemno stablo.', 1, 'dictionary_source', 1.00, 1),
  (37, 1, 'Igra loptom nogama, asocijacijski fudbal.', 1, 'dictionary_source', 1.00, 1),
  (45, 1, 'Broj 1000.', 1, 'dictionary_source', 1.00, 1),
  (52, 1, 'Pogon u kojem se proizvodi roba.', 1, 'dictionary_source', 1.00, 1),
  (59, 1, 'Zgrada i ustanova za scenske predstave.', 1, 'dictionary_source', 1.00, 1),
  (66, 1, 'Umetnost tona i ritma.', 1, 'dictionary_source', 1.00, 1),
  (73, 1, 'Obmanjivati nekoga, voditi ga za nos.', 1, 'dictionary_source', 1.00, 1),
  (73, 7, 'To deceive or manipulate someone.', 1, 'dictionary_source', 1.00, 1),
  (76, 1, 'Nuditi vredno onome ko to ne može ili neće da ceni.', 1, 'dictionary_source', 1.00, 1),
  (79, 1, 'Zlo smešteno drugome vraća se onome ko ga sprema.', 1, 'dictionary_source', 1.00, 1),
  (82, 1, 'Ćutati; ne reći što se zna.', 1, 'dictionary_source', 1.00, 1),
  (85, 1, 'Kupiti ili prihvatiti nešto bez provere.', 1, 'dictionary_source', 1.00, 1),
  (88, 1, 'Sigurna mala korist vredi više od veće nesigurne.', 1, 'dictionary_source', 1.00, 1);

INSERT INTO translations (source_word_id, target_language_id, text, kind, source, confidence, verified) VALUES
  (30, 7, 'potato', 'natural', 'dictionary_source', 1.00, 1),
  (31, 7, 'potato', 'natural', 'dictionary_source', 1.00, 1),
  (37, 7, 'football', 'natural', 'dictionary_source', 1.00, 1),
  (38, 7, 'football', 'natural', 'dictionary_source', 1.00, 1),
  (45, 7, 'thousand', 'natural', 'dictionary_source', 1.00, 1),
  (46, 7, 'thousand', 'natural', 'dictionary_source', 1.00, 1),
  (52, 7, 'factory', 'natural', 'dictionary_source', 1.00, 1),
  (53, 7, 'factory', 'natural', 'dictionary_source', 1.00, 1),
  (59, 7, 'theatre', 'natural', 'dictionary_source', 1.00, 1),
  (60, 7, 'theatre', 'natural', 'dictionary_source', 1.00, 1),
  (66, 7, 'music', 'natural', 'dictionary_source', 1.00, 1),
  (67, 7, 'music', 'natural', 'dictionary_source', 1.00, 1),
  (73, 7, 'to lead someone by the nose', 'idiomatic', 'dictionary_source', 1.00, 1),
  (73, 7, 'to pull someone by the nose', 'literal', 'dictionary_source', 0.90, 1),
  (76, 7, 'to cast pearls before swine', 'idiomatic', 'dictionary_source', 1.00, 1),
  (79, 7, 'who digs a pit for another falls into it', 'idiomatic', 'dictionary_source', 1.00, 1),
  (82, 7, 'to hold one''s tongue', 'idiomatic', 'dictionary_source', 1.00, 1),
  (85, 7, 'to buy a pig in a poke', 'idiomatic', 'dictionary_source', 1.00, 1),
  (85, 7, 'to buy a cat in a sack', 'literal', 'dictionary_source', 0.90, 1),
  (86, 7, 'to buy a pig in a poke', 'idiomatic', 'dictionary_source', 1.00, 1),
  (88, 7, 'a bird in the hand is worth two in the bush', 'idiomatic', 'dictionary_source', 1.00, 1),
  (88, 7, 'better a sparrow in the hand than a pigeon on the branch', 'literal', 'dictionary_source', 0.90, 1);

INSERT INTO examples (word_id, language_id, sentence, translation, source, confidence, verified) VALUES
  (73, 1, 'Prestani da me vučeš za nos.', 'Stop leading me by the nose.', 'dictionary_source', 1.00, 1),
  (76, 1, 'Ne baci bisere pred svinje.', 'Do not cast pearls before swine.', 'dictionary_source', 1.00, 1),
  (79, 1, 'Ko drugome jamu kopa, sam u nju pada.', 'Who digs a pit for another falls into it.', 'dictionary_source', 1.00, 1),
  (82, 1, 'Drži jezik za zubima dok ne proverimo.', 'Hold your tongue until we check.', 'dictionary_source', 1.00, 1),
  (85, 1, 'Ne kupuj mačka u džaku.', 'Do not buy a pig in a poke.', 'dictionary_source', 1.00, 1),
  (86, 2, 'Ne kupuj mačka u vreći.', 'Do not buy a pig in a poke.', 'dictionary_source', 1.00, 1),
  (88, 1, 'Bolje vrabac u ruci nego golub na grani.', 'A bird in the hand is worth two in the bush.', 'dictionary_source', 1.00, 1);

INSERT INTO regional_variants (concept_id, word_id, country_code, note, difference_type) VALUES
  (5, 30, 'RS', 'Standard Serbian form.', 'different_word'),
  (5, 31, 'HR', 'Standard Croatian form.', 'different_word'),
  (5, 32, 'BA', 'Common Bosnian form.', 'different_word'),
  (5, 33, 'ME', 'Common Montenegrin form.', 'different_word'),
  (5, 34, 'SI', 'Slovenian.', 'different_word'),
  (5, 35, 'MK', 'Macedonian.', 'different_word'),
  (6, 37, 'RS', 'Standard Serbian form.', 'different_word'),
  (6, 38, 'HR', 'Standard Croatian form.', 'different_word'),
  (6, 39, 'BA', 'Majority everyday form; club names often FK.', 'frequency'),
  (6, 40, 'BA', 'Also used; treated as allowed, not the only form.', 'frequency'),
  (6, 41, 'ME', 'Common Montenegrin form.', 'different_word'),
  (6, 42, 'SI', 'Slovenian.', 'different_word'),
  (6, 43, 'MK', 'Macedonian.', 'different_word'),
  (7, 45, 'RS', 'Standard Serbian form.', 'different_word'),
  (7, 46, 'HR', 'Standard Croatian form.', 'different_word'),
  (7, 47, 'BA', 'Preferred Bosnian form; tisuća is allowed.', 'frequency'),
  (7, 48, 'ME', 'Common Montenegrin form.', 'different_word'),
  (8, 52, 'RS', 'Standard Serbian form.', 'different_word'),
  (8, 53, 'HR', 'Standard Croatian form.', 'different_word'),
  (9, 59, 'RS', 'Standard Serbian form.', 'different_word'),
  (9, 60, 'HR', 'Standard Croatian form.', 'different_word'),
  (10, 66, 'RS', 'Standard Serbian form.', 'different_word'),
  (10, 67, 'HR', 'Standard Croatian form.', 'different_word'),
  (15, 85, 'RS', 'džak is the common Serbian sack word in this idiom.', 'different_word'),
  (15, 86, 'HR', 'vreća is the common Croatian sack word in this idiom.', 'different_word'),
  (13, 79, 'RS', 'Headword with ko.', 'spelling'),
  (13, 80, 'HR', 'Headword with tko.', 'spelling');

INSERT INTO pages (word_id, pair, canonical_path, title, meta_description, indexable) VALUES
  (30, 'sr-en', '/sr-en/krompir', 'Krompir – značenje i regionalne varijante', 'Krompir u Srbiji, krumpir u Hrvatskoj. Engleski: potato.', 1),
  (37, 'sr-en', '/sr-en/fudbal', 'Fudbal – značenje i regionalne varijante', 'Fudbal u Srbiji, nogomet u Hrvatskoj. Engleski: football.', 1),
  (45, 'sr-en', '/sr-en/hiljada', 'Hiljada – značenje i regionalne varijante', 'Hiljada u Srbiji, tisuća u Hrvatskoj. Engleski: thousand.', 1),
  (52, 'sr-en', '/sr-en/fabrika', 'Fabrika – značenje i regionalne varijante', 'Fabrika u Srbiji, tvornica u Hrvatskoj. Engleski: factory.', 1),
  (59, 'sr-en', '/sr-en/pozoriste', 'Pozorište – značenje i regionalne varijante', 'Pozorište u Srbiji, kazalište u Hrvatskoj. Engleski: theatre.', 1),
  (66, 'sr-en', '/sr-en/muzika', 'Muzika – značenje i regionalne varijante', 'Muzika u Srbiji, glazba u Hrvatskoj. Engleski: music.', 1),
  (73, 'sr-en', '/sr-en/vuci-za-nos', 'Vući za nos – značenje, prevod i primeri', 'Šta znači vući za nos i kako se kaže na engleskom.', 1),
  (76, 'sr-en', '/sr-en/bacati-bisere-pred-svinje', 'Bacati bisere pred svinje – značenje i prevod', 'Idiom i engleski ekvivalent cast pearls before swine.', 1),
  (79, 'sr-en', '/sr-en/ko-drugome-jamu-kopa', 'Ko drugome jamu kopa – značenje i prevod', 'Poslovica i razlika ko / tko.', 1),
  (82, 'sr-en', '/sr-en/drzati-jezik-za-zubima', 'Držati jezik za zubima – značenje i prevod', 'Engleski: hold one''s tongue.', 1),
  (85, 'sr-en', '/sr-en/kupiti-macka-u-dzaku', 'Kupiti mačka u džaku – značenje i prevod', 'Srpski džak, hrvatski vreća. Engleski: buy a pig in a poke.', 1),
  (88, 'sr-en', '/sr-en/bolje-vrabac-u-ruci', 'Bolje vrabac u ruci – značenje i prevod', 'Engleski: a bird in the hand.', 1);

INSERT INTO word_search_keys (word_id, search_key, key_type) VALUES
  (30, 'krompir', 'normalized'),
  (31, 'krumpir', 'normalized'),
  (37, 'fudbal', 'normalized'),
  (38, 'nogomet', 'normalized'),
  (45, 'hiljada', 'normalized'),
  (46, 'tisuca', 'ascii'),
  (73, 'vuci za nos', 'ascii'),
  (76, 'bacati bisere pred svinje', 'normalized'),
  (79, 'ko drugome jamu kopa', 'normalized'),
  (80, 'tko drugome jamu kopa', 'normalized'),
  (82, 'drzati jezik za zubima', 'ascii'),
  (85, 'kupiti macka u dzaku', 'ascii'),
  (86, 'kupiti macka u vreci', 'ascii'),
  (88, 'bolje vrabac u ruci', 'normalized');
