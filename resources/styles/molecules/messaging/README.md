Messaging is typically used for messages from the server - warnings, errors on form validation, site outage info, etc. An optional SVG-based icon is often used within messaging. We modify the icon's vertical position to align to the top of its adjacent `.messaging__content`, accounting for messaging's line-height. This allows for the icon to appear aligned to the cap height of  `.messaging__content`'a text, not to the top of `.messaging__content` bounding box.

It's recommended to stick with `rem` units for messaging's `$font-size` and `$icon-size` mixin arguments.

### Sass Mixin

`@mixin messaging()`

#### Parameters

None.

### Emmet Shorthand

```
.messaging>.messaging__icon>svg^.messaging__content>{lorem ipsum}
```
