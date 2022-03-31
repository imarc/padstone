The pagination mixin provides simple navigation for a list of pages. It's used
as part of the listing layout.

### Sass Mixin

`@mixin pagination()`

#### Parameters

None.

### Emmet Shorthand

```
nav.pagination>ul>(li.previous>a{Previous})+(li*2>a)+(li.active>a)+(li*2>a)+li.next>a{Next}
```
