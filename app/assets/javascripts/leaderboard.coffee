rowLimit = 5

hideRows = (table) ->
  hiddenCount = 0
  hiddenContainer = '#'+$(table).attr('id')+'__hidden'

  $(table).find('tr').show()
  if not $(table).data('no-hidden')
    $.each($(table).find('tr'), (row_index, row) ->
      if row_index > rowLimit
        $(row).hide()
        hiddenCount++
    )
    if hiddenCount > 0
      $(hiddenContainer).show()
      $(hiddenContainer)
        .find('.hidden__message')
        .html("+ #{hiddenCount} hidden players")
      $(hiddenContainer).find('.hidden__show-all').click((e) ->
        e.preventDefault()
        $(hiddenContainer).hide()
        $(table).find('tr').show()
        $(table).data('no-hidden', true)
      )

document.addEventListener("turbolinks:load", ->
  options =
    valueNames: [ 'name', 'games', 'wins', 'win-perc', 'ppg' ]

  $.each($('.leaderboard__table'), (tableIndex, table) ->
    userList = new List("leaderboard__table_#{tableIndex}", options)
    userList.on('sortComplete', ->
      hideRows(table)
    )
    hideRows(table)
  )
)
