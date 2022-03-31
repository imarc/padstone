You can create custom column layouts using the candlepin-style modifiers for `.section__item`, however you want something fancier than a single column going to a single row, you'll have to at least adjust margins yourself or with the candlepin utility classes.

This is powered by including the mixin grid-utilities from Candlepin, which provides modifiers for `.-gutter`, `.-gutter-#`, `.-span-#`, `.left-#`, and `.right-#`.
