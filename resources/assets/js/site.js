import './mobileNavigation.plugin';
import './dropdown.plugin';
import './stickyHeader.plugin';

$(function() {
    $('header.primary').stickyHeader();
    $('nav.primary').dropdown();
});
