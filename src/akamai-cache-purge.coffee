# Description
#   A hubot script that provides purge edge content
#
# Configuration:
#   HUBOT_AKAMAI_CLIENT_TOKEN
#   HUBOT_AKAMAI_CLIENT_SECRET
#   HUBOT_AKAMAI_ACCESS_TOKEN
#   HUBOT_AKAMAI_HOST
#
# Commands:
#   hubot akamai purge cache <URLs> - Invalidate cache of <URLs> (comma seprated)
#   hubot akamai invalidate cache <URLs> - Invalidate cache of <URLs> (comma seprated)
#   hubot akamai delete cache <URLs> - Delete cache of <URLs> (comma seprated)
#
# Author:
#   Yuki Koya <buty4649@gmail.com>

client_secret = process.env.HUBOT_AKAMAI_CLIENT_SECRET
host = process.env.HUBOT_AKAMAI_HOST
access_token = process.env.HUBOT_AKAMAI_ACCESS_TOKEN
client_token = process.env.HUBOT_AKAMAI_CLIENT_TOKEN

module.exports = (robot) ->
  EdgeGrid = require 'edgegrid'

  robot.respond /akamai (purge|invalidate|delete) cache (https?\S+)/i, (res) ->
    action = if res.match[1] == 'delete' then 'delete' else 'invalidate'
    urls = res.match[2].split ','

    data = JSON.stringify(
      objects: urls
    )

    eg = new EdgeGrid(client_token, client_secret, access_token, host)
    eg.auth(
      path: "/ccu/v3/#{action}/url/production"
      method: 'POST'
      headers:
          'Content-Type': 'application/json'
      body: data
    )

    eg.send (err, response, body) ->
      try
        data = JSON.parse body
      catch error
        res.send "JSON parse error #{body}"
        return

      if response.statusCode != 201
        message = "Error(#{response.statusCode}): #{data.detail}"
      else
        message = "Success: estimated time #{data.estimatedSeconds} sec"

      res.send message


