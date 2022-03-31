---
order: 1
---

```
$container: 1288px !default;
$gutter: 40px !default;
$columns: 12 !default;
```

`$container` is primarily used with the `container()` mixin and class, that set a max width for the page including padding on the left and right of `$gutter`. `$columns` is used to set the default number of columns when using [candlepin](https://github.com/khamer/candlepin) mixins and classes.


## Using Container

Best practice for using container is to use either the mixin or the class:

```
.example {
    @include container;
}
```

```
<div class="container">
    // ...
```

This sets a max width, padding, margins, and `position: relative`. Note that because Boilerplate sets a default box-sizing of border-box, the paddings are included in the max width: so, 1288px with 40px gutters gives you 1208px for your content.



## Grid

While you should feel free to use [candlepin](https://github.com/khamer/candlepin) directly as well, Boilerplate provides a prebuilt `grid()` mixin and class as well.

```
.example {
    @include grid;
}
```

`grid()` defaults to a single column up to `md`, two columns from `md` to `lg`, three columns from `lg` to `xl`, and four columns above that, with fixed vertical and horizontal gutters of `$gutter`.


## Columns (Deprecated)

Lastly, there's still included a deprecated `columns()` mixin and class. While it still works, both flex and grid are simpler, more robust, and result in cleaner markup.
