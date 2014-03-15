var passport = require('passport'),
GoogleStrategy = require('passport-google').Strategy;
module.exports = {
  express: {
    customMiddleware: function(app){
      console.log('Express midleware for passport');
      app.use(passport.initialize());
      app.use(passport.session());
    }
  }
};
