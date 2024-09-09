<?php
namespace modules\twigextensions;

/**
 * Provides the inflect Twig filter.
 */
class InflectionExtension extends \Twig\Extension\AbstractExtension
{
    /**
     * These are the all the adjective versions of numbers that aren't just the
     * noun version with th tacked on the end.
     */
    private static $number_adjectives = [
        1 => 'first',
        2 => 'second',
        3 => 'third',
        5 => 'fifth',
        6 => 'eighth',
        9 => 'ninth',
        12 => 'twelfth',
        20 => 'twentieth',
        30 => 'thirtieth',
        40 => 'fortieth',
        50 => 'fiftieth',
        60 => 'sixtieth',
        70 => 'seventieth',
        80 => 'eightieth',
        90 => 'ninetieth',
    ];

    /**
     * Noun versions of numbers. This (and a lot of the logic) is pulled from
     *
     * * http://www.karlrixon.co.uk/writing/convert-numbers-to-words-with-php/
     *
     */
    private static $number_nouns = [
        0 => 'zero',
        1 => 'one',
        2 => 'two',
        3 => 'three',
        4 => 'four',
        5 => 'five',
        6 => 'six',
        7 => 'seven',
        8 => 'eight',
        9 => 'nine',
        10 => 'ten',
        11 => 'eleven',
        12 => 'twelve',
        13 => 'thirteen',
        14 => 'fourteen',
        15 => 'fifteen',
        16 => 'sixteen',
        17 => 'seventeen',
        18 => 'eighteen',
        19 => 'nineteen',
        20 => 'twenty',
        30 => 'thirty',
        40 => 'fourty',
        50 => 'fifty',
        60 => 'sixty',
        70 => 'seventy',
        80 => 'eighty',
        90 => 'ninety',
        100 => 'hundred',
        1000 => 'thousand',
        1000000 => 'million',
        1000000000 => 'billion',
        1000000000000 => 'trillion',
        1000000000000000 => 'quadrillion',
        1000000000000000000 => 'quintillion',
    ];

    /**
     * These are regex rules for converting english words from singular to
     * plural form. They are shamelessly taken and modified from fGrammar
     * in Flourishlib.
     */
    private static $singular_to_plural_rules = [
        '(([ml])ouse$)' => '\1ice',
        '((media|info(rmation)?|news)$)' => '\1',
        '((phot|log|vide)o$)' => '\1os',
        '(^(q)uiz$)' => '\1uizzes',
        '((c)hild$)' => '\1hildren',
        '((p)erson$)' => '\1eople',
        '((m)an$)' => '\1en',
        '(([ieu]s|[ieuo]x)$)' => '\1es',
        '(([cs]h)$)' => '\1es',
        '((ss)$)' => '\1es',
        '(([aeo]l)f$)' => '\1ves',
        '(([^d]ea)f$)' => '\1ves',
        '((ar)f$)' => '\1ves',
        '(([nlw]i)fe$)' => '\1ves',
        '(([aeiou]y)$)' => '\1s',
        '(([^aeiou])y$)' => '\1ies',
        '(([^o])o$)' => '\1oes',
        '(s$)' => 'ses',
        '((.)$)' => '\1s',
    ];

    /**
     * Returns the name of the extension. Required.
     *
     * @return string
     */
    public function getName()
    {
        return 'Kindling Inflection Extension';
    }

    /**
     * Returns filters defined by this extension.
     *
     * @return array
     */
    public function getFilters()
    {
        return [
            new \Twig\TwigFilter('inflect', [$this, 'inflect']),
            new \Twig\TwigFilter('numberToWords', [$this, 'convertToWords']),
        ];
    }

    /**
     * This method is the logic for the inflect filter. You use it like this:
     *
     *     {{ count|inflect("day") }}
     *
     * before the pipe should come the number to inflect on. The first argument
     * after the pipe should be the singular form you'd like to display. The
     * singular form is passed through some basic english pluralization rules
     * to generate the plural form if necessary.
     *
     * Additionally, This argument came include any of the following formatters:
     *
     *     %d  The number passed in as a regular number (digits.)
     *     %n  The number passed written out (Ex: four thousand and twelve.)
     *     %a  The number passed Written out as an adjective (Ex: fifty-first.)
     *     %%  A literal percent. You only need to use this if you want to
     *         follow a literal percent with either a 'd', 'n', or 'a'.
     *
     * You can also supply an optional argument if you'd like to specify the
     * plural form directly.
     *
     * @param $num
     *     This the number to inflect upon. It can be negative and a fraction,
     *     but it's behave will degrade.
     * @param $phrase
     *     This should be the singular phrase to use. It can contain any of the
     *     formatters specified above.
     * @param $plural_phrase
     *     This is an optional phrase that can be supplied to specify exactly
     *     how plural should be displayed.
     *
     * @return string
     */
    public function inflect($num, $phrase, $plural_phrase = null)
    {
        if ($num != 1) {
            if ($plural_phrase === null) {
                $phrase = $this->pluralize($phrase);
            } else {
                $phrase = $plural_phrase;
            }
        }

        return $this->replaceFormatters($phrase, $num);

    }

    /**
     * Internal function; this handles replacing the formatters with their
     * expected values, including accounting for %%.
     *
     * @param $phase
     *     string to parse.
     * @param $num
     *     relevant number being used for inflection.
     *
     * @return string
     */
    private function replaceFormatters($phrase, $num)
    {
        $formatters = ['%d', '%n', '%a'];
        $values = [
            $num,
            $this->convertToWords($num),
            $this->convertToWords($num, true),
        ];

        return implode('%', array_map(
            function ($str) use ($formatters, $values) {
                return str_replace($formatters, $values, $str);
            },
            explode('%%', $phrase)
        ));
    }

    /**
     * Converts a number to words. Can either do it as a noun or as an
     * adjective. It's used internally by the inflect filter, but it's also
     * exposes as it's own filter than can be used like this:
     *
     *     {{ 345|numberToWords }}
     *     {{ 345|numberToWords(true) }}
     *
     * The first line returns "three hundred and forty-five"; the second
     * returns "three hundred and forty-fifth".
     *
     * @param $num
     *     number to convert.
     * @param $adjective
     *     Whether to return it as a noun (default), or adjective.
     *
     * @return string
     */
    public function convertToWords($num, $adjective = false)
    {
        if (strpos($num, '.') !== false) {
            return $num;
        }

        if ($num < 0) {
            return "negative " . $this->convertToWords(-1 * $num);
        }

        if (isset(static::$number_nouns[$num])) {
            if ($adjective) {
                if (isset(static::$number_adjectives[$num])) {
                    $str = static::$number_adjectives[$num];
                } else {
                    $str = static::$number_nouns[$num] . 'th';
                }
            } else {
                $str = static::$number_nouns[$num];
            }

        } elseif ($num < 100) {
            $remainder = $num % 10;
            $str = $this->convertToWords($num - $remainder)
            . '-' . $this->convertToWords($remainder, $adjective);

        } elseif ($num < 1000) {
            $hundreds = (int) ($num / 100);
            $remainder = $num % 100;
            $str = $this->convertToWords($hundreds);
            $str .= ' ' . $this->convertToWords(100);

            if ($remainder) {
                $str .= ' and ' . $this->convertToWords($remainder, $adjective);
            } elseif ($adjective) {
                $str .= 'th';
            }

        } else {
            $largestUnit = pow(1000, floor(log($num, 1000)));
            $numLargest = (int) ($num / $largestUnit);
            $remainder = $num % $largestUnit;

            $str = $this->convertToWords($numLargest);
            $str .= ' ' . $this->convertToWords($largestUnit);

            if ($remainder) {
                if ($remainder < 100) {
                    $str .= ' and ';
                } else {
                    $str .= ', ';
                }
                $str .= $this->convertToWords($remainder, $adjective);
            } elseif ($adjective) {
                $str .= 'th';
            }
        }

        return $str;
    }

    /**
     * Converts $phase to plural.
     *
     * @param $phrase
     *     text to convert.
     *
     * @return string.
     */
    private function pluralize($phrase)
    {
        $before = '';
        $last_word = $phrase;

        if (strpos($phrase, ' ') !== false) {
            $before = substr($phrase, 0, strrpos($phrase, ' ') + 1);
            $last_word = substr($phrase, strrpos($phrase, ' ') + 1);
        }

        foreach (self::$singular_to_plural_rules as $from => $to) {
            if (preg_match($from, $last_word)) {
                $last_word = preg_replace($from, $to, $last_word);
                break;
            }
        }

        if ($before) {
            return "$before $last_word";
        } else {
            return $last_word;
        }
    }
}
