<p align="center">
    <img src="https://user-images.githubusercontent.com/1452/57405127-a7331580-71ab-11e9-8d16-0ee4a9c55328.jpg">
</p>

# Padstone for Craft CMS

Padstone is a starter package for Craft 5 built by Imarc. It provides a simple project config as well as example entries and templates.

## Features

* Pre-built CMS sections, including ones for the Homepage, a Blog, News, and Resources. (18 in total!)
* A **Content Designer**, built within Craft, for laying out pages beyond simple rich text.
* A set of plugins selected by Imarc that we recommend for new projects.

## Getting Started

Create a new padstone project with the following [composer](https://getcomposer.org/) command:

```sh
composer create-project imarc/padstone [folder] --ignore-platform-reqs
```

### Using [ops](https://github.com/imarc/ops) (the fast way)

Go into your the new project folder, and run

```sh
ops padstone-install
```

This will run all the following steps, including prompting you for values to add to your .env file. You likely want to leave DB_SERVER as `mariadb` (the default), but you can change the other settings if you'd like.


### The manual way

0. Copy .env.example to be .env and update settings inside. In particular, CRAFT_DB_DATABASE, CRAFT_DB_SERVER, CRAFT_DB_USER and CRAFT_DB_PASSWORD.
0. Run `./craft setup/keys` to generate a SECURITY_KEY for your .env file.
0. If you'd like to use Padstone's SQL file, import padstone.sql into your site.

## Logging in

If you use the ops method or import `padstone.sql` manually, the username is *admin* and the password is *padstone*. Please change the password after you first login.

## Front-End Build

TBD

### Watching/Building assets

While developing, you most likely want to watch the files you are working on,
so the build happens automatically after every save.

    npm run dev

If you are building to production, run:

    npm run prod

## What's Included

### Sections [WIP]

Padstone includes the following sections:

* **Homepage**
* **Pages** with entry types for **Blog**, **News**, **Resources**, **Team**, and **Contact** pages
* **Shared Sections** for building shared pieces of of pages
* **Blog Articles**, **News Articles** and **Authors**
* **Team**, **Events** and **Resources**
* **Alerts**
* **Error Page** and **404 Page**


### Plugins [WIP]

The following plugins are currently included and installed via [composer](https://getcomposer.org/), which is what Craft uses for the Plugin Store as well:

* [Admin Bar](https://plugins.craftcms.com/admin-bar)
* [Contact Form Honeypot](https://plugins.craftcms.com/contact-form-honeypot)
* [Contact Form](https://plugins.craftcms.com/contact-form)
* [Element API](https://github.com/craftcms/element-api)
* [Expanded Singles](https://plugins.craftcms.com/expanded-singles)
* [Feed Me](https://github.com/craftcms/feed-me)
* [Field Manager](https://github.com/verbb/field-manager)
* [Google Custom Search](https://github.com/imarc/craft-googlecustomsearch)
* [Mix](https://plugins.craftcms.com/mix)
* [Redactor](https://plugins.craftcms.com/redactor)
* [Retour](https://plugins.craftcms.com/retour)
* [Sprout Fields](https://sprout.barrelstrengthdesign.com/docs/fields/)
* [Super Table](https://github.com/verbb/super-table)
* [Tags](https://plugins.craftcms.com/tag-manager)
* [Typed link field](https://plugins.craftcms.com/typedlinkfield)

### Macros

There is a `_macros.twig` file that provides The following macros:

* **renderAllBlocks**, **renderBlock**, and **renderColumn** - these are used to render the contentDesigner field.
* **responsiveImage** - macro that uses the responsiveImage.twig partial to embed an image with an appropriate picture tag with srcsets for working with lazysizes.
* **pagination** - used to generate pagination.
* **commaSeparate** - used to generate a comma separated list of elements based on title.
* **columnsSlug** - used to generate a classname appropriate slug for for a section.
* **numberToWord** - used to convert a number from 0 through 10 to an english word.


### Sections [WIP]

The **Content Designer** Field (contentDesigner) allows CMS users to use the following sections out of the box:

* **Designed Section** - the most common section, it allows you to pick a combination of up to two columns to render together out of the following:
  * Text - a regular rich text column. Within a Text column, you can additionally add a Call to Action.
  * Call to Action - a call to action, typically styled to look like a button.
  * Image - an image.
  * Related Entry - a related entry.
  * Testimonial - a testimonial.
  * Video - a video.
  * Embed - an embed.
* **Rich Text Section** - a more traditional section of just rich text, relying on redactor for styling or floating images within the content.
* **Call to Action Section** - A full width section featuring a call to action.
* **Related Entries Section** - A section of related entries, such as related blog articles or resources.
* **Testimonial Section** - A section featuring a testimonial.
* **Icon Grid Section** - An icon grid, typically used to showcase partner, brand or technology logos.
* **Shared Section** - allows you to include a Shared Section, a separate type of entry in the CMS that itself contains a Content Designer field. This lets you build a block once (within a Shared Section) and include it into multiple pages on the site.

## License

Padstone is released under the MIT License.

## Contributing

Set up a padstone project with the ability to contribute back.

    # clone project and enter directory
    git clone git@github.com:imarc/padstone.git
    cd padstone

    # install composer deps
    composer install

    # create .env file. if you are using Ops, you can copy .env.example.ops
    cp .env.example.server .env

    # generate craft security key
    php craft setup/keys

    # import sql into db. If you are using Ops, the command is:
    ops psql import padstone padstone.sql

    # Manual step:
    # set CRAFT_DB_DATABASE  in your .env to 'padstone'

<img src="https://user-images.githubusercontent.com/1452/56690112-b04fbd00-66aa-11e9-9e87-049b403cfa26.png" alt="Imarc" width="100">

© 2025 Imarc
