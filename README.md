Padstone
========

Padstone is a starter package for Craft 3 built by Imarc. It provides a simple project config as well as example entries and templates.

If you would like to use the older version of Padstone for Craft 2, see the [craft2 branch](https://github.com/imarc/padstone/tree/craft2).


What's Included
---------------

Padstone includes the following:

* **Eighteen CMS Sections**, including the Homepage, a Blog, News and Resources.
* A set of **Bootstrap 4 based Twig Templates** for you to replace or customize.
* A block-based **Content Designer** Field, built within the CMS, for building out pages with layout.


### Sections

Padstone includes the following sections:

* **Homepage**
* **Blog Page** and **Blog Articles**
* **News & Events Page**, **News Articles**, and **Events**
* **Resources Page** and **Resources**
* **About Page**, **Leadership Page**, **Contact Page**, **Privacy Page**, **People**
* Custom **Landing Pages**
* **Error Page** and **404 Page**


### Plugins

The following plugins are currently included and installed via [composer](https://getcomposer.org/), which is what Craft uses for the Plugin Store as well:

* [Admin Bar](https://plugins.craftcms.com/admin-bar)
* [CodeMirror](https://plugins.craftcms.com/code-mirror)
* [Contact Form](https://plugins.craftcms.com/contact-form)
* [Contact Form Honeypot](https://plugins.craftcms.com/contact-form-honeypot)
* [Craft Kindling](https://github.com/imarc/craft-kindling)
* [Expanded Singles](https://plugins.craftcms.com/expanded-singles)
* [Google Custom Search](https://github.com/imarc/craft-googlecustomsearch)
* [Mix](https://plugins.craftcms.com/mix)
* [Position Fieldtype](https://plugins.craftcms.com/position-fieldtype)
* [Redactor](https://plugins.craftcms.com/redactor)
* [Redirect Manager](https://plugins.craftcms.com/redirect)
* [Tags](https://plugins.craftcms.com/tag-manager)
* [Typed link field](https://plugins.craftcms.com/typedlinkfield)
* [Field Manager](https://plugins.craftcms.com/field-manager) - this is included, but not installed by default.


#### Suggested Additional Plugins

These plugins didn't make the cut for Padstone, but they are plugins we'd recommend people look at if they have specific needs:

* [Element API](https://plugins.craftcms.com/element-api) - easy creation of JSON APIs for your website. Likely to be included in the next version of Padstone. Free.
* [Feed Me](https://plugins.craftcms.com/feed-me) - import content into craft from XML, CSV, and other kinds of exports. Currently Pro is $99 and $30/year.
* [Guide](https://plugins.craftcms.com/guide) - add documentation with Craft. Currently $39 and $19/year.
* [Retour](https://plugins.craftcms.com/retour) - if the included Redirect Manager plugin isn't powerful enough, Retour provides some additional functionality and reporting beyond what Redirect Manager does. Currently $59 and $29/year.


### Macros

There is a `_macros.twig` file that provides The following macros:

* **renderAllBlocks** and **renderBlock** - these are used to render the designedContent field.
* **pagination** - used to generate pagination.
* **commaSeparate** - used to generate a comma separated list of elements based on title.


### Blocks

The **Content Designer** Field (designedContent) allows CMS users to use the following blocks out of the box:

* Rich Text
* Two Columns
* Image with Text
* Video with Text
* Testimonial
* HTML Widget/Embed
* Call to Action
* Shared Block


Getting Started
---------------

Start out with Padstone by running the following [composer](https://getcomposer.org/) command in a terminal:

```sh
composer create-project imarc/padstone [folder]
```

This command downloads Padstone, Craft, and all of the plugins.

At this point, you'll need to [Create your database](https://docs.craftcms.com/v3/installation.html#step-4-create-a-database) as you would a normal Craft install.

Next, you should edit the `.env` file to match your site's hosting. At minimum, you'll need to tell Craft how to connect to your database and your domain.

Now, you can run the installer by going to http://example.com/admin (except for your domain.)

Lastly, import the padstone.sql file into your database. This will populate the database with Padstone's starter entries. Technically, you can skip this step if you don't want that content.

You will also want to run `npm install` and `npm run dev` at least once; see the "Usage During Development" section below for more details.

At this point, you're done!

### Logging in

By default, the username is Craft's default of **admin** with the password **padstone**. Please change the password after you first login.


### Local Usage

While the previous version of Padstone shipped with a `docker-compose.yml` file, we're no longer providing that. Feel free to use Padstone with whatever local development app you'd like - be it [imarc/ops](https://github.com/imarc/ops), [Laravel Valet](https://laravel.com/docs/master/valet), [ddev](https://ddev.readthedocs.io/en/stable/), etc.


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

* resources/assets/sass/main.scss is compiled to public/css/main.css
* resources/assets/js/main.js is compiled to public/js/main.js

Additionally, Padstone produces **manifest.js** and **vendor.js** files that
must be included, in that order, before any of your own JS files. You can
customize this behavior in `webpack.mix.js`.



Changelog
---------

### 3.0.0

* Major version for Craft 3, including new plugins, templates, fields and more! Not remotely backwards compatible.

### 2.1.0

* Add latest Boilerplate

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
