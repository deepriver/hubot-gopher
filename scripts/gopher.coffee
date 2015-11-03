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
    tira: 5
    lunch: 8
    beer: 9
    ok: 14
    no: 15
    "good moning": 16
    cry: 2
    pretty: 20, kawaii: 20
    "?": 21, "question": 21
    "That’s it!": 22, "それだ!": 22
    sleep: 10
    yareyare: 29
    fixedly: 30

  emotion: (emotion_key) ->
    defaultEmotion = _.sample _.keys @emotionMap
    file_name = printf '%02d', @emotionMap[emotion_key] || @emotionMap[defaultEmotion]
    time = (new Date()).toISOString().replace(/[^0-9]/g, "")
    return @baseUrl + "#{file_name}.png?#{time}"

module.exports = (robot) ->
  gopher = new Gopher


  robot.hear /^Gopher$/, (msg) ->
    num = Math.ceil(Math.rondom() * 3)
    switch num
      when 1
        msg.send gopher.emotion("tira")
      when 2
        msg.send gopher.emotion("fixedly")
      when 3
        msg.send gopher.emotion("yareyare")

  robot.hear /^Gopherかわいい$/, (msg) ->
    msg.send gopher.emotion("kawaii")

  robot.hear /(ダメだこりゃ)$/, (msg) ->
    msg.send gopher.emotion("yareyare")

  robot.hear /(それだ!|:+1:|:thumbsup:)$/, (msg) ->
    msg.send gopher.emotion("That's it!")

  robot.hear /:cry:$/, (msg) ->
    msg.send gopher.emotion("cry")

  robot.hear /:sleepy:$/, (msg) ->
    msg.send gopher.emotion("sleep")

  robot.respond /gopher ?(.*)/i, (msg) ->
    emote = msg.match[1]
    msg.send gopher.emotion(emote)
