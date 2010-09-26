# Makes an AJAX load for a category's full content after the standin token 
# for that category is clicked.
$('.standin').live 'click', ->
  item = $(this)
  content = item.children('.content')
  $.get '/categories/' + item.attr('id'), 
    { 'partial': true }, 
    (data) ->
      item.removeClass('standin')
      item.find('h3:first').removeClass('standin_header')
      content.html(data)
      content.slideDown('fast')

# Hides a category's full content and shows its standin token instead.
$('a.tool_hide').live 'click', ->
  item = $(this).parents('.category:first')
  item.find('.category_tools:first').children('.category_tool').hide()
  item.children('.content').slideUp('fast')
  # Hide tools in case they're visible
  item.find('.category_tools:first .actions:visible').slideUp('fast')
  item.addClass('standin')
  item.find('h3:first').addClass('standin_header')

# Expands a category's actions (e.g. "new child category" or "new fact")
$('a.actions_expand').live 'click', ->
  item = $(this).parents('.category:first')
  actions = item.find('.category_tools:first .actions')
  # Check for the case where we've already loaded a form
  if actions.children().length > 0
    actions.slideDown 'fast'
    return
  $.get '/categories/new_form?id=' + item.attr('id'), 
    {}, 
    (data) ->
      actions.html(data)
      actions.find('input#category_name').attr('value', 'Category name')
      actions.find('input#fact_content').attr('value', 'Fact content')
      actions.slideDown 'fast'

# Hides a category's actions
$('a.tool_cancel').live 'click', ->
  item = $(this).parents('.category_tools:first')
  item.find('.actions:visible').slideUp('fast')
 
$('li.category').live 'mouseover mouseout', (event) ->
  return if $(this).hasClass('standin')
  tools = $(this).find('.category_tools:first').children('.category_tool')
  if (event.type == 'mouseover')
    tools.show()
  else
    tools.hide()

$('li.fact').live 'mouseover mouseout', (event) ->
  if (event.type == 'mouseover')
    $(this).find('.fact_tool').show()
  else
    $(this).find('.fact_tool').hide()

# When an informative input is focused and appears to have a system-entered 
# value in it, blank it out in anticipation of user input
$('input.informative').live 'focus', ->
  $(this).removeClass('informative')
  value = $(this).attr('value')
  if (value == 'Login' || value == 'Password' || value == 'Category name' || value == 'Fact content')
    $(this).attr('value', '')

setValueIfEmpty = (selector, value) ->
  item = $(selector)
  if (item.attr('value') == '')
    item.attr('value', value)
  else
    item.removeClass('informative')

$(document).ready ->
  # Put informative values in login/password fields unless those fields 
  # already contain a value
  setValueIfEmpty 'input#user_session_login', 'Login'
  setValueIfEmpty 'input#user_session_password', 'Password'
