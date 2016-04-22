<?php
namespace Imarc\Padstone;

class Install
{
    static public function run()
    {
        $install = new Install(getcwd());
    }

    public function __construct($root)
    {
        echo "Installing to $root...\n";
        echo "done";
    }
}
