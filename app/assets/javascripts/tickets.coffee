seconds = undefined
countdown = undefined

redirect = ->
  document.location.href = "/"

updateSecs = ->
  $("#seconds").html(seconds)
  seconds--
  if seconds == 0
    clearInterval countdown
    redirect()

countdownTimer = ->
  seconds = $("#seconds").html()
  countdown = setInterval((->
    updateSecs()
  ), 1000)

$ -> countdownTimer()
