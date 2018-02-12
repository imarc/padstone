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

* [Better Redactor](https://github.com/imarc/craft-betterredactor)
* [Boost](https://github.com/imarc/craft-boost)
* [Google Custom Search](https://github.com/imarc/craft-googlecustomsearch)
* [Kindling](https://github.com/imarc/craft-kindling)
* [Retour](https://github.com/nystudio107/retour)
* [Social](https://github.com/imarc/craft-social)
* [Field Manager](https://github.com/engram-design/FieldManager)
* [Tag Manager](https://github.com/boboldehampsink/tagmanager)


### Macros

There is a `_macros.twig` file that (so far) just provides a macro for generating pagination.


Getting Started
---------------

Start out with Padstone by running the following [composer](https://getcomposer.org/) command in a terminal:

```sh
composer create-project imarc/padstone [folder]
```

This command downloads Padstone, Craft, and some hand-selected Craft plugins, and puts everything in the right place.

At this point, you'll need to [Create your database](https://craftcms.com/docs/installing#step-3-create-your-database) as you would a normal Craft install.

Next, you should edit both `.env` and `craft/config/db.php` to match your site. At the minimum, you should add the site domain, database info, and remove any unused fields from .env and the db.php file. If using multiple environments, copy the .env to each environment and update to match that environment's database, domain, etc.

Now, you can run the installer by going to http://example.com/admin (except for your domain.)

Lastly, in a terminal on the server in your new folder, run

```sh
vendor/bin/schematic import
```

This imports the schema.yml file, creating fields, enabling the plugins, etc.

You will also want to run `npm install` and `npm run dev` at least once; see the "Usage During Development" section below for more details.

At this point, you're done. Feel free to delete the Craft ZIP, The `padstone/` directory, or the `craft/config/schema.yml` file.

### Local Usage

Start local environment with Docker:

    docker-compose up -d

One first run, install craft and schema and initial admin user:

    docker exec -i $(docker-compose ps -q craft) bash scripts/install.sh

Shut down local environment:

    docker-compose stop

Destroy local environment:

    # CAUTION! This will destroy all data volumes, such as the database and uploads!
    # DO NOT RUN THIS UNLESS YOU ARE SURE ALL PERSISTANT DATA CAN BE DELETED
    docker-compose down -v


Usage During Development
------------------------

To install all npm dependencies:

    npm install

### Watching/Building all assets for Development

While developing, you most likely want to watch the files you are working on,
so the build happens automatically after every save.

    npm run watch

If you want to run this same build process for dev without watching, you can
run the following:

    npm run dev

### Building all assets for Production

Unless your project is using a deploy buildstep Before committing to production

    npm run prod



File Structure
--------------

Beyond the typical craft files, you will also see a resources/ folder. Padstone
uses Laravel Mix to compile JS and Sass files from the resources/ folder and
store the results into the public/ folder:

* resources/assets/sass/styles.scss is compiled to public/css/styles.css
* resources/assets/js/site.js is compiled to public/js/site.js

Additionally, Padstone produces **manifest.js** and **vendor.js** files that
must be included, in that order, before any of your own JS files. You can
customize this behavior in `webpack.mix.js`.



Changelog
---------

### 2.0.0

* Switch from craft-sass to use Laravel Mix for Sass/JS compilation

### 1.6.0

* Merge in pull request from @jeffturcotte, which did all the following
* Add support for local development
* Add dotenv support
* Add editorconfig and other cleanup

### 1.5.0

* Add latest Boilerplate

### 1.4.0

* Added [Better Redactor](https://github.com/imarc/craft-betterreddactor)

### 1.3.0

* Added [Retour](https://github.com/nystudio107/retour), replacing Reroute for
  handling redirects. Retour provides more features, allows for regex in
  redirects, and provides a statistics widget for the dashboard.
* Removed Reroute
* Added [Field Manager](https://github.com/engram-design/FieldManager).
* Added [Tag Manager](https://github.com/boboldehampsink/tagmanager), primarily
  because stock Craft doesn't seem to provide a away to delete tags.

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
