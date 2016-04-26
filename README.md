Padstone
========

Padstone is a start for using Craft CMS that works with `composer create-project` and [composer/installers](https://github.com/composer/installers) to streamline initial site creation.


What's Included
---------------

Padstone includes the following:

### Sections

* **Meta Fields** - a common Meta Description and Title tag override field are included.
* **Blog Section** - this channel section is built out with Title, Description, Content, and the above meta fields.
* **Pages Section** - this structure section is built out with a the meta fields above, as well as a Structured Content matrix field that supports the following block types:
    * Full Width
    * Two Columns
    * Three Columns
    * Video with Text
    * Image with Text
    * Testimonial
* **Team Section** - this structure section is built out with fields for Name, Photo, and Bio.


### Plugins

The following plugins are currently included and installed via [composer/installers](https://github.com/composer/installers) and are referenced in the composer.json file.

* [Boost](https://github.com/imarc/craft-boost)
* [Google Custom Search](https://github.com/imarc/craft-googlecustomsearch)
* [Reroute](https://github.com/itmundi/reroute)
* [Sass](https://github.com/imarc/craft-sass)
* [Social](https://github.com/imarc/craft-social)




Usage
-----

Start out with Padstone by running the following [composer](https://getcomposer.org/) command in a terminal:

```sh
composer create-project imarc/padstone [folder]
```

This command downloads Padstone, Craft, and some hand-selected Craft plugins, and puts everything in the right place.

At this point, you'll need to [Create your database](https://craftcms.com/docs/installing#step-3-create-your-database) as you would a normal Craft install.

Next, you should edit both `craft/config/general.php` and `craft/config/db.php` to match your site. At the minimum, you should **replace all the places it says example.com** with your site's domain.

Now, you can run the installer by going to http://example.com/admin (except for your domain.)

Lastly, in a terminal on the server in your new folder, run

```sh
vendor/bin/schematic import
```

This imports the schema.yml file, creating fields, enabling the plugins, etc.

At this point, you're done. Feel free to delete the Craft ZIP, The `padstone/` directory, or the `craft/config/schema.yml` file.


Changelog
---------


### 1.1.0

* Added [itmundi/schematic](https://github.com/itmundi/schematic) and a basic schema that includes a sections for Pages, Blog, and Team.

### 1.0.2

* Added updated `config/general.php` and `config/db.php`.

### 1.0.0

* initial release
