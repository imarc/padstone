(window["webpackJsonp"] = window["webpackJsonp"] || []).push([["/js/main"],{

/***/ "./resources/js/main.js":
/*!******************************!*\
  !*** ./resources/js/main.js ***!
  \******************************/
/*! no exports provided */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var slick_carousel__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! slick-carousel */ "./node_modules/slick-carousel/slick/slick.js");
/* harmony import */ var slick_carousel__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(slick_carousel__WEBPACK_IMPORTED_MODULE_0__);
/* harmony import */ var _plugins_accordion_plugin__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./plugins/accordion.plugin */ "./resources/js/plugins/accordion.plugin.js");
/* harmony import */ var _plugins_dropdown_plugin__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ./plugins/dropdown.plugin */ "./resources/js/plugins/dropdown.plugin.js");
/* harmony import */ var _plugins_mobileNavigation_plugin__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! ./plugins/mobileNavigation.plugin */ "./resources/js/plugins/mobileNavigation.plugin.js");
/* harmony import */ var _plugins_stickyElement_plugin__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! ./plugins/stickyElement.plugin */ "./resources/js/plugins/stickyElement.plugin.js");
/* harmony import */ var _plugins_stickyHeader_plugin__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! ./plugins/stickyHeader.plugin */ "./resources/js/plugins/stickyHeader.plugin.js");
/* harmony import */ var _plugins_tabs_plugin__WEBPACK_IMPORTED_MODULE_6__ = __webpack_require__(/*! ./plugins/tabs.plugin */ "./resources/js/plugins/tabs.plugin.js");
/* harmony import */ var bootstrap__WEBPACK_IMPORTED_MODULE_7__ = __webpack_require__(/*! bootstrap */ "./node_modules/bootstrap/dist/js/bootstrap.js");
/* harmony import */ var bootstrap__WEBPACK_IMPORTED_MODULE_7___default = /*#__PURE__*/__webpack_require__.n(bootstrap__WEBPACK_IMPORTED_MODULE_7__);









/***/ }),

/***/ "./resources/js/plugins/accordion.plugin.js":
/*!**************************************************!*\
  !*** ./resources/js/plugins/accordion.plugin.js ***!
  \**************************************************/
/*! no exports provided */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! jquery */ "./node_modules/jquery/dist/jquery.js-exposed");
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(jquery__WEBPACK_IMPORTED_MODULE_0__);
/**
 *
 * jQuery Accordion Plugin
 */




jquery__WEBPACK_IMPORTED_MODULE_0___default.a.fn.accordion = function (options) {
  var plugin = this;
  var defaults = {
    hiddenOnLoad: true,
    singleOpen: true
  };
  plugin.settings = jquery__WEBPACK_IMPORTED_MODULE_0___default.a.extend({}, defaults, options);
  return this.each(function () {
    var $header = jquery__WEBPACK_IMPORTED_MODULE_0___default()(this).find('.header');
    var $content = jquery__WEBPACK_IMPORTED_MODULE_0___default()(this).find('.content');

    if (plugin.settings.hiddenOnLoad) {
      $header.parent().addClass('close initially-hidden');
    } else {
      $header.parent().addClass('open');
    }

    $header.on('click', function () {
      if (!jquery__WEBPACK_IMPORTED_MODULE_0___default()(this).parent().hasClass('open') && plugin.settings.singleOpen) {
        $header.parent().removeClass('open').addClass('close');
        $content.slideUp();
      }

      jquery__WEBPACK_IMPORTED_MODULE_0___default()(this).parent().toggleClass('open close');
      jquery__WEBPACK_IMPORTED_MODULE_0___default()(this).siblings('.content').slideToggle();
    });
  });
};

/***/ }),

/***/ "./resources/js/plugins/dropdown.plugin.js":
/*!*************************************************!*\
  !*** ./resources/js/plugins/dropdown.plugin.js ***!
  \*************************************************/
/*! no exports provided */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! jquery */ "./node_modules/jquery/dist/jquery.js-exposed");
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(jquery__WEBPACK_IMPORTED_MODULE_0__);
/**
 *
 * jQuery Dropdown Plugin
 */




jquery__WEBPACK_IMPORTED_MODULE_0___default.a.fn.dropdown = function () {
  var $menuItem = jquery__WEBPACK_IMPORTED_MODULE_0___default()('nav.primary > ul > li');
  $menuItem.hover(function () {
    jquery__WEBPACK_IMPORTED_MODULE_0___default()(this).find('.dropdown').addClass('open');
  }, function () {
    jquery__WEBPACK_IMPORTED_MODULE_0___default()(this).find('.dropdown').removeClass('open');
  });
};

/***/ }),

/***/ "./resources/js/plugins/mobileNavigation.plugin.js":
/*!*********************************************************!*\
  !*** ./resources/js/plugins/mobileNavigation.plugin.js ***!
  \*********************************************************/
/*! no exports provided */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! jquery */ "./node_modules/jquery/dist/jquery.js-exposed");
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(jquery__WEBPACK_IMPORTED_MODULE_0__);
/**
 *
 * jQuery Mobile Navigation Plugin
 */




jquery__WEBPACK_IMPORTED_MODULE_0___default.a.fn.mobileNavigation = function (options) {
  var plugin = this;
  var defaults = {
    toggleClass: 'menu-toggle',
    wrapperClass: 'shell',
    subMenuClass: 'dropdown',
    directionFrom: 'left',
    overlayCss: {
      display: 'none',
      background: '#000000',
      bottom: '0%',
      height: '100%',
      left: '0%',
      opacity: '.4',
      position: 'fixed',
      right: '0%',
      top: '0%',
      width: '100%'
    }
  };
  this.settings = jquery__WEBPACK_IMPORTED_MODULE_0___default.a.extend({}, defaults, options);

  this.closeAll = function () {
    toggleAll();
  };
  /**
   *
   * Return CSS selector from class name.
   */


  var toSelector = function toSelector(className) {
    return '.' + className;
  };
  /**
   *
   * Validate optionals params when initializing library.
   */


  var validateOptions = function validateOptions() {
    var classRegExp = new RegExp(/^\./);
    jquery__WEBPACK_IMPORTED_MODULE_0___default.a.each(plugin.settings, function (key, value) {
      if (key === 'directionFrom') {
        if (value !== 'left' && value !== 'right') {
          jquery__WEBPACK_IMPORTED_MODULE_0___default.a.error('Wrong direction. Choose  "left" or "right".');
        }

        return true;
      }

      if (classRegExp.test(value)) {
        jquery__WEBPACK_IMPORTED_MODULE_0___default.a.error('The value ' + value + ' for ' + key + ' just needs the class name not css selector.');
      }
    });
  };
  /**
   *
   * Toggles Individual Menu
   * .init sets the menu opacity to 1 to prevent FOUC.
   */


  var toggleMenu = function toggleMenu() {
    if (!jquery__WEBPACK_IMPORTED_MODULE_0___default()(this).hasClass('init')) {
      jquery__WEBPACK_IMPORTED_MODULE_0___default()(this).addClass('init');
    }

    jquery__WEBPACK_IMPORTED_MODULE_0___default()(this).toggleClass('open');
  };
  /**
   *
   *  Toggles All Menus
   */


  var toggleAll = function toggleAll() {
    var toggleSelector = toSelector(plugin.settings.toggleClass);
    var subMenuClass = toSelector(plugin.settings.subMenuClass);
    var $overlay = jquery__WEBPACK_IMPORTED_MODULE_0___default()(toSelector(plugin.settings.wrapperClass)).find('.mobile-overlay');
    $overlay.toggle();
    toggleFreezeFrame();
    jquery__WEBPACK_IMPORTED_MODULE_0___default()(toggleSelector).find('i').toggleClass('fa-bars fa-times');
    jquery__WEBPACK_IMPORTED_MODULE_0___default()(plugin[0].parentNode).find(subMenuClass).each(function () {
      if (jquery__WEBPACK_IMPORTED_MODULE_0___default()(this).hasClass('open')) {
        toggleMenu.call(this);
      }
    });
    toggleMenu.call(plugin[0]);
  };
  /**
   *
   * Sets the direction from where the menu animates from.
   */


  var setMenuDirection = function setMenuDirection() {
    var subMenuClass = toSelector(plugin.settings.subMenuClass);
    jquery__WEBPACK_IMPORTED_MODULE_0___default()(this).addClass(plugin.settings.directionFrom).find(subMenuClass).addClass(plugin.settings.directionFrom);
  };
  /**
   *
   * Toggles the main menu. Closes other sub menus if they're open.
   */


  var bindToggle = function bindToggle() {
    var $toggle = jquery__WEBPACK_IMPORTED_MODULE_0___default()(toSelector(plugin.settings.toggleClass));
    $toggle.on('click', toggleAll);
  };
  /**
   *
   * Bind sub menu button to toggle child menu.
   */


  var bindSubMenuToggle = function bindSubMenuToggle() {
    var subMenuClass = toSelector(plugin.settings.subMenuClass);
    var $pluginParent = jquery__WEBPACK_IMPORTED_MODULE_0___default()(plugin[0].parentNode);
    jquery__WEBPACK_IMPORTED_MODULE_0___default()(this).find('.sub-menu-toggle').on('click', $pluginParent, function () {
      var text = jquery__WEBPACK_IMPORTED_MODULE_0___default()(this).data('menu');
      toggleMenu.call(jquery__WEBPACK_IMPORTED_MODULE_0___default()(subMenuClass + '[data-menu="' + text + '"]'));
    });
  };
  /**
   *
   * Append buttons to list items with subMenu menus. Add back buttons to menus.
   */


  var appendControl = function appendControl() {
    var subMenuClass = toSelector(plugin.settings.subMenuClass);
    var text = jquery__WEBPACK_IMPORTED_MODULE_0___default()(this).find('> a').text();

    if (jquery__WEBPACK_IMPORTED_MODULE_0___default()(this).find(subMenuClass).length == 0) {
      return true;
    }

    jquery__WEBPACK_IMPORTED_MODULE_0___default()(this).append('<button class="sub-menu-toggle" data-menu="' + text + '"><i class="fa fa-angle-right" aria-hidden="true"></i></button>');
    jquery__WEBPACK_IMPORTED_MODULE_0___default()(this).find(subMenuClass + ' ul').first().prepend('<li><button class="sub-menu-toggle" data-menu="' + text + '"><i class="fa fa-angle-left" aria-hidden="true"></i> ' + text + '</button></li>');
  };
  /**
   *
   * Find all sub menus and append as a sibling of library's initialized class.
   */


  var cloneAndAppendMenu = function cloneAndAppendMenu() {
    var subMenuClass = toSelector(plugin.settings.subMenuClass);
    var clone = jquery__WEBPACK_IMPORTED_MODULE_0___default()(this).clone(true, true);
    var pluginParent = plugin[0].parentNode; // Remove sub menus from mark up

    jquery__WEBPACK_IMPORTED_MODULE_0___default()(clone).find(subMenuClass).remove(); // Checks for sub menu of another sub menu and call function recursively

    if (jquery__WEBPACK_IMPORTED_MODULE_0___default()(this).find(subMenuClass).length > 0) {
      cloneAndAppendMenu.call(jquery__WEBPACK_IMPORTED_MODULE_0___default()(this).find(subMenuClass));
    } // Remove after cloning and appending


    jquery__WEBPACK_IMPORTED_MODULE_0___default()(this).closest(pluginParent).append(clone).end().remove();
  };
  /**
   *
   *  Set unique identifier on each menu.
   */


  var setMenuId = function setMenuId() {
    var subMenuClass = toSelector(plugin.settings.subMenuClass);
    var text = jquery__WEBPACK_IMPORTED_MODULE_0___default()(this).siblings('a').text();
    jquery__WEBPACK_IMPORTED_MODULE_0___default()(this).find(subMenuClass).each(function () {
      var text = jquery__WEBPACK_IMPORTED_MODULE_0___default()(this).siblings('a').text();
      jquery__WEBPACK_IMPORTED_MODULE_0___default()(this).attr('data-menu', text).addClass('sub-menu');
    }).end().attr('data-menu', text);
  };
  /**
   *
   * Set up sub menu
   */


  var initSubMenu = function initSubMenu() {
    var subMenuClass = toSelector(plugin.settings.subMenuClass);
    var $menuItems = jquery__WEBPACK_IMPORTED_MODULE_0___default()(this).find('nav ul li'); // For each menu item

    $menuItems.each(function () {
      appendControl.call(this);
      bindSubMenuToggle.call(this);
    }); // For each menu

    jquery__WEBPACK_IMPORTED_MODULE_0___default()(this).find(subMenuClass).each(function (index) {
      setMenuId.call(this, index);
      cloneAndAppendMenu.call(this);
    });
  };
  /**
   *
   * Insert overlay and bind it to close all menus on click
   */


  var addOverlay = function addOverlay() {
    var overlay = '<div class="mobile-overlay"></div>';
    overlay = jquery__WEBPACK_IMPORTED_MODULE_0___default()(overlay).css(plugin.settings.overlayCss);
    jquery__WEBPACK_IMPORTED_MODULE_0___default()(toSelector(plugin.settings.wrapperClass)).append(jquery__WEBPACK_IMPORTED_MODULE_0___default()(overlay));
    jquery__WEBPACK_IMPORTED_MODULE_0___default()(overlay).on('click', function () {
      toggleAll();
    });
  };
  /*
   *
   * Freeze frame toggle
   */


  var toggleFreezeFrame = function toggleFreezeFrame() {
    var scroll = {
      'height': '100%',
      'overflow': 'hidden'
    };

    if (jquery__WEBPACK_IMPORTED_MODULE_0___default()(plugin[0]).hasClass('open')) {
      scroll.overflow = 'auto';
    }

    jquery__WEBPACK_IMPORTED_MODULE_0___default()('html').css(scroll);
  };
  /**
   *
   * Set up main menu
   */


  var init = function init() {
    validateOptions();
    addOverlay();
    setMenuDirection.call(this);
    bindToggle.call(this);
  };
  /**
   *
   * Do this each time the library is initialized
   */


  return this.each(function () {
    init.call(this);
    initSubMenu.call(this);
  });
};

/***/ }),

/***/ "./resources/js/plugins/stickyElement.plugin.js":
/*!******************************************************!*\
  !*** ./resources/js/plugins/stickyElement.plugin.js ***!
  \******************************************************/
/*! no exports provided */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! jquery */ "./node_modules/jquery/dist/jquery.js-exposed");
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(jquery__WEBPACK_IMPORTED_MODULE_0__);
/**
 * This jQuery plugin provides the ability to stick and unstick elements
 * based on the current scroll position. For example,
 *
 * To have an element scroll with the page until it reaches the top, then
 * stick to the page:
 *
 *     $('aside.primary section.toc').fix();
 *
 * To do the same, but stick 100 pixels before it reaches the top of the page:
 *
 *     $('aside.primary section.toc').fix({
 *         startOffset: 100
 *     });
 *
 * To stay stuck to the top of the page for 500 pixels of vertical scrolling:
 *
 *     $('.sticky').fix({
 *         startOffset: 100,
 *         duration: 500
 *     });
 *
 *
 *
 * OPTIONS
 *
 *     startOffset (integer, default: 0)
 *         How many pixels from the top of the viewport to start sticking.
 *
 *     endOffset (integer)
 *         If specified and different than startOffset, the sticky element will
 *         animate as you scroll from the startOffset to the endOffset
 *         while the element is fixed.
 *
 *     duration (integer)
 *         If specified, the element will unstick once this number of
 *         pixels has been scrolled.
 *
 *     until (selector)
 *         If specified, the sticky element unsticks when this element scrolls even
 *         with the sticked element.
 *
 *     untilVisible (selector)
 *         If speicifed, the sticky element unstick when any of this element scrolls
 *         into view.
 *
 *     stopEarly (integer, default: 0)
 *         If specified, unsticks the element when it reaches this distance
 *         from the top of an 'until' element.
 *
 *     classWhileFixed (string, default "element-fixed")
 *         This lets you specify a class to add to the element while it's stuck. Defaults to "element-fixed".
 */




var FixedElement = function FixedElement(elem, options) {
  var defaults = {
    classWhileFixed: 'element-fixed',
    startOffset: 0,
    stopEarly: 0
  };
  options = jquery__WEBPACK_IMPORTED_MODULE_0___default.a.extend(defaults, options);
  var that = this,
      state = 'init',
      $elem = jquery__WEBPACK_IMPORTED_MODULE_0___default()(elem),
      $dupe = $elem.clone().addClass('fixed-element-duplicate').css({
    visibility: 'hidden'
  }).insertAfter($elem);

  if ('until' in options) {
    options.$until = jquery__WEBPACK_IMPORTED_MODULE_0___default()(options.until);
  }

  if ('untilVisible' in options) {
    options.$untilVisible = jquery__WEBPACK_IMPORTED_MODULE_0___default()(options.untilVisible);
  }

  $elem.css({
    position: 'absolute'
  });

  this.startAt = function () {
    return $dupe.offset().top - options.startOffset;
  };

  this.endAt = function () {
    var offset = this.startAt();

    if ('duration' in options) {
      offset += options.duration;
    } else if ('until' in options) {
      offset = options.$until.offset().top;
    } else if ('untilVisible' in options) {
      offset = options.$untilVisible.offset().top - jquery__WEBPACK_IMPORTED_MODULE_0___default()(window).height();
    } else {
      offset = jquery__WEBPACK_IMPORTED_MODULE_0___default()(document).height();
    }

    if ('endOffset' in options) {
      offset -= options.endOffset;
    } else {
      offset -= options.startOffset;
    }

    return offset - options.stopEarly;
  };

  this.release = function (top) {
    state = 'released';
    $elem.removeClass(options.classWhileFixed).css({
      position: 'absolute',
      top: '',
      transform: 'translateZ(0) translate(0, ' + top + 'px)'
    });
  };

  this.fix = function (additionalOffset) {
    var offset = options.startOffset + additionalOffset;
    state = 'fixed';
    requestAnimationFrame(function () {
      $elem.addClass(options.classWhileFixed).css({
        position: 'fixed',
        top: offset,
        transform: ''
      });
    });
  };

  this.update = function () {
    var scrollTop = jquery__WEBPACK_IMPORTED_MODULE_0___default()(window).scrollTop();
    var start = that.startAt();
    var end = that.endAt();
    var diff = end - start;
    var currentDiff = scrollTop - start;
    var diffOffsets = options.endOffset - options.startOffset || 0; // Above start

    if (scrollTop <= start) {
      if (state == 'fixed' || state == 'init') {
        that.release(0);
      } // Between start and end

    } else if (scrollTop <= end) {
      if (diffOffsets) {
        that.fix(diffOffsets * currentDiff / diff);
      } else if (state == 'released' || state == 'init') {
        that.fix(0);
      } // Below end

    } else {
      if (state == 'fixed' || state == 'init') {
        that.release(diff + diffOffsets);
      }
    }
  };

  jquery__WEBPACK_IMPORTED_MODULE_0___default()(window).on('scroll resize fix:update', this.update);
  this.update();
};

jquery__WEBPACK_IMPORTED_MODULE_0___default.a.fn.fix = function (options) {
  this.each(function () {
    return new FixedElement(this, options);
  });
};

/***/ }),

/***/ "./resources/js/plugins/stickyHeader.plugin.js":
/*!*****************************************************!*\
  !*** ./resources/js/plugins/stickyHeader.plugin.js ***!
  \*****************************************************/
/*! no exports provided */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! jquery */ "./node_modules/jquery/dist/jquery.js-exposed");
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(jquery__WEBPACK_IMPORTED_MODULE_0__);
/**
 *
 * jQuery Sticky Header Plugin
 */



var $window = jquery__WEBPACK_IMPORTED_MODULE_0___default()(window);

jquery__WEBPACK_IMPORTED_MODULE_0___default.a.fn.stickyHeader = function (options) {
  var plugin = this;
  var $body = jquery__WEBPACK_IMPORTED_MODULE_0___default()('body');
  return this.each(function () {
    // header hide and show on scroll up/down
    var didScroll;
    var lastScrollTop = 0;
    var delta = 5;
    var $header = jquery__WEBPACK_IMPORTED_MODULE_0___default()(this);
    var $headerContent = jquery__WEBPACK_IMPORTED_MODULE_0___default()('.header-content');
    var initialHeight = $header.outerHeight();
    var $searchDrawer = jquery__WEBPACK_IMPORTED_MODULE_0___default()('.search-drawer');
    var $searchToggle = jquery__WEBPACK_IMPORTED_MODULE_0___default()('.search-toggle'); // handle search form toggling

    $searchToggle.on('click', function (e) {
      e.preventDefault();
      $searchDrawer.find('> div').toggleClass('open');
    }); // set up JS-enabled stuff

    $header.addClass('sticky');
    $body.css('padding-top', initialHeight);
    $window.scroll(function (event) {
      didScroll = true;
    });

    var scrollCheck = function scrollCheck() {
      if (didScroll) {
        hasScrolled();
        didScroll = false;
      }

      requestAnimationFrame(scrollCheck);
    };

    requestAnimationFrame(scrollCheck);

    var hasScrolled = function hasScrolled() {
      var height = $header.outerHeight();
      var scrollPos = $window.scrollTop();
      var doNothing = scrollPos == lastScrollTop || Math.abs(lastScrollTop - scrollPos) <= delta;

      if (doNothing) {
        return;
      } // If they scrolled down and are past the header, add class .header-up.


      if (scrollPos > lastScrollTop && scrollPos > height) {
        // Scroll Down
        $header.addClass('header-up').css('top', -height);
      } else {
        // Scroll Up
        $header.removeClass('header-up').css('top', '0');
      }

      lastScrollTop = scrollPos;
    };

    $window.resize(function () {
      // check for inner containter to measure height
      // incase the search drawer is open
      var height = $headerContent.outerHeight();
      $body.css('padding-top', height);
      hasScrolled();
    });
  });
};

/***/ }),

/***/ "./resources/js/plugins/tabs.plugin.js":
/*!*********************************************!*\
  !*** ./resources/js/plugins/tabs.plugin.js ***!
  \*********************************************/
/*! no exports provided */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! jquery */ "./node_modules/jquery/dist/jquery.js-exposed");
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(jquery__WEBPACK_IMPORTED_MODULE_0__);
/**
 *
 * jQuery Tabs Plugin
 */




jquery__WEBPACK_IMPORTED_MODULE_0___default.a.fn.tabs = function () {
  this.each(function () {
    var $nav = jquery__WEBPACK_IMPORTED_MODULE_0___default()(this).find('nav');
    var $tabs = $nav.find('li');
    var $panel = jquery__WEBPACK_IMPORTED_MODULE_0___default()(this).find('.panel');

    if (location.hash) {
      $tabs.each(function () {
        var $this = jquery__WEBPACK_IMPORTED_MODULE_0___default()(this);

        if ($this.data('hash') == location.hash) {
          $tabs.not($this).removeClass('active');
          $this.addClass('active');
          var $activePanel = $panel.eq($this.index());
          $panel.not($activePanel).removeClass('active');
          $activePanel.addClass('active');
        }
      });
    }

    $tabs.click(function () {
      var $this = jquery__WEBPACK_IMPORTED_MODULE_0___default()(this);
      var $i = $this.index();
      var $activePanel = $panel.eq($i);
      $panel.not($activePanel).removeClass('active');
      $activePanel.addClass('active');
      $this.siblings('li').removeClass('active');
      $this.addClass('active');
      var hash = $this.data('hash');

      if (hash != 'undefined') {
        if (history.pushState) {
          history.pushState(null, null, hash);
        } else {
          location.hash = hash;
        }
      }
    });
  });
};

/***/ }),

/***/ 1:
/*!************************************!*\
  !*** multi ./resources/js/main.js ***!
  \************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

module.exports = __webpack_require__(/*! /home/kevin/Code/amesbury-mortgage/resources/js/main.js */"./resources/js/main.js");


/***/ })

},[[1,"/js/manifest","/js/vendor"]]]);
//# sourceMappingURL=main.js.map