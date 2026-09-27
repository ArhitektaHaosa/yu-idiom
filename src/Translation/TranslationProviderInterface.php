<?php
declare(strict_types=1);

namespace YuIdiom\Translation;

interface TranslationProviderInterface
{
    public function name(): string;
    public function supports(string $source, string $target): bool;
    public function translate(string $text, string $source, string $target): array;
}
