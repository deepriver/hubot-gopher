# Description:
#   HubotGopher
#
# Commands:
#   hubot gopher <emotion> - incoming Gopher
#
# Author:
#   deepriver
printf = require 'printf'
_      = require 'underscore'

class Gopher
  constructor: ->
    @baseUrl = "https://raw.githubusercontent.com/deepriver/hubot-gopher/master/gopher_images/"

  emotionMap:
    default: 1
    ok: 14
    no: 15
    "good moning": 16
    cry: 2
    "see you": 40
    pretty: 20, kawaii: 20
    "?": 21, "question": 21
    "That’s it!": 22, "それだ!": 22

  emotion: (emotion_key) ->
    file_name = printf '%02d', @sushiMap[emotion_key]
    time = (new Date()).toISOString().replace(/[^0-9]/g, "")
    return @baseUrl + "#{file_name}.png?#{time}"

module.exports = (robot) ->
  gopher = new Gopher

  robot.hear /:cry:/, (msg) ->
    msg.send gopher.emotion("default")

  robot.respond /gopher ?(.*)/i, (msg) ->
    emote = msg.match[1]
    msg.send gopher.emotion(emote)




  sushiMe: (emotion) ->
    defaultEmotion = process.env.HUBOT_SUSHIYUKI_DEFAULT_EMOTION
    defaultEmotion = _.sample _.keys @sushiMap if defaultEmotion is "random"
    s = printf '%02d',
      @sushiMap[emotion] || @sushiMap[defaultEmotion] || @sushiMap.wat
    t = (new Date()).toISOString().replace(/[^0-9]/g, "")
    return @baseUrl + "#{s}.png?#{t}"

  emotions: ->
    _.keys @sushiMap

formatEmoticonList = (emoticons) ->
  MAX = 15
  output = ''
  count = 1
  for e in emoticons
    output +=  new Array(MAX - e.length).join(' ') + e
    if count % 4 is 0
      output += '\n'
    count++
  output

module.exports = (robot) ->
  sushiyuki = new Sushiyuki

  robot.hear /寿司|鮨|スシ|🍣/, (msg) ->
    msg.send sushiyuki.sushiMe("sneak")

  robot.respond /sushi list/i, (msg) ->
    msg.send formatEmoticonList(sushiyuki.emotions())

  robot.respond /sushi me ?(.*)/i, (msg) ->
    emote = msg.match[1]
    msg.send sushiyuki.sushiMe(emote)
