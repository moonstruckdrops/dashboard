class Dashing.Clock extends Dashing.Widget

  ready: ->
    setInterval(@startTime, 500)

  startTime: =>
    today = new Date()

    days = ["日", "月", "火", "水", "木", "金", "土"]
    year  = today.getFullYear()
    month = today.getMonth() + 1
    date  = today.getDate()
    h = today.getHours()
    m = today.getMinutes()
    s = today.getSeconds()
    m = @formatTime(m)
    s = @formatTime(s) 
    @set('time', "#{h}:#{m}:#{s}")
    @set('date', "#{year}年#{month}月#{date}日(#{days[today.getDay()]})")

  formatTime: (i) ->
    if i < 10 then "0" + i else i
