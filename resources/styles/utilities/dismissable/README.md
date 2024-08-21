BpDismissable is a renderless vue component for dismissable content such as alerts and banners. It exposes a single method to its slot, `dismiss`, that hides the content. It requires a single parameter, `storage-key`, which is used to uniquely identify the instance. It also has an optional parameter for expiration.

It uses the composable function `useStorage`.
