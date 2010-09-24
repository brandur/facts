(function(){
  // Makes an AJAX load for a category's full content after the standin token
  // for that category is clicked.
  $('p.standin').live('click', function() {
    var item;
    item = $(this).parent();
    return $.get('/categories/' + item.attr('id'), {
      'partial': true
    }, function(data) {
      item.children('.standin').slideUp('fast');
      item.children('.content').html(data);
      return item.children('.content,.hide_content').hide().slideDown('fast', function() {
        return item.children('.content').css('display', '');
      });
    });
  });
  // Hides a category's full content and shows its standin token instead.
  $('a.hide_content').live('click', function() {
    var item;
    item = $(this).parent();
    item.children('.content,.hide_content').slideUp('fast');
    return item.children('.standin').slideDown('fast', function() {
      return item.children('.standin').css('display', '');
    });
  });
  $('a.actions_expand').live('click', function() {
    var item;
    item = $(this).parents('.actions_wrapper');
    item.find('.actions_expand:visible').slideUp('fast');
    return item.find('.actions:hidden').slideDown('fast');
  });
  $('a.cancel').live('click', function() {
    var item;
    item = $(this).parents('.actions_wrapper');
    item.find('.actions:visible').slideUp('fast');
    return item.find('.actions_expand:hidden').slideDown('fast');
  });
  //$().ready ->
})();
