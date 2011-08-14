util = require 'util'
app = require '../config/app'
m = require './middleware'

Deploy = app.db.model 'Deploy'

return if app.disabled('deploys')

# create
app.all '/teams/:code/deploys', [m.loadTeam], (req, res, next) ->
  util.log 'team'.cyan, req.team.name, 'deployed'.green
  body = req.body || {}
  body.isProduction = false # TODO check where the request came from
  body.teamId = req.team.id
  delete body.code
  deploy = new Deploy body
  deploy.save -> res.send 'ok'
