BpModal is a modal component that allows for easy access throughout templates and other components. Uses Portal-Vue to always send content to the end of body. Will also lazyload any scripts provided.

For lazyloading to work, HTML must be an encoded URI. Twig's [escape filter](https://twig.symfony.com/doc/3.x/filters/escape.html) can be used to achieve this. 

### Vue Component

`BpModal`

#### Props

* **block** - the block class (defaults to 'accordion')
* **openButtonElement** - the open button element (defaults to 'openButton')
* **overlayElement** - the overlay element (defaults to 'overlay')
* **containerElement** - the container element (defaults to 'container')
* **loadingSpinnerElement** - the loading spinner element (defaults to 'loadingSpinner')
* **contentElement** - the content element (defaults to 'content')
* **closeButtonElement** - the close button element (defaults to 'closeButton')
* **wrapperElement** - the wrapper element (defaults to 'wrapper')
* **closeButtonIconElement** - the close button icon element (defaults to 'closeButtonIcon')

#### Slots

BpModal also provides some named slots that can be used to override certain elements

* **open-button** - To provide a custom button for opening the modal (`openModal` method is passed through the `open-button` slot prop)
* **close-button** - To provide a custom button for closing the modal (`closeModal` method is passed through the `close-button` slot prop)
* **loading-spinner** - the provide a custom spinner (`loading` data attribute is passed through the `loading` slot prop)
#### Parameters

None.