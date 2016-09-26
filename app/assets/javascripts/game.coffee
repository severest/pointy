# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

addRow = () ->
  # create duplicate of form row
  row = $('.game-group-template').first().clone()
  $(row).removeClass('game-group-template').addClass('game-group').show()
  $('.form-container').append(row)


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
    showLoader()

    game =
      game:
        players: []
    winningIndex = 0
    winningPoints = 0
    for player, index in $('.game-group')
      points = parseInt($(player).find('#points').val().trim(), 10)
      game.game.players.push(
        name: $(player).find('#name').val().trim()
        points: points
        winner: false
      )
      if points > winningPoints
        winningIndex = index
        winningPoints = points
    game.game.players[winningIndex].winner = true

    $.post('create', game, (data) ->

    ).fail(() ->
      showError()
    )
    return false
  )

  $('#addPlayerBtn').click((evt) ->
    evt.preventDefault()
    addRow()
  )

  $('#retryBtn').click(() ->
    showMain()
  )

  addRow()
)
