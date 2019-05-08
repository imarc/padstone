<p align="center">
    <img src="https://user-images.githubusercontent.com/1452/57405127-a7331580-71ab-11e9-8d16-0ee4a9c55328.jpg">
</p>



Padstone for Craft CMS
======================

Padstone is a starter package for Craft 3 built by Imarc. It provides a simple project config as well as example entries and templates.

_If you would like to use the older version of Padstone for Craft 2, see the [craft2 branch](https://github.com/imarc/padstone/tree/craft2)._

Features
--------

* Pre-built CMS sections, including ones for the Homepage, a Blog, News, and Resources. (18 in total!)
* A set of **Bootstrap 4** twig templates for you to replace or customize.
* A matrix-based **Content Designer** field, built within Craft, for laying out pages beyond simple rich text.
* A set of (free) plugins selected by Imarc that we recommend for new projects.

<img src="https://user-images.githubusercontent.com/1452/56689796-f0fb0680-66a9-11e9-8b4b-e66690ed9607.jpg">


Getting Started
---------------

Create a new padstone project with the following [composer](https://getcomposer.org/) command:

```sh
composer create-project imarc/padstone [folder]
```

Enter the newly created folder and run the front-end buildstep.

```sh
cd [folder]

npm install
npm run dev
```

[Create your database](https://craftcms.com/docs/installing#step-3-create-your-database) and ensure the settings in your `.env` match your environment. At minimum, you'll need to tell Craft how to connect to your database and your domain. Then run the installer by going to /admin (except for your domain.)

Optionally, you can import the supplied `padstone.sql` file into your database if you want Padstone's starter entries.

### Logging in

If you import `padstone.sql`, the username is *admin* and the password is *padstone*. Please change the password after you first login.

Front-End Build
------------------------

Beyond the typical craft files, you will also see a resources/ folder. Padstone
uses [Laravel Mix](https://laravel-mix.com/docs/4.0/basic-example) to compile JS and Sass files from the resources/ folder and store the results into the public/ folder:

* `resources/assets/sass/main.scss` is compiled to `public/css/main.css`
* `resources/assets/js/main.js` is compiled to `public/js/main.js`

Additionally, Padstone produces `manifest.js` and `vendor.js` files that
must be included, in that order, before any of your own JS files. You can
customize this behavior in `webpack.mix.js`.

### Watching/Building assets

While developing, you most likely want to watch the files you are working on,
so the build happens automatically after every save.

    npm run watch

If you want to run this same build process for dev without watching, you can
run the following:

    npm run dev

If you are building to production, run:

    npm run prod

What's Included
---------------

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

## License

Padstone is released under the MIT License.



<img src="https://user-images.githubusercontent.com/1452/56690112-b04fbd00-66aa-11e9-9e87-049b403cfa26.png" alt="Imarc" width="100">

© 2019 Imarc
