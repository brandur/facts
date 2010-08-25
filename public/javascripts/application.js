// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

/*
 * Makes an AJAX load for a category's full content after the standin token 
 * for that category is clicked.
 */
$("p.standin").live('click', function() {
  var item = $(this).parent();
  $.get(
    '/categories/' + item.attr('id'), 
    { 'partial': true }, 
    function(data) {
      item.children('.standin').slideUp('fast');
      item.children('.content').html(data);
      item.children('.content,.hide').hide().slideDown('fast', function() {
        item.children('.content').css('display', '');
      });
    }
  );
});

/*
 * Hides a category's full content and shows its standin token instead.
 */
$("a.hide").live('click', function() {
  var item = $(this).parent();
  item.children('.content,.hide').slideUp('fast');
  item.children('.standin').slideDown('fast', function() {
    item.children('.standin').css('display', '');
  });
});

$().ready(function() {
});
