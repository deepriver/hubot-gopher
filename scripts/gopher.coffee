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
    pretty: 20, kawaii: 20
    "?": 21, "question": 21
    "That’s it!": 22, "それだ!": 22

  emotion: (emotion_key) ->
    file_name = printf '%02d', @emotionMap[emotion_key]
    time = (new Date()).toISOString().replace(/[^0-9]/g, "")
    return @baseUrl + "#{file_name}.png?#{time}"

module.exports = (robot) ->
  gopher = new Gopher

  robot.hear /:cry:/, (msg) ->
    msg.send gopher.emotion("default")

  robot.respond /gopher ?(.*)/i, (msg) ->
    emote = msg.match[1]
    msg.send gopher.emotion(emote)
