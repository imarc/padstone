---
order: 1
---

## The modifiers mixin

`modifiers()` provides a shorthand for quickly defining ABEM modifiers based on sass maps.

```
.example {
    @include modifiers((1rem, small .75rem, large 1.5rem)) using ($size) {
        font-size: $size;
    }
}
```
is equivalent to
```
.example {
    font-size: 1rem;

    &.-small {
        font-size: .75rem;
    }

    &.-large {
        font-size: 1.5rem;
    }
}
```

You can also pass in a default map for modifiers to work off of:

```
$sizes: (
    sm: 1rem,
    md: 1.5rem,
    lg: 2rem
);

.example {
    @include modifiers((sm, md), $sizes) using ($size) {
        font-size: $size;
    }
}
```

Each item within the first argument to modifiers is parsed like this:

* If it's a list (ex: `small .75rem`) then the first part is used as the modifier name and the second is used as the value;
* If it's a key within the default map (ex: `sm`) then they key is used as the modifier name and the value from the default map is used; and lastly
* If it's neither, then the nested code is included using that value without wrapping it in a modifier class. This is the most helpful if you want to define the default color/size with the same code you're using to define the modifiers.

Lastly, note that the way Sass works, these two lines are equivalent:

```
@include modifiers((sm, md), $sizes) using ($size) {
```

```
@include modifiers(sm md, $sizes) using ($size) {
```

You only need to include the second set of parenthesis if you're going to pass in a pair of values.
