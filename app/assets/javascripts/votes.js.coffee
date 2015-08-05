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
      console.log { done: stat, data: data, xhr: xhr }
      $('.flash-message').html(flashMessage('info', data.message))
      $voteCount.text(data.votes_count)
    .fail (xhr, stat, err) ->
      $('.flash-message').html(flashMessage('warning', data.message))
