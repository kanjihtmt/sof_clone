$ ->
  $('#question_body').keyup ->
    $preview = $('#preview')

    $.post '/questions/preview', body: $(@).val(), (html) ->
      $preview.html(html)

  $('#answer_body').keyup ->
    $preview = $('#preview')

    $.post $('#answer-form').data('previewurl'), body: $(@).val(), (html) ->
      $preview.html(html)

  $('.add-comment').click (e) ->
    e.preventDefault()
    $comment_form = $(@).parent('div').find('.comment-form')
    $(@).hide()
    $.get $(@).data('add-comment-path'), (html) ->
      $comment_form.html(html)

