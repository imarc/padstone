<?php
namespace Imarc\Padstone;

use ZipArchive;

class Install
{
    /**
     * This function returns an array of files that should not be extracted
     * from the craft.zip file.
     *
     * @return array
     */
    private static function skippedFiles()
    {
        return array(
            'craft/config/db.php',
            'craft/config/general.php',
            'craft/templates/404.html',
            'craft/templates/_layout.html',
            'craft/templates/index.html',
            'craft/templates/news',
            'craft/templates/news/_entry.html',
            'craft/templates/news/index.html',
            'craft/templates/web.config',
            'public/htaccess',
            'public/web.config',
        );
    }

    public static function run()
    {
        $install = new Install();
    }

    public function __construct()
    {
        $zip_file = 'craft_latest.zip';

        echo "Downloading Craft from https://craftcms.com/latest.zip...\n";

        $options  = [
            'http' => [
                'user_agent' => 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36'
            ]
        ];

        $context = stream_context_create($options);

        file_put_contents(
            $zip_file,
            file_get_contents("https://craftcms.com/latest.zip?accept_license=yes", false, $context)
        );

        echo "Created ZIP file '$zip_file'. Extracting contents...\n";

        $zip = new ZipArchive();
        if ($zip->open($zip_file) === true) {

            $files = array();
            for ($i = 0; $i < $zip->numFiles; $i++) {
                $files[] = $zip->getNameIndex($i);
            }

            $files = array_diff($files, static::skippedFiles());

            // only extract 250 files at a time
            $chunks = array_chunk($files, 250);
            foreach($chunks as $chunk) {
                $zip->extractTo('.', $chunk);
            }

            $zip->close();
        } else {
            echo "'$zipfile' is not a valid ZIP archive.\n";
            exit(1);
        }

        echo "Extraction complete.\n";
    }
}
