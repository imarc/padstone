Boilerplate provides a few different conventions for colors as well as a set of color scales. Most of these are defined in variables.scss, however the scales themselves are in colors.scss.

## Naming Colors and Scales

Boilerplate recommends naming colors with a numeric suffix for shade similar to font weights, ranging from 100 (lightest) to 900 (darkest.) Most designs call for shades, and names like `$medium-green`, `$bright-dark-blue`, and `$not-very-pink` lead to confusion.

The color scales provided by Boilerplate all follow the same (CIECAM02) contrast scale:

<table>
    <thead>
        <tr><th>Name</th><th>Contrast against White</th><th>Notes</th></tr>
    </thead>
    <tbody>
        <tr><td>$color-100</td><td>1.22</td></tr>
        <tr><td>$color-200</td><td>1.5</td></tr>
        <tr><td>$color-300</td><td>1.93</td></tr>
        <tr><td>$color-400</td><td>3</td><td>First shade safe for headlines</td></tr>
        <tr><td>$color-500</td><td>4.6</td><td>Safe for body text on white or black</td></tr>
        <tr><td>$color-600</td><td>7</td><td>Last shade safe for headlines on black</td></tr>
        <tr><td>$color-700</td><td>10.6</td></tr>
        <tr><td>$color-800</td><td>12.76</td></tr>
        <tr><td>$color-900</td><td>16</td></tr>
    </tbody>
</table>

Just based on the number, you can safely use 400 or higher for headlines and 500 or higher for body text. This is overkill for nearly any project, but it's worth keeping some basic WCAG considerations such as contrast in mind while choosing colors.

All the colors were generated using [Leonardo](https://leonardocolor.io/), a tool made by Adobe. While not required, it's recommended that we continue the convention that 100–600 have sufficient contrast to use against black and  400–900 have sufficeint contrast to use against white. Using a tool like Leonardo is a great way to generate this scale if you need one, but it's not automated so each shade can be picked individually as well.



## Site Colors

A place to set up shorthands for colors, such as `$primary` and `$secondary`.


## Meaningful Colors

This is standard set of colors that each of specific meanings. Nearly every site will use all of these:

* `$confirm` – Indicates a confirmation action such as _confirm_, _save_ or _complete_. Generally not the same colors used for _next_ or _continue_ actions.
* `$danger` - Indicates a destructive action such as _remove_ or _unsubscribe_. Shouldn't be used for actions like _close_ or _cancel_, as those aren't destructive.
* `$disabled` – Used to show that a button or input is disabled.
* `$error` – Used for error messaging and failed validation. Semantically different than `$danger` but often very similar colors are used.
* `$info` – Used for normal messaging; meant to draw some attention but not as high priority as `$error`, `$success`, or `$warning`.
* `$success` – Used for success or confirmation messages.
* `$warning` – Used for warning messages, such as alerts or closures.


## Applied Colors

```
$plain-text: $gray-900 !default;
$meta-text: $gray-500 !default;
$link: $primary !default;
$link-hover: $blue-400 !default;
$border: $gray-200 !default;
```

This is a set of common uses for colors – body text, meta text, links, link hovers, and borders.

## Social Network Colors

Mostly deprecated, but quick access to some common social network brand colors.
