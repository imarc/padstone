---
label: "Color Modifers"
---
```
$color-modifiers: (
    primary: $primary,
    secondary: $secondary,
    danger: $danger,
    confirm: $confirm,

    success: $success,
    warning: $warning,
    error: $error,

    info: $info,
    disabled: $disabled,
) !default;
```

`$color-modifiers` is a map of BEM modifier names to colors for use with the `color-modifiers()` mixin. `color-modifiers()` is based on the `modifiers()` mixin for quickly created modifier classes. It will let you quickly create ABEM modifier classes:

```
.example {
    @include color-modifiers(primary, secondary);
}
```
is a shorthand for
```
.example {
    &.-primary {
        color: $primary;
    }
    &.-secondary {
        color: $secondary;
    }
}
```

More commonly you'll not want to set `color:` but provide your own properties:

```
.example {
    @include color-modifiers(primary, secondary) using ($color) {
        background-color: $color;
        box-shadow: 0 0 25px $color;
    }
}
```

Specifing which modifiers to include is optional; if you don't specify, it'll generate modifiers for all of them:

```
.button {
    @include color-modifiers using ($color) {
        background-color: $color;
    }
}
```
is a shorthand for
```
.button {
    &.-primary {
        background-color: $primary;
    }
    &.-secondary {
        background-color: $secondary;
    }
    &.-danger {
        background-color: $danger;
    }
    &.-confirm {
        background-color: $confirm;
    }

    // ...
}
```
Note that you could generate _a lot_ of CSS with this if you went wild with it. If you choose to do that, consider using purgecss or similar to remove modifiers that aren't used.

Lastly, while the syntax changes slightly, you can also use `color-modifiers()` without `$color-modifiers` or as mix of custom modifers. Note the double parenthesis:

```
.button {
    @include color-modifiers((primary, secondary, confirm #88ff00, nuclear #f1c609));
}
```
is a shorthand for
```
.button {
    &.-primary {
        color: $primary;
    }
    &.-secondary {
        color: $secondary;
    }
    &.-confirm {
        color: #88ff00;
    }
    &.-nuclear {
        color: #f1c609;
    }
}
```
