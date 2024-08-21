BpClickable is a renderless vue component for making a larger, parent element work as a link in places where it's not semantic or appropriate to simply use an `<a>` tag.

BpClickable exposes once method to its slot, `click`, that should be called and passed both the click event as we ll as reference to the actual `<a>` element. For example,

```
<bp-clickable v-slot="{ click }">
    <div @click="click($event, $refs.link)">
        <!-- ... -->
        <a ref="link" href="...">...</a>
    </div>
</bp-clickable>
```
