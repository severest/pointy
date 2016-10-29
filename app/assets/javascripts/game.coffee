# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

addRow = () ->
  # create duplicate of form row
  row = $('.game-group-template').first().clone()
  $(row).removeClass('game-group-template').addClass('game-group').show()
  $('.form-container').append(row)
  $(row).find('#name').autocomplete(
    serviceUrl: '/people',
  )


showLoader = () ->
  $('.new-game__main-content').hide()
  $('.new-game__error').hide()
  $('.new-game__loader').show()

showError = (error = 'Uh oh!') ->
  $('.new-game__main-content').show()
  $('.new-game__loader').hide()
  $('.new-game__error').find('#message').html(error)
  $('.new-game__error').show()


document.addEventListener("turbolinks:load", ->
  $('#submitBtn').click((evt) ->
    evt.preventDefault()
    showLoader()

    game =
      game:
        game_type_id: $('#type').val()
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

    if $('#type').val() is ''
      showError('You must choose a game type.')
    else if game.game.players.length > 1
      $.post('create', game, (data) ->

      ).fail(() ->
        showError('Oops! Cannot save the game.')
      )
    else
      showError('You must enter at least two players.')

    return false
  )

  $('#addPlayerBtn').click((evt) ->
    evt.preventDefault()
    addRow()
  )

  addRow()
)
