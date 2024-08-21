---
label: Easings & Transitions
---

Boilerplate provides three prebuilt easings and three durations for transitions and animations.

```
$ease-out-quint: cubic-bezier(0.22, 1, 0.36, 1);
$ease-in-quint: cubic-bezier(0.64, 0, 0.78, 0);
$ease-in-out-quint: cubic-bezier(0.83, 0, 0.17, 1);

$fade-easing: $ease-out-quint;
$entrance-easing: $ease-out-quint;
$exit-easing: $ease-in-quint;
```

Quintic easing was picked as a good looking default.

* All fades should use `$fade-easing` for a consistent feel.
* `$entrance-easing` ensures that the elements feel responsive by moving quickly as they enter and slow to a stop.
* Whereas `$exit-easing` let's users have a final glimpse of the element before it picks up speed and flies away.


Timings were based on existing guidelines from Google, Microsoft, and IBM:

* `$fast` should be used for micro-animations and fades.
* `$moderate` is for mid-sized animations that act as a cue to the user, such as for mega menus and notifications.
* `$slow` is for large animations such as full page transitions, overlays, and background fades.

When picking transition durations, remember that these are only transitions; something the user has to sit through while waiting for the action they wanted to complete. While transitions can make the page feel more responsive, overdone will make the page feel sluggish.
