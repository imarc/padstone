```
$breakpoints: (
  md: 696px,
  lg: 992px,
  xl: 1288px,
) !default;
```

Boilerplate comes with 3 breakpoints for 3 ranges.

The `$breakpoints` map is most commonly used through the `at()` and `at-each()` mixins.


## Using a Breakpoint

The most common way is to use the `at()` (previously `breakpoint()`):

```
.example {
    @include at(md) {
        display: flex;
        flex-flow: row wrap;
    }
}
```

If you don't want to use the `$breakpoints` map, you can also just pass in a distance:

```
@include at(1200px) {
  // ...
}
```


## Breakpoint Shorthand

There's also a shorthand, `at-each()`. `at-each()` takes pairs of arguments (technically a sass map), where the first one is the breakpoint you'd like to target and the second is a value you'd like to pass to your included code. If the breakpoint is omitted, then the block is included with the value outside of a media query:

```
.example {
    @include at-each(2.2rem, md 2.4rem, lg 2.6rem) using ($size) {
        font-size: $size;
    }
}
```

The above is a shorthand for

```
.example {
    font-size: 2.2rem;

    @include at(md) {
        font-size: 2.4rem;
    }

    @include at(lg) {
        font-size: 2.6rem;
    }
}
```

Similar to `at()`, you can also pass in lengths instead of keys from `$breakpoints` if you'd rather.
