Padstone (Docker Branch)
========================

Padstone is a start for using Craft CMS that works with `composer create-project` and [composer/installers](https://github.com/composer/installers) to streamline initial site creation.

Usage
-----

Install padstone by running the following [composer](https://getcomposer.org/) command in a terminal:

```sh
composer create-project imarc/padstone [folder] dev-docker
```

Go into the project folder you just create, and then bootstrap your entire development environment with:

```sh
docker-compose up
```

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
* [Kindling](https://github.com/imarc/craft-kindling)
* [Reroute](https://github.com/itmundi/reroute)
* [Sass](https://github.com/imarc/craft-sass)
* [Social](https://github.com/imarc/craft-social)


### Macros

There is a `_macros.twig` file that (so far) just provides a macro for generating pagination.



Changelog
---------

### 1.2.0

* Added [craft-kindling](https://github.com/imarc/craft-kindling), and swapped
  out the templates included in the ZIP for some provided by Padstone.


### 1.1.0

* Added [itmundi/schematic](https://github.com/itmundi/schematic) and a basic
  schema that includes a sections for Pages, Blog, and Team.

### 1.0.2

* Added updated `config/general.php` and `config/db.php`.

### 1.0.0

* initial release
