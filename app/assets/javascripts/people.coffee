document.addEventListener("turbolinks:load", ->
  options =
    valueNames: [ 'name', 'games', 'wins', 'ppg' ]

  userList = new List('leaderboard__table', options)
  userList.sort('wins', { order: 'desc' })
)
