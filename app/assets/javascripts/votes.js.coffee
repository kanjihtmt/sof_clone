$ ->
  $('.vote-action').click (e) ->
    e.preventDefault()

    flashMessage = (type, message) ->
      flash = """
<div class="alert alert-#{type} alert-dismissable" role="alert">
  <button aria-label="Close" class="close" data-dismiss="alert" type="button">
  <span aria-hidden="true">×</span>
  </button>
  #{message}
</div>
"""
    if $('.question-header').data('islogin') == 0
      $('.flash-message').html(flashMessage('warning', '投票するにはログインして下さい'))
      $('body, html').animate({ scrollTop: 0 }, 500)
      return

    $form = $(@).parent().find('form')
    $voteCount = $(@).closest('.votecell').find('.vote-count')

    $.ajax({
      url: $form.attr('action'),
      type: 'POST',
      dataType: 'json',
      data: $form.serialize()
      cache: false,
      beforeSend: (xhr, set) ->
        $('.flash-message').html('')
    }).done (data, stat, xhr) ->
      $('.flash-message').html(flashMessage('info', '投票が完了しました。'))
      $voteCount.text(data.votes_count)
    .fail (data) ->
      messages = ''
      data.responseJSON.messages.forEach (message, i) ->
        messages = messages + '・&nbsp;' + message + '<br>'
      $('.flash-message').html(flashMessage('warning', messages))
      $('html,body').animate({scrollTop: 0}, 'fast')
