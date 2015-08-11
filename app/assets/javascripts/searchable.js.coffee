$ ->
  $('.searchable-field').focus()

  $('.searchable-field').keyup ->
    $search_results = $('#search-results')
    $.get $(@).data('action-url'), {keyword: $(@).val(), tab: $('#selected_tab').val()}, (html) ->
      $search_results.html(html)
