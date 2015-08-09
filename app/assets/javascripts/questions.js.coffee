$ ->
  $('#question_body, #answer_body').keyup ->
    $preview = $('#preview')

    $.post $(@).data('previewurl'), body: $(@).val(), (html) ->
      $preview.html(html)

