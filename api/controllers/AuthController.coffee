passport = require('passport')

module.exports =

  # http://passportjs.org/guide/google/

  login: (req, res) ->
    res.view()
    return

  process: (req, res) ->
    passport.authenticate("local", (err, user, info) ->
      if (err) or (not user)
        return res.send(message: "login failed")
        res.send err
      req.logIn user, (err) ->
        res.send err  if err
        res.send message: "login successful"
      return
    ) req, res
    return

  logout: (req, res) ->
    req.logout()
    res.send "logout successful"
    return

module.exports.blueprints =

  actions: true

  rest: true

  shortcuts: true
