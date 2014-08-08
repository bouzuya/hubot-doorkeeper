# Description
#   A Hubot script that display the doorkeeper events
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot doorkeeper <group> - display the doorkeeper events
#
# Author:
#   bouzuya <m@bouzuya.net>
#
module.exports = (robot) ->
  robot.respond /doorkeeper\s+(\w+)\s*$/i, (res) ->
    group = res.match[1]
    res
      .http 'http://api.doorkeeper.jp/groups/' + group + '/events'
      .get() (err, _, body) ->
        if err?
          robot.logger.error err
          res.send 'hubot-doorkeeper: error'
          return
        events = JSON.parse body
        message = events.map (data) ->
          event = data.event
          """
          #{event.public_url}
          #{event.title}
          #{event.starts_at}/#{event.ends_at}
          #{event.venue_name}

          """
        .join '\n'
        res.send message
