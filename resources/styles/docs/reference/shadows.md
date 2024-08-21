```
$low-shadow: 0 0px 0.5px rgba(0, 0, 0, 0.057),
             0 0px 1.8px rgba(0, 0, 0, 0.083),
             0 0px 8px rgba(0, 0, 0, 0.14);

$med-shadow: 0 0.5px 1.1px rgba(0, 0, 0, 0.057),
             0 1.8px 3.6px rgba(0, 0, 0, 0.083),
             0 8px 16px rgba(0, 0, 0, 0.14);

$high-shadow: 0 1.1px 2.1px rgba(0, 0, 0, 0.057),
              0 3.6px 7.1px rgba(0, 0, 0, 0.083),
              0 16px 32px rgba(0, 0, 0, 0.14);
```

Boilerplate provides three prebuilt box shadows. This helps ensure a consistent set of elevations are used throughout the UI:

* `$low-shadow` should be used for elements that are still 'in the page' such as tabs or a sticky header.
* `$med-shadow` is for elements that are raised but still within the flow of the page, such as cards, raised buttons and raised images.
* `$high-shadow` is for elements that are 'on top of the page' such as pop ups, overlays, or floating action buttons.

