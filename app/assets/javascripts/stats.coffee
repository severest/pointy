loadFactTimeout = null
timeoutLength = 8000

loadFact = ->
  $.getJSON('/stats/fact', (response) ->
    $('#random-fact').animate(
      opacity: 0
      left: '+=150px'
    , 200, ->
      $('#random-fact').html(response.fact).css({left: '-150px'}).animate(
        opacity: 1
        left: '+=150px'
      , 200)
    )
  )

document.addEventListener("turbolinks:load", ->
  if loadFactTimeout?
    clearInterval(loadFactTimeout)
  if $('#random-fact').is(':visible')
    loadFactTimeout = setInterval(loadFact, timeoutLength)

  loadFact()
)
