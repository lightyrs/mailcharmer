passport = require 'passport'

module.exports =

  google: (req, res) ->
    passport.authenticate("google",
      failureRedirect: "/login"
      scope: [
        "https://www.googleapis.com/auth/plus.login"
        "https://www.googleapis.com/auth/userinfo.profile"
        "https://www.googleapis.com/auth/userinfo.email"
      ]
    , (err, user) ->
      req.logIn user, (err) ->
        if err
          console.log err
          res.view "500"
          return
        res.redirect "/"
        return

      return
    ) req, res
    return

  index: (req, res) ->
    res.view()

  logout: (req, res) ->
    req.logout()
    res.redirect '/'

module.exports.blueprints =

  actions: true

  rest: true

  shortcuts: true
