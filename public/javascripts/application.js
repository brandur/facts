// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

/*
jQuery(function($) {
  $('.category h2, .category h3').tipSwift({
    live: true,
    offset: 10, 
    tip: {
      gravity: 'w', 
      html: true, 
      //title: '#{link_to "Permalink", c, :class => [ :permalink, :hide ]}'
      title: '<a href="">Permalink</a>'
    }
  });
});

/*
 * Makes an AJAX load for a category's full content after the standin token 
 * for that category is clicked.
 */
$('p.standin').live('click', function() {
  var item = $(this).parent();
  $.get(
    '/categories/' + item.attr('id'), 
    { 'partial': true }, 
    function(data) {
      item.children('.standin').slideUp('fast');
      item.children('.content').html(data);
      item.children('.content,.hide_content').hide().slideDown('fast', function() {
        item.children('.content').css('display', '');
      });
    }
  );
});

/*
 * Hides a category's full content and shows its standin token instead.
 */
$('a.hide_content').live('click', function() {
  var item = $(this).parent();
  item.children('.content,.hide_content').slideUp('fast');
  item.children('.standin').slideDown('fast', function() {
    item.children('.standin').css('display', '');
  });
});

$('a.actions_expand').live('click', function() {
  var item = $(this).parents('.actions_wrapper');
  item.find('.actions_expand:visible').slideUp('fast');
  item.find('.actions:hidden').slideDown('fast');
});

$('a.cancel').live('click', function() {
  var item = $(this).parents('.actions_wrapper');
  item.find('.actions:visible').slideUp('fast');
  item.find('.actions_expand:hidden').slideDown('fast');
});

$().ready(function() {
});
