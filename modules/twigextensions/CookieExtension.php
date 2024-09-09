<?php
namespace modules\twigextensions;

/**
 * This extension provides a single twig function, cookie(), that provides
 * access to setcookie() and getting cookie values.
 */
class CookieExtension extends \Twig\Extension\AbstractExtension
{
    /**
     * @return string
     */
    public function getName()
    {
        return 'Kindling Cookie Manipulation';
    }

    /**
     * @return array
     */
    public function getFunctions()
    {
        return [
            new \Twig\TwigFunction('cookie', [$this, 'cookie']),
        ];
    }

    /**
     * The method signature here matches setcookie() with one exception; if
     * $name is provided but no other arguments are provided, it returns the
     * current cookie value of $name (if it exists).
     *
     * @name string
     *     Key.
     * @value string
     *     Value to store.
     * @expire int
     *     Timestamp (in seconds) of when to expire the cookie. Set this in the
     *     past to immediately expire (and delete) this cookie.
     * @path string
     *     Path on the server to restrict the cookie to.
     * @domain string
     *     The doman (or subdomain) that the cookie is restricted to.
     * @secure boolean
     *     Whether the cookie should only be transmitted over HTTPS.
     * @httponly boolean
     *     Whether the cookie should only be accessible via HTTP (and not JS.)
     */
    public function cookie(
        $name,
        $value = null,
        $expire = 0,
        $path = "",
        $domain = "",
        $secure = false,
        $httponly = false
    ) {
        if ($value === null) {
            return isset($_COOKIE[$name]) ? $_COOKIE[$name] : null;
        } else {
            setcookie($name, $value, (int) $expire, $path, $domain, $secure, $httponly);
            if ($expire > time()) {
                $_COOKIE[$name] = $value;
            }
        }
    }
}
