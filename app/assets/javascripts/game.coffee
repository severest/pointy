# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# ensure only one winner box can be checked
initWinnerChecks = () ->
  $('.winnerCheckbox').click((evt) ->
    for c in $('.winnerCheckbox')
      $(c).attr('checked', false)
    evt.currentTarget.checked = true
  )

showLoader = () ->
  $('.new-game__main-content').hide()
  $('.new-game__error').hide()
  $('.new-game__loader').show()

showError = (error = 'Uh oh!') ->
  $('.new-game__main-content').hide()
  $('.new-game__loader').hide()
  $('.new-game__error').find('#message').html(error)
  $('.new-game__error').show()

showMain = () ->
  $('.new-game__error').hide()
  $('.new-game__loader').hide()
  $('.new-game__main-content').show()


document.addEventListener("turbolinks:load", ->
  $('#submitBtn').click((evt) ->
    evt.preventDefault()
    if $('.winnerCheckbox:checked').length is 0
      showError('Bro, you need to select a winner')
      return false

    showLoader()

    game =
      game:
        players: []
    for player in $('.game-group')
      game.game.players.push(
        name: $(player).find('#name').val().trim()
        points: $(player).find('#points').val().trim()
        winner: $(player).find('#winner:checked').length isnt 0
      )
      
    $.post('create', game, (data) ->

    ).fail(() ->
      showError()
    )
    return false
  )

  $('#addPlayerBtn').click((evt) ->
    evt.preventDefault()

    # create duplicate of form row
    row = $('.game-group').first().clone()
    # values are blank
    $(row).find('#winner').attr('checked', false)
    $(row).find('#name').val('')
    $(row).find('#points').val('')

    $('.form-container').append(row)
    initWinnerChecks()
  )

  $('#retryBtn').click(() ->
    showMain()
  )

  initWinnerChecks()
)
