<?php
namespace modules\twigextensions;

/**
 * Provides the wrapembeds Twig filter, which currently wraps iframes
 * within the input with:
 *
 * <div class="responsive_video">...</div>
 *
 */

class WrapEmbedsExtension extends \Twig\Extension\AbstractExtension
{

    public function getName()
    {
        return 'WrapEmbeds Twig Extension';
    }

    public function getFilters()
    {
        return [
            new \Twig\TwigFilter('wrapembeds', [$this, 'wrapembeds'], ['is_safe' => ['html']]),
        ];
    }

    public function wrapembeds($content)
    {
        return preg_replace('(<iframe.+?iframe>)si', '<div class="responsive_video">\0</div>', $content);
    }

}
