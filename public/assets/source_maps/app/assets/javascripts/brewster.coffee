window.app =
  go_back: ->
    $('.results').remove()
    $('#home').show()
  return_list: ->
    $('#show_friend').remove()
    $('.results').show()
