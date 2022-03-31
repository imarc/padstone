---
label: ABEM
order: 3
---

### Quick Reference

* `.componentName__elementName -modifierName`

[ABEM](https://css-tricks.com/abem-useful-adaptation-bem/) is a variant of [BEM](http://getbem.com/). Both are targeting and naming conventions for CSS.


### Why BEM?

BEM (Block, Element Modifier) is a convention for targeting and naming CSS. Using this convention makes our code more clear, more consistent, and more modular. It's a popular and well documented, and pairs well with Atomic Design or other methodologies, as it it makes it easier to find which file a class is likely defined.

* **BEM blocks should be reusable.** Other developers should be comfortable re-using a BEM block.
* **BEM classes are namespaced to the block.** All CSS properties should be targeted to a classname that contains the name of the BEM block to avoid collisions with other classes.
* **BEM won't conflict with semantic elements.** Regardless of whether semantic something should an `<a>`, `<nav>`, or `<button>`, you can use whatever BEM classes you'd like.


### Why Atomic Design?

[Atomic Design](http://atomicdesign.bradfrost.com/) defines a structure for organizing blocks. It's well documented, flexible, and works well with our other tools and methodologies. It also promotes thinking about reuse first when building, encouraging developers to not only create reusable BEM blocks, but *reuse* the blocks in the creation of bigger, fancier blocks.

* **Atomic Design** has a short set of categories for all blocks.
* It encourages creating small blocks and reusing them in larger and fancier blocks.
* It lends itself to extending a style guide into a pattern library.


### Why ABEM?

ABEM (Atomic BEM) is a slight variant of BEM that makes two important changes as well as slightly changing the syntax.

* BEM: `block-name__element-name--modifier-name`
* ABEM: `NS-blockName__elementName -modifierName`

Here's an example of markup using BEM:

```
<header class="site-header site-header--transparent site-header--fixed js-stickyHeader">
    <a class="site-header__company-logo site-header__company-logo--dark-knockout">
        <!-- -->
    </a>
    <nav class="site-header__primary-navigation">
        <!-- -->
    </nav>
    <button class="site-header__call-to-action button button--primary button--large">
        <!-- -->
    </button>
<header>
```

And here's it using ABEM:

```
<header class="siteHeader -transparent -fixed js-stickyHeader">
    <a class="siteHeader__companyLogo -darkKnockout">
        <!-- -->
    </a>
    <nav class="siteHeader__primaryNavigation">
        <!-- -->
    </nav>
    <button class="siteHeader__callToAction button -primary -large">
        <!-- -->
    </button>
<header>
```

The notable features are:

* Block, element, and modifier names are in lowerCamelCase instead of kebab-case.
* **Chainable Modifiers** are separate classes prefixes with a leading dash.
* You can use a **namespace prefix** if you'd like, typically to indicate the Atomic Design block type (Atom, Molecule, Organism, Template or Page) or to indicate that a class is meant strictly for JavaScript targeting (`js-stickyHeader`.)

The choice to use ABEM is primarily for legibility. Code is read way more than it is written, and ABEM makes markup easier to read.


### Conventions

The following BEM conventions apply:

* Use class names for selectors; avoiding using tag names or IDs.
* Atoms, Molecules, Organisms, Templates and Pages should also be "Blocks" from a BEM perspective.
* The class name for a component should be the `lowerCamelCase` version of its name.
* Components should not depend on other components/elements within a page.
* Components can contain other components as well as elements, but not elements of elements.
* Both components as well as elements can have modifiers.

As well as the following ABEM conventions:

* Avoid styling modifier classes without also targeting a component or element.
* Boilerplate treats the namespace prefix as optional; if you want to use them, use them, but the documentation doesn't.
* The one exception to namespace prefixes is `js-`. Boilerplate recommends that the `js-` prefix is used to denote every class that's used for targeting from JavaScript, and that these classes do not overlap with those used for styling.


### BEM Mixes

All a BEM mix is using multiple BEM blocks or elements on the same DOM element. For example, it's fine for an element of one block to also be block itself:

```
<div class="feature">
    <p>
        Ipsum mollitia dolores quisquam minima obcaecati. Atque ipsam vel ex?
    </p>
    <button class="feature__callToAction button">Learn More</button>
</div>
```

It's allowed to even use two different BEM blocks on the same DOM element, but generally that suggests that those two blocks should be combined or rethought.


### Styling Elements without Classes

In general, styling elements within blocks should be avoided, however, one typical exception is for styling elements that are just part of rich text.

For example

```
<div class="messaging -success">
    <p>
        Success! Your changes have been saved. <a href="#">View now.</a>
    </p>
</div>
```

In this context, the `<a>` tag is simply being used as part of rich text, but we may need to alter its text color while within `.messaging.-dark`. Other common examples are when elements are part of content coming from a CMS, such as

* `<a>` tags within short descriptions,
* headings (`<h1>` through `<h6>`) within news articles, and even
* tables within blog articles.

In these instances - where you simply need to override the default styling for tags within rich text because of a parent component - it's okay to style to element within the block:

```
.messaging.-success {
    background-color: darkgreen;

    a {
        color: white;
        text-decoration: underline;
    }
}
```

#### Explanation

The reason for this exception to better support styling generated HTML, such as CMS content, server messages, rich text API responses, etc.


## Sass Mixins and Functions

If you'd like to define sass mixins or functions, Boilerplate recommends

* Mixin and function names are in `lowerCamelCase`.
* Component specific sass mixins are defined with the component's sass file.
* Simple Sass mixins and functions can be put in the **mixins.scss** file and documented with a comment.
* Bigger Sass mixins and functions should get their own folder and Sass file within the **utilities/** folder. These mixins may also have their own example markup and README.md files within their folders.
