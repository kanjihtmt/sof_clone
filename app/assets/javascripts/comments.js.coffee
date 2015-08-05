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

    if $('.question-header').data('islogin') == 0
      $('.flash-message').html(flashMessage('warning', 'コメントするにはログインして下さい'))
      $('body, html').animate({ scrollTop: 0 }, 500)
      return

    $commentForm = $(@).parent('div').find('.comment-form')
    $(@).hide()
    $.get $(@).data('add-comment-path'), (html) ->
      $commentForm.html(html)

  $('.comment-form').on 'click', 'button', (e) ->
    e.preventDefault()

    $button = $(@)
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
      $('.flash-message').html(flashMessage('info', 'コメントを登録しました。'))

      comment = "<p>#{data.body} - #{data.commenter} #{data.created_at}"
      $button.parents('.comments').find('.comment').prepend(comment)
      $('.textarea').val('')
    .fail (xhr, stat, err) ->
      $('.flash-message').html(flashMessage('warning', 'コメントの登録に失敗しました。'))
