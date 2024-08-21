---
order: 2
---

## File Structure

All files are within `resources/`:

* Sass code, documentation and example markup is within `/resources/styles/`
* JavaScript code is within `/resources/js/`

### Style Structure

Within `/resource/styles/`, there are the following directories from Atomic Design:

<svg width="600px" height="200px" viewBox="139 173 1478.7 255"><g stroke="#100" fill="none" stroke-miterlimit="10" stroke-width="11"><circle cx="779.6" cy="235.2" r="29.3"/><circle cx="842.5" cy="235.2" r="29.3"/><circle cx="905.5" cy="235.2" r="29.3"/><circle cx="969.2" cy="235.2" r="29.3"/><circle cx="779.6" cy="298.2" r="29.3"/><circle cx="842.5" cy="298.2" r="29.3"/><circle cx="905.5" cy="298.2" r="29.3"/><circle cx="969.2" cy="298.2" r="29.3"/><circle cx="779.6" cy="361.1" r="29.3"/><circle cx="842.5" cy="361.1" r="29.3"/><circle cx="905.5" cy="361.1" r="29.3"/><circle cx="969.2" cy="361.1" r="29.3"/><g stroke-width="15"><circle cx="240.3" cy="298.6" r="91.6"/><circle cx="-257.4" cy="529.9" r="58.2"/><circle cx="-191.9" cy="416.9" r="58.2"/><circle cx="-126.1" cy="529.9" r="58.2"/><circle cx="480" cy="346.3" r="49.3"/><circle cx="535.5" cy="250.5" r="49.3"/><circle cx="591.3" cy="346.3" r="49.3"/></g><g stroke-width="9"><polyline points="1296.7 182 1296.7 176 1290.7 176"/><line x1="1279.1" x2="1146.1" y1="176" y2="176" stroke-dasharray="11.5716,11.5716"/><polyline points="1140.3 176 1134.3 176 1134.3 182"/><line x1="1134.3" x2="1134.3" y1="188.4" y2="197.9" stroke-dasharray="6.3774,6.3774"/><polyline points="1134.3 201.1 1134.3 207.1 1140.3 207.1"/><line x1="1153.4" x2="1251.7" y1="207.1" y2="207.1" stroke-dasharray="13.105,13.105"/><polyline points="1258.2 207.1 1264.2 207.1 1264.2 213.1"/><line x1="1264.2" x2="1264.2" y1="224.5" y2="378.2" stroke-dasharray="11.3823,11.3823"/><polyline points="1264.2 383.9 1264.2 389.9 1270.2 389.9"/><line x1="1277.1" x2="1287.3" y1="389.9" y2="389.9" stroke-dasharray="6.8286,6.8286"/><polyline points="1291.7 389.9 1296.7 389.9 1296.7 384.9"/><line x1="1296.7" x2="1296.7" y1="372" y2="187.9" stroke-dasharray="11.8745,11.8745"/><polyline points="1134.3 211.4 1134.3 207.1 1128.3 207.1"/><line x1="1121.5" x2="1111.2" y1="207.1" y2="207.1" stroke-dasharray="6.8288,6.8288"/><polyline points="1107.8 207.1 1101.8 207.1 1101.8 213.1"/><line x1="1101.8" x2="1101.8" y1="225" y2="409.1" stroke-dasharray="11.8746,11.8746"/><polyline points="1101.8 415 1101.8 421 1107.8 421"/><line x1="1119.4" x2="1252.4" y1="421" y2="421" stroke-dasharray="11.5716,11.5716"/><polyline points="1258.2 421 1264.2 421 1264.2 415"/><line x1="1264.2" x2="1264.2" y1="408.6" y2="399.1" stroke-dasharray="6.3776,6.3776"/><polyline points="1264.2 395.9 1264.2 389.9 1260.8 389.9"/></g><g stroke-width="8"><polygon points="1607.4 176 1439.6 176 1439.6 200.5 1535.4 200.5 1583 246.6 1583 397 1607.4 397"/><polyline points="1536.1 200.5 1415.1 200.5 1415.1 421.5 1583 421.5 1583 252.9"/><polygon points="1537.9 206.9 1538 247 1577.6 247.2"/></g></g><g fill="#BE6700"><circle cx="779.6" cy="235.2" r="16.9"/><circle cx="842.5" cy="235.2" r="16.9"/><circle cx="905.5" cy="235.2" r="16.9"/><circle cx="969.2" cy="235.2" r="16.9"/><circle cx="779.6" cy="298.2" r="16.9"/><circle cx="842.5" cy="298.2" r="16.9"/><circle cx="905.5" cy="298.2" r="16.9"/><circle cx="969.2" cy="298.2" r="16.9"/><circle cx="779.6" cy="361.1" r="16.9"/><circle cx="842.5" cy="361.1" r="16.9"/><circle cx="905.5" cy="361.1" r="16.9"/><circle cx="969.2" cy="361.1" r="16.9"/><circle cx="810.7" cy="235.2" r="8.1"/><circle cx="779.6" cy="266.8" r="8.1"/><circle cx="844" cy="266.8" r="8.1"/><circle cx="906.2" cy="266.8" r="8.1"/><circle cx="969.2" cy="266.8" r="8.1"/><circle cx="779.6" cy="329.7" r="8.1"/><circle cx="844" cy="329.7" r="8.1"/><circle cx="906.2" cy="329.7" r="8.1"/><circle cx="969.2" cy="329.7" r="8.1"/><circle cx="873.6" cy="235.2" r="8.1"/><circle cx="937.3" cy="235.2" r="8.1"/><circle cx="810.7" cy="296.7" r="8.1"/><circle cx="873.6" cy="296.7" r="8.1"/><circle cx="937.3" cy="296.7" r="8.1"/><circle cx="810.7" cy="359.6" r="8.1"/><circle cx="873.6" cy="359.6" r="8.1"/><circle cx="937.3" cy="359.6" r="8.1"/><circle cx="504.6" cy="307.5" r="12.1"/><circle cx="528.6" cy="347.1" r="12.1"/><circle cx="541.9" cy="347.1" r="12.1"/><circle cx="568.1" cy="307" r="12.1"/><circle cx="511.4" cy="292" r="12.1"/><circle cx="562.9" cy="292.8" r="12.1"/><circle cx="480" cy="346.3" r="28.4"/><circle cx="535.5" cy="250.5" r="28.4"/><circle cx="591.3" cy="346.3" r="28.4"/><circle cx="240.3" cy="298.6" r="52.8"/><path d="m334.9 241.8c0 12.4-10 22.4-22.4 22.4s-22.4-10-22.4-22.4 10-22.4 22.4-22.4c12.3 0 22.4 10 22.4 22.4z"/></g><g fill="#A29E5E"><polygon points="391.3 297 376 311.6 376 282.4"/><polygon points="702.3 297 687 311.6 687 282.4"/><polygon points="1058.3 297 1043 311.6 1043 282.4"/><polygon points="1364.3 297 1349 311.6 1349 282.4"/></g></svg>

* **atoms/**
* **molecules/**
* **organisms/**
* **templates/**
* **pages/**

We also have three other directories:

* **docs/** - project specific, front end documentation (such as this.)
* **examples/** – project specific examples of groups of components assembled together.
* **utilities/** - utilities are lightweight components that add specific functionality and aren't limited to one of the Atomic Design categories.

There's also a handful of Sass files within this folder itself:

* **main.scss** - This is the root file that Boilerplate compiles to **main.css**. It just contains `@import` statements.
* **_base.scss** - Base styles, such as typography.
* **_colors.scss** – A set of starter color scales.
* **_mixins.scss** - contains Sass mixins and functions that don't make sense to get their own folder.
* **_transitions.scs** – css transitions.
* **_utilities.scss** - contains Sass utilities that are too simple to define standalone.
* **_config.scss** - contains Sass variables.


## Component File Structure and Naming

### Quick Reference

* **styles/&lt;category&gt;/&lt;component-name&gt;/&lt;component-name&gt;.scss**
* **styles/&lt;category&gt;/&lt;component-name&gt;/&lt;component-name&gt;.twig**
* **styles/&lt;category&gt;/&lt;component-name&gt;/README.md**
* **styles/&lt;category&gt;/&lt;component-name&gt;/&lt;component-name&gt;[--&lt;variant-name&gt;].twig**
* **styles/&lt;category&gt;/&lt;component-name&gt;/&lt;component-name&gt;.js**
* **styles/&lt;category&gt;/&lt;component-name&gt;/&lt;component-name&gt;.config.json**

### Explanation

Components are first categorized and put in one of the following folders, based on Atomic Design principles: **utilities/**, **atoms/**, **molecules/**, **organisms/**, **templates/**, or **pages/**. [Atomic Design](http://atomicdesign.bradfrost.com/) is a methodology for breaking down and front end development into manageable, modular pieces that are easier to maintain. Boilerplate uses Atomic Design because it is useful, thought out, well documented, and has a strong community.

The notable addition to the typical Atomic Design categories is **utilities/** (although Atomic Design doesn't oppose this kind of category at all.) The **utilities/** folder is meant for utilities - code that isn't specific to a single component.

*It's okay for components to change categories during development.* Whenever you're trying to choose a category for a component, make your best guess, erring on making it smaller. For example, if you're torn between something being an atom or a molecule, start with atom.

Each component should have its own folder. These folder names should use `kebab-case`. Within that folder, a component may contain the following:

* A Sass file, with the same name as the folder, defining the styles for this component.
* A Twig file, with the same name as the folder, containing example markup for this component.
* Additional Twig files, showing additional examples markup (what [Fractal calls Variants](#)) for this component.
* A README.md, with additional, component specific documentation.
* A JavaScript file, with the same name as the folder, meant to work with the example markup to render the component. Note that this isn't meant to be the source code of a JavaScript plugin or library, but rather the code required to *use* on the example markup.
* A [Fractal configuration file](#), defining how to display this component within the pattern library.

For example, for buttons, we have the following:

* **atoms/button/**
* **atoms/button/button.scss**
* **atoms/button/button.twig**
* **atoms/button/button--disabled.twig**
* **atoms/button/button.config.json**
