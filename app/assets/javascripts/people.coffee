document.addEventListener("turbolinks:load", ->
  options =
    valueNames: [ 'name', 'games', 'wins', 'ppg' ]

  $.each($('.leaderboard__table'), (index, val) ->
    userList = new List("leaderboard__table_#{index}", options)
    userList.sort('wins', { order: 'desc' })
  )
)
