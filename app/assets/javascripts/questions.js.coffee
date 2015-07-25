$ ->
  $('#question_body').keyup ->
    $preview = $('#preview')

    $.post '/questions/preview', body: $(@).val(), (html) ->
      $preview.html(html)
