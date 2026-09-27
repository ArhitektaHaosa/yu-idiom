-- yu-idiom MariaDB schema
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

CREATE TABLE IF NOT EXISTS languages (
  id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  code VARCHAR(8) NOT NULL,
  bcp47 VARCHAR(16) NOT NULL,
  name_en VARCHAR(64) NOT NULL,
  name_native VARCHAR(64) NOT NULL,
  default_script ENUM('Latn','Cyrl') NOT NULL DEFAULT 'Latn',
  sort_order TINYINT UNSIGNED NOT NULL DEFAULT 0,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (id),
  UNIQUE KEY uq_languages_code (code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS concepts (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  slug VARCHAR(190) NOT NULL,
  gloss_en VARCHAR(255) DEFAULT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_concepts_slug (slug)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS words (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  language_id TINYINT UNSIGNED NOT NULL,
  concept_id INT UNSIGNED DEFAULT NULL,
  lemma VARCHAR(190) NOT NULL,
  display_form VARCHAR(190) NOT NULL,
  normalized VARCHAR(190) NOT NULL,
  slug VARCHAR(190) NOT NULL,
  script ENUM('Latn','Cyrl') NOT NULL DEFAULT 'Latn',
  pos VARCHAR(32) DEFAULT NULL,
  gender VARCHAR(16) DEFAULT NULL,
  number_form VARCHAR(16) DEFAULT NULL,
  aspect VARCHAR(16) DEFAULT NULL,
  frequency INT UNSIGNED DEFAULT NULL,
  region VARCHAR(32) DEFAULT NULL,
  register_tag VARCHAR(32) DEFAULT NULL,
  is_phrase TINYINT(1) NOT NULL DEFAULT 0,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_words_lang_slug_script (language_id, slug, script),
  KEY idx_words_normalized (normalized),
  KEY idx_words_lemma (lemma),
  KEY idx_words_concept (concept_id),
  CONSTRAINT fk_words_language FOREIGN KEY (language_id) REFERENCES languages (id),
  CONSTRAINT fk_words_concept FOREIGN KEY (concept_id) REFERENCES concepts (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS word_search_keys (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  word_id INT UNSIGNED NOT NULL,
  search_key VARCHAR(190) NOT NULL,
  key_type ENUM('normalized','ascii','translit','prefix') NOT NULL,
  PRIMARY KEY (id),
  KEY idx_wsk_key (search_key),
  KEY idx_wsk_word (word_id),
  CONSTRAINT fk_wsk_word FOREIGN KEY (word_id) REFERENCES words (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS word_forms (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  word_id INT UNSIGNED NOT NULL,
  form VARCHAR(190) NOT NULL,
  normalized VARCHAR(190) NOT NULL,
  feature VARCHAR(64) DEFAULT NULL,
  verified TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  KEY idx_wf_word (word_id),
  KEY idx_wf_normalized (normalized),
  CONSTRAINT fk_wf_word FOREIGN KEY (word_id) REFERENCES words (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS definitions (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  word_id INT UNSIGNED NOT NULL,
  language_id TINYINT UNSIGNED NOT NULL,
  text TEXT NOT NULL,
  sense_order TINYINT UNSIGNED NOT NULL DEFAULT 1,
  source VARCHAR(32) NOT NULL DEFAULT 'dictionary_source',
  confidence DECIMAL(3,2) NOT NULL DEFAULT 1.00,
  verified TINYINT(1) NOT NULL DEFAULT 0,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY idx_def_word (word_id),
  CONSTRAINT fk_def_word FOREIGN KEY (word_id) REFERENCES words (id) ON DELETE CASCADE,
  CONSTRAINT fk_def_lang FOREIGN KEY (language_id) REFERENCES languages (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS translations (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  source_word_id INT UNSIGNED NOT NULL,
  target_language_id TINYINT UNSIGNED NOT NULL,
  text VARCHAR(255) NOT NULL,
  kind ENUM('literal','natural','idiomatic','alternative') NOT NULL DEFAULT 'natural',
  source VARCHAR(32) NOT NULL DEFAULT 'dictionary_source',
  confidence DECIMAL(3,2) NOT NULL DEFAULT 1.00,
  verified TINYINT(1) NOT NULL DEFAULT 0,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY idx_tr_source (source_word_id),
  KEY idx_tr_target (target_language_id),
  CONSTRAINT fk_tr_source FOREIGN KEY (source_word_id) REFERENCES words (id) ON DELETE CASCADE,
  CONSTRAINT fk_tr_lang FOREIGN KEY (target_language_id) REFERENCES languages (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS examples (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  word_id INT UNSIGNED NOT NULL,
  language_id TINYINT UNSIGNED NOT NULL,
  sentence TEXT NOT NULL,
  translation TEXT DEFAULT NULL,
  source VARCHAR(32) NOT NULL DEFAULT 'dictionary_source',
  confidence DECIMAL(3,2) NOT NULL DEFAULT 1.00,
  verified TINYINT(1) NOT NULL DEFAULT 0,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY idx_ex_word (word_id),
  CONSTRAINT fk_ex_word FOREIGN KEY (word_id) REFERENCES words (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS synonyms (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  word_id INT UNSIGNED NOT NULL,
  synonym_word_id INT UNSIGNED NOT NULL,
  note VARCHAR(255) DEFAULT NULL,
  verified TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  KEY idx_syn_word (word_id),
  CONSTRAINT fk_syn_word FOREIGN KEY (word_id) REFERENCES words (id) ON DELETE CASCADE,
  CONSTRAINT fk_syn_syn FOREIGN KEY (synonym_word_id) REFERENCES words (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS antonyms (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  word_id INT UNSIGNED NOT NULL,
  antonym_word_id INT UNSIGNED NOT NULL,
  note VARCHAR(255) DEFAULT NULL,
  verified TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  KEY idx_ant_word (word_id),
  CONSTRAINT fk_ant_word FOREIGN KEY (word_id) REFERENCES words (id) ON DELETE CASCADE,
  CONSTRAINT fk_ant_ant FOREIGN KEY (antonym_word_id) REFERENCES words (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS phrases (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  word_id INT UNSIGNED NOT NULL,
  phrase_type ENUM('idiom','collocation','proverb','slang','other') NOT NULL DEFAULT 'idiom',
  literal_gloss TEXT DEFAULT NULL,
  figurative_gloss TEXT DEFAULT NULL,
  origin_note TEXT DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY uq_phrases_word (word_id),
  CONSTRAINT fk_ph_word FOREIGN KEY (word_id) REFERENCES words (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS regional_variants (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  concept_id INT UNSIGNED NOT NULL,
  word_id INT UNSIGNED NOT NULL,
  country_code CHAR(2) NOT NULL,
  note VARCHAR(255) DEFAULT NULL,
  difference_type ENUM('different_word','spelling','frequency','regionalism','archaism','colloquial','vulgar','jargon','technical') NOT NULL DEFAULT 'different_word',
  PRIMARY KEY (id),
  KEY idx_rv_concept (concept_id),
  CONSTRAINT fk_rv_concept FOREIGN KEY (concept_id) REFERENCES concepts (id) ON DELETE CASCADE,
  CONSTRAINT fk_rv_word FOREIGN KEY (word_id) REFERENCES words (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS pronunciations (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  word_id INT UNSIGNED NOT NULL,
  ipa VARCHAR(190) DEFAULT NULL,
  respelling VARCHAR(190) DEFAULT NULL,
  bcp47 VARCHAR(16) DEFAULT NULL,
  PRIMARY KEY (id),
  KEY idx_pr_word (word_id),
  CONSTRAINT fk_pr_word FOREIGN KEY (word_id) REFERENCES words (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS etymologies (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  word_id INT UNSIGNED NOT NULL,
  text TEXT NOT NULL,
  source VARCHAR(32) NOT NULL DEFAULT 'dictionary_source',
  verified TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  KEY idx_et_word (word_id),
  CONSTRAINT fk_et_word FOREIGN KEY (word_id) REFERENCES words (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS tags (
  id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  slug VARCHAR(64) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY uq_tags_slug (slug)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS word_tags (
  word_id INT UNSIGNED NOT NULL,
  tag_id SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (word_id, tag_id),
  CONSTRAINT fk_wt_word FOREIGN KEY (word_id) REFERENCES words (id) ON DELETE CASCADE,
  CONSTRAINT fk_wt_tag FOREIGN KEY (tag_id) REFERENCES tags (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS pages (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  word_id INT UNSIGNED NOT NULL,
  pair VARCHAR(16) NOT NULL,
  canonical_path VARCHAR(255) NOT NULL,
  title VARCHAR(255) DEFAULT NULL,
  meta_description VARCHAR(320) DEFAULT NULL,
  indexable TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  UNIQUE KEY uq_pages_path (canonical_path),
  KEY idx_pages_word (word_id),
  CONSTRAINT fk_pages_word FOREIGN KEY (word_id) REFERENCES words (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS translation_cache (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  source_lang VARCHAR(8) NOT NULL,
  target_lang VARCHAR(8) NOT NULL,
  source_hash CHAR(64) NOT NULL,
  source_text TEXT NOT NULL,
  result_json JSON NOT NULL,
  provider VARCHAR(32) NOT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_tc_hash (source_lang, target_lang, source_hash)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS search_log (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  day_bucket DATE NOT NULL,
  query_normalized VARCHAR(190) NOT NULL,
  source_lang VARCHAR(8) DEFAULT NULL,
  target_lang VARCHAR(8) DEFAULT NULL,
  result_count INT UNSIGNED NOT NULL DEFAULT 0,
  hits INT UNSIGNED NOT NULL DEFAULT 1,
  PRIMARY KEY (id),
  UNIQUE KEY uq_sl_day_q (day_bucket, query_normalized, source_lang, target_lang)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS missing_words (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  query_display VARCHAR(190) NOT NULL,
  query_normalized VARCHAR(190) NOT NULL,
  source_lang VARCHAR(8) DEFAULT NULL,
  hit_count INT UNSIGNED NOT NULL DEFAULT 1,
  status ENUM('open','ignored','added') NOT NULL DEFAULT 'open',
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_missing_q (query_normalized, source_lang)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS suggestions (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  word_id INT UNSIGNED DEFAULT NULL,
  payload TEXT NOT NULL,
  kind ENUM('better_translation','example','correction','new_word') NOT NULL,
  status ENUM('queued','accepted','rejected') NOT NULL DEFAULT 'queued',
  source VARCHAR(32) NOT NULL DEFAULT 'user_suggested',
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS votes (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  word_id INT UNSIGNED NOT NULL,
  useful TINYINT(1) NOT NULL,
  day_bucket DATE NOT NULL,
  PRIMARY KEY (id),
  KEY idx_votes_word (word_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET FOREIGN_KEY_CHECKS = 1;

INSERT INTO languages (code, bcp47, name_en, name_native, default_script, sort_order) VALUES
  ('sr',  'sr-RS', 'Serbian', 'srpski', 'Latn', 1),
  ('hr',  'hr-HR', 'Croatian', 'hrvatski', 'Latn', 2),
  ('bs',  'bs-BA', 'Bosnian', 'bosanski', 'Latn', 3),
  ('cnr', 'sr-ME', 'Montenegrin', 'crnogorski', 'Latn', 4),
  ('sl',  'sl-SI', 'Slovenian', 'slovenščina', 'Latn', 5),
  ('mk',  'mk-MK', 'Macedonian', 'македонски', 'Cyrl', 6),
  ('en',  'en-GB', 'English', 'English', 'Latn', 7)
ON DUPLICATE KEY UPDATE name_en = VALUES(name_en);

INSERT INTO tags (slug) VALUES
  ('formal'),('informal'),('colloquial'),('slang'),('vulgar'),
  ('archaic'),('dialectal'),('technical'),('medical'),('legal'),
  ('computing'),('internet'),('literary'),('idiom')
ON DUPLICATE KEY UPDATE slug = VALUES(slug);
