# Translation provider architecture

TranslationProviderInterface: LocalDictionaryProvider first, cache, OpusMtProvider if OPUSMT_URL is set, optional external off in MVP.

SH to EN: Helsinki-NLP/opus-mt-tc-big-sh-en (bos_Latn, hrv, srp_Cyrl, srp_Latn).
EN to SH: Helsinki-NLP/opus-mt-tc-base-en-sh with target tokens.

Between sr/hr/bs/cnr the UI must not invent precision.
