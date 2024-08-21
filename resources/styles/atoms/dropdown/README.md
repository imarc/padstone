This is a Vue component, BpDropdown, for implementing dropdowns. It's used in the navigation components in conjunctions with BpDirectional.

## Usage

### Props

* **delay** (default: 0) – If `hoverable`, how long to delay before closing after the the mouse leaves the dropdown.
* **hoverable** (default: false) – When set, the dropdown will open on hover, otherwise it will only open on click.
* **href** (required) – The href for the link that's overloaded to also open the dropdown.
* **id** (required) – Required ID attribute value for accessibility purposes.
* **label** (required) – Required next for the link.
* **labelClass** (default: '') – Allows adding additional classes to the link used to open the dropdown.
* **transition** (default: 'dropdown__transition') – The name of a vue transition to use for the dropdown.


### Slots

* **default** – The default slot is used for the content within the dropdown.
* **link** – Optional slot for providing more markup for the link than just `{{ label }}`.
* **button** – Optional slot for overriding content of the button used to open the dropdown. The default value is an SVG chevron pointing downward.


### Events

* **open** – Emitted without a payload when the dropdown is opened.
* **close** – Emitted without a payload when the dropdown is closed.
