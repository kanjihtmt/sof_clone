$ ->
  $('#tag_keyword').focus()

  $('#tag_keyword').keyup ->
    tab = $('#selected_tab').val()
    keyword = $(@).val()
    if tab
      tab_param = '&tab=' + tab
    else
      tab_name = ''
    window.location.href = '/tags?keyword=' + keyword + tab_param
