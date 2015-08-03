$ ->
  $('.vote-action').click (e) ->
    e.preventDefault()

    error = '''
<div class="alert alert-warning alert-dismissable" role="alert">
  <button aria-label="Close" class="close" data-dismiss="alert" type="button">
  <span aria-hidden="true">×</span>
  </button>
  %s
</div>
'''
    if $('.question-header').data('islogin') == 0
      $('.flash-message').html(error)
      return

    $form = $(@).parent().find('form')
    value = $form.children('#vote_value').val()
    votable_type = $form.children('#vote_votable_type').val()
    votable_id = $form.children('#vote_votable_id').val()

    alert('value: ' + value + ', votable_type:' + votable_type + ', votable_id:' + votable_id)