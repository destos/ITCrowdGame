express = require 'express'
path = require 'path'
impact = require 'impact'

app = module.exports = express.createServer()

root = path.resolve __dirname, '..'
clientDir = path.resolve root, 'client'

app.configure ->
  # app.use(express.bodyParser())
  # app.use(express.methodOverride())
  # app.use(express.cookieParser())
  # app.use(express.session({ secret: 'your secret here' }))
  app.use app.router 
  app.use express.static clientDir
  return undefined

app.configure 'development', ->
  app.use express.errorHandler
    dumpExceptions: true
    showStack: true
    
app.configure 'production', ->
  app.use express.errorHandler()

app.get '/', (req,res) ->
  res.redirect '/index.html'

impact.listen app, 
  root: clientDir

if not module.parent
  app.listen(3000);
  console.log("Express server listening on port %d in %s mode", app.address().port, app.settings.env);
