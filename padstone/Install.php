<?php
namespace Imarc\Padstone;

class Install
{
    static public function run()
    {
        $install = new Install();
    }

    public function __construct()
    {
        $zip_file = 'craft_' . date('c') . '.zip';

        echo "Downloading Craft from https://craftcms.com/latest.zip...\n";

        file_put_contents(
            $zip_file,
            fopen("https://craftcms.com/latest.zip?accept_license=yes", "r")
        );

        echo "Created ZIP file '$zip_file'. Extracting contents...\n";

        $zip = new ZipArchive();
        if ($zip->open($zip_file) === true) {
            $zip->extractTo('.');
            $zip->close();
        } else {
            echo "'$zipfile' is not a valid ZIP archive.\n";
            exit(1);
        }

        echo "Extraction complete.\n";
    }
}
