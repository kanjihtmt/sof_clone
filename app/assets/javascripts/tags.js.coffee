$ ->
  $('#tag_keyword').focus()

  $('#tag_keyword').keyup ->
    $search_results = $('#search-results')
    $.get '/tags', {keyword: $(@).val(), tab: $('#selected_tab').val()}, (html) ->
      $search_results.html(html)
