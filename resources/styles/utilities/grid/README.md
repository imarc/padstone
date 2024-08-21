Boilerplate provides a twelve column grid utility with responsive gaps. This replaces candlepin or using `display: flex` throughout the library.

| Width         | Gaps |
| ------------- | ---- |
| 0 - 624px     | 16px |
| 625 - 1120px  | 32px |
| 1121 - 1392px | 48px |
| 1393px -      | 48px |

There's two named areas and one named line:

* `wide` is a grid area that spans the entire width of the window.
* `main` is the main content grid area. In the last version of boilerplate, this would have been the width of content within the `.container` element.
* The center grid line is named `center` for convienence. For the default grid, this is equivalent to `8`.

Under the hood, the grid is implemented as a 14 column grid where the outer two columns are used to ensure outer gutters.
