Boilerplate provides two prebuilt levels of padding.

```
$v-space: 1em;
$h-space: 1.618em;
$padding: $v-space $h-space;

$thin-v-space: .618em;
$thin-h-space: 1em;
$thin-padding: $thin-v-space $thin-h-space;
```

Regular padding is generally the 'outer padding' for components. It's used in places such as buttons, cards, and primary nav items; places where the padding is separating content from the outer edge of a component or another component.

Thin padding is generally the 'inner padding' for component elements. It's used in places such as breadcrumbs, radios, and within dropdowns; places where the padding is separating content from other content in the same component.
