BpTabs is a tabs component that encapsulates all the logic and accessibility operations needed. Styling classes are all customizable adherent to ABEM standard. 

### Vue Component

`BpTabs`

#### Props

* **block** - the block class (defaults to 'accordion')
* **navElement** - the nav element (defaults to 'nav')
* **navListElement** - the nav list element (defaults to 'navList')
* **tabElement** - the tab element (defaults to 'tab')
* **panelElement** - the panel element (defaults to 'panel')
* **activeClass** - the modifier class for the active tab (defaults to '-active')
* **tabs** - Object containing key values identifiying each tab/panel, ex: `{ tab1: 'Tab One' }`
* **initialTab** - Key of tab to be open by default
* **setHash** - A Boolean as to whether changing tabs updates `location.hash`


### Sass Mixin

`@mixin tabs()`

#### Parameters

None.