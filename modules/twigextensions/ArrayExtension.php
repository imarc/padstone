<?php
namespace modules\twigextensions;
class ArrayExtension extends \Twig\Extension\AbstractExtension
{
    /**
     * @return string
     */
    public function getName()
    {
        return 'Kindling Array Extension';
    }
    /**
     * @return array
     */
    public function getFunctions()
    {
        return [
            new \Twig\TwigFunction('intersect', [$this, 'intersect']),
            new \Twig\TwigFunction('unique', [$this, 'unique']),
            new \Twig\TwigFunction('shuffle', [$this, 'shuffle']),
            new \Twig\TwigFunction('prepend', [$this, 'prepend']),
            new \Twig\TwigFunction('append', [$this, 'append']),
            new \Twig\TwigFunction('shift', [$this, 'shift']),
            new \Twig\TwigFunction('pop', [$this, 'pop']),
        ];
    }
    /**
     * @return array
     */
    public function intersect() 
    {
        $args = func_get_args();
        return call_user_func_array('array_intersect', $args);
    }
    /**
     * @return array
     */
    public function unique() 
    {
        $args = func_get_args();
        return call_user_func_array('array_unique', $args);
    }
    /**
     * @return array
     */
    public function shuffle() 
    {
        $args = func_get_args();
        $arr = $args[0];
        return shuffle($arr);
    }
    /**
     * @return array
     */
    public function append() {
        $args = func_get_args();
        $temp = array_shift($args);
        array_unshift($args, $temp);
        call_user_func_array('array_push', $args);
        return $temp;
    }
    /**
     * @return array
     */
    public function prepend() {
        $args = func_get_args();
        $temp = array_shift($args);
        array_unshift($args, $temp);
        call_user_func_array('array_unshift', $args);
        return $temp;
    }
    /**
     * @return mixed
     */
    public function shift() 
    {
        $args = func_get_args();
        return call_user_func_array('array_shift', $args);
    }
    /**
     * @return mixed
     */
    public function pop() 
    {
        $args = func_get_args();
        return call_user_func_array('array_pop', $args);
    }
}