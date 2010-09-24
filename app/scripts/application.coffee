# Makes an AJAX load for a category's full content after the standin token 
# for that category is clicked.
$('.standin').live 'click', ->
  item = $(this)
  item.removeClass('standin')
  $.get '/categories/' + item.attr('id'), 
    { 'partial': true }, 
    (data) ->
      item.children('.hidden_info').slideUp('fast')
      item.children('.content').html(data)
      item.children('.content').hide().slideDown 'fast', ->
        item.children('.content').css('display', '');

# Hides a category's full content and shows its standin token instead.
$('a.hide_content').live 'click', ->
  item = $(this).parents('.category')
  item.addClass('standin')
  item.children('.content').slideUp('fast')
  item.children('.hidden_info').slideDown 'fast', ->
    item.children('.hidden_info').css('display', '')

# Expands a category's actions (e.g. "new child category" or "new fact")
$('a.actions_expand').live 'click', ->
  item = $(this).parent('.category_tools')
  item.find('.actions:hidden').slideDown('fast')

# Hides a category's actions
$('a.cancel').live 'click', ->
  item = $(this).parents('.category_tools')
  item.find('.actions:visible').slideUp('fast')
 
$('li.category').live 'mouseover mouseout', (event) ->
  if (event.type == 'mouseover')
    $(this).find('.category_tools:first').children('.category_tool').show()
  else
    $(this).find('.category_tools:first').children('.category_tool').hide()

$('li.fact').live 'mouseover mouseout', (event) ->
  if (event.type == 'mouseover')
    $(this).find('.fact_tool').show()
  else
    $(this).find('.fact_tool').hide()

#$().ready ->
