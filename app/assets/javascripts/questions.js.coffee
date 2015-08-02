$ ->
  $('#question_body').keyup ->
    $preview = $('#preview')

    $.post '/questions/preview', body: $(@).val(), (html) ->
      $preview.html(html)

  $('#answer_body').keyup ->
    $preview = $('#preview')

    $.post $('#answer-form').data('previewurl'), body: $(@).val(), (html) ->
      $preview.html(html)

