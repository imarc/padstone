<?php
namespace modules\twigextensions;
class LinkingExtension extends \Twig\Extension\AbstractExtension
{
    /**
     * @return string
     */
    public function getName()
    {
        return 'Kindling Linking Extension';
    }
    /**
     * @return array
     */
    public function getFunctions()
    {
        return [
            new \Twig\TwigFunction('linkify', [$this, 'linkify']),
        ];
    }
    /**
     */
    public function linkify($string)
    {
        if (empty($string)) {
            return '';
        }
        $replacements = [
            "~[[:alpha:]]+://[^<>[:space:]]+[[:alnum:]/]~" => "<a href=\"\\0\">\\0</a>",
            "~(\S+@\S+\.\S+)~" => "<a href=\"mailto:\\0\">\\0</a>",
        ];
        foreach ($replacements as $regex => $replace) {
            $string = preg_replace($regex, $replace, $string);
        }
        return $string;
    }
}