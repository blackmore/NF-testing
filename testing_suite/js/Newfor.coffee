Newfor = {}
class Newfor

# Newfor.appendCurrentTxtToMain = ->
  #insertBefore

Newfor.parseText = (line) ->
  str = []
  for l in line.content
    str.push(l.txt)
  str.join("")

Newfor.twoTineScroll = (rows) ->
  for row in rows
    $("div#line#{row.bloffset}").text(Newfor.parseText(row))

Newfor.clearScroll = ->
  $('div#scroll-subs > div').each ->
    this.innerText = ''
  
# Newfor.process_rows = (rows) ->
#   html_str = ""
#   for row, i in rows
#     html = """
#     <div><strong>Row Nr#{i + 1}</strong></div>
#             <div class="row">
#               <div class="span3">baseline offset:</div>
#               <div class="span9">#{row.bloffset}</div>
#             </div>
#             <div class="row">
#               <div class="span3">bgcolor:</div>
#               <div class="span9">#{row.bgcolor}</div>
#             </div>
#             <div class="row">
#               <div class="span3">fgcolor:</div>
#               <div class="span9">#{row.fgcolor}</div>
#             </div>
#             <div class="row">
#               <div class="span3">text:</div>
#               <div class="span9">#{row.text}</div>
#             </div>
#     <hr>
#            """
#     html_str += html
  
#   html_str
Newfor.currentTextAsBlock = (rows) ->
  text = []
  for row in rows
    line = []
    for con in row.content
      line.push(con.txt)
    text.push(line.join(""))
  text.join("<br>")

Pusher.log = (message) ->
  window.console.log message if window.console and window.console.log

WEB_SOCKET_DEBUG = true
pusher = new Pusher('8b830351dbd51ae41414')
channel = pusher.subscribe('live1')

pusher.connection.bind 'state_change', ->
  $('div#status').text(pusher.connection.state)

pusher.connection.bind 'connected', ->
  $('div#connected').text("true")

pusher.connection.bind 'unavailable', ->
  $('div#connected').text("false")

channel.bind 'new_subt', (data) ->
  obj = JSON.stringify(data)
  $('div#json').text(obj)

  subt_obj = data.subt
  $('div#code').text(subt_obj.code)
  $('div#timestamp').text(subt_obj.timestamp)
  if subt_obj.code == "build"
    # $('div#list-rows').html(Newfor.process_rows(subt_obj.row))
    $('div#current-text-as-block').html(Newfor.currentTextAsBlock(subt_obj.row))
    Newfor.twoTineScroll(subt_obj.row)
  if subt_obj.code == "clear"
    #alert "clear"
    Newfor.clearScroll()
    # $('div#current-text-as-block').html('')



  