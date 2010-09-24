# Makes an AJAX load for a category's full content after the standin token 
# for that category is clicked.
$('p.standin').live 'click', ->
  item = $(this).parent()
  $.get '/categories/' + item.attr('id'), 
    { 'partial': true }, 
    (data) ->
      item.children('.standin').slideUp('fast')
      item.children('.content').html(data)
      item.children('.content').hide().slideDown 'fast', ->
        item.children('.content').css('display', '');

# Hides a category's full content and shows its standin token instead.
$('a.hide_content').live 'click', ->
  item = $(this).parent().parent()
  item.children('.content').slideUp('fast')
  item.children('.standin').slideDown 'fast', ->
    item.children('.standin').css('display', '')

# Expands a category's actions (e.g. "new child category" or "new fact")
$('a.actions_expand').live 'click', ->
  item = $(this).parents('.actions_wrapper')
  item.find('.actions_expand:visible').slideUp('fast')
  item.find('.actions:hidden').slideDown('fast')

# Hides a category's actions
$('a.cancel').live 'click', ->
  item = $(this).parents('.actions_wrapper')
  item.find('.actions:visible').slideUp('fast')
  item.find('.actions_expand:hidden').slideDown('fast')

#$().ready ->
