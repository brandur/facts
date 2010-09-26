# Makes an AJAX load for a category's full content after the standin token 
# for that category is clicked.
$('.standin').live 'click', ->
  item = $(this)
  $.get '/categories/' + item.attr('id'), 
    { 'partial': true }, 
    (data) ->
      item.removeClass('standin')
      item.find('h3:first').removeClass('standin_header')
      item.children('.content').html(data)
      item.children('.content').hide().slideDown 'fast', ->
        item.children('.content').css('display', '');

# Hides a category's full content and shows its standin token instead.
$('a.hide_content').live 'click', ->
  item = $(this).parents('.category:first')
  item.find('.category_tools:first').children('.category_tool').hide()
  item.children('.content').slideUp('fast')
  item.addClass('standin')
  item.find('h3:first').addClass('standin_header')

# Expands a category's actions (e.g. "new child category" or "new fact")
$('a.actions_expand').live 'click', ->
  item = $(this).parent('.category_tools')
  item.find('.actions:hidden').slideDown('fast')

# Hides a category's actions
$('a.cancel').live 'click', ->
  item = $(this).parents('.category_tools:first')
  item.find('.actions:visible').slideUp('fast')
 
$('li.category').live 'mouseover mouseout', (event) ->
  return if $(this).hasClass('standin')
  if (event.type == 'mouseover')
    $(this).find('.category_tools:first').children('.category_tool').show()
  else
    $(this).find('.category_tools:first').children('.category_tool').hide()

$('li.fact').live 'mouseover mouseout', (event) ->
  if (event.type == 'mouseover')
    $(this).find('.fact_tool').show()
  else
    $(this).find('.fact_tool').hide()

# When an informative input is focused and appears to have a system-entered 
# value in it, blank it out in anticipation of user input
$('input.informative').live 'focus', ->
  $(this).removeClass('informative')
  if ($(this).attr('value') == 'Login' || ($(this).attr('value') == 'Password'))
      $(this).attr('value', '')

$(document).ready ->
  # Put informative values in login/password fields unless those fields 
  # already contain a value
  if ($('input#user_session_login').attr('value') == '')
    $('input#user_session_login').attr('value', 'Login')
  else
    $('input#user_session_login').removeClass('informative')
  if ($('input#user_session_password').attr('value') == '')
    $('input#user_session_password').attr('value', 'Password')
  else
    $('input#user_session_password').removeClass('informative')
