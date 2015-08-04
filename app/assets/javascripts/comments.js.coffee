$ ->
  flashMessage = (type, message) ->
    flash = """
<div class="alert alert-#{type} alert-dismissable" role="alert">
  <button aria-label="Close" class="close" data-dismiss="alert" type="button">
  <span aria-hidden="true">×</span>
  </button>
  #{message}
</div>
"""
  $('.add-comment').click (e) ->
    e.preventDefault()
    $commentForm = $(@).parent('div').find('.comment-form')
    $(@).hide()
    $.get $(@).data('add-comment-path'), (html) ->
      $commentForm.html(html)

  $('.comment-form').on 'click', 'button', (e) ->
    e.preventDefault()

    $form = $(@).closest('form')

    $.ajax({
      url: $form.attr('action'),
      type: 'POST',
      dataType: 'json',
      data: $form.serialize()
      cache: false,
      beforeSend: (xhr, set) ->
        $('.flash-message').html('')
    }).done (data, stat, xhr) ->
      $('.flash-message').html(flashMessage('info', data.message))
      comment = "<p>#{data.body} - #{data.commenter} #{data.created_at}"
      $(@).parents('.comments').find('.comment').prepend(comment)
    .fail (xhr, stat, err) ->
      $('.flash-message').html(flashMessage('warning', data.message))
