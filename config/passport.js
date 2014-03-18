var passport = require('passport'),
    GoogleStrategy = require('passport-google-oauth').OAuth2Strategy


var verifyHandler = function (token, tokenSecret, profile, done) {

  process.nextTick(function () {
    console.log('howdy');
    User.findOne({
        or: [
            {uid: parseInt(profile.id)},
            {uid: profile.id}
        ]
      }
    ).done(function (err, user) {

      if (user) {

        return done(null, user);

      } else {

        var data = {
          provider: profile.provider,
          uid: profile.id,
          name: profile.displayName
        };

        if (profile.emails && profile.emails[0] && profile.emails[0].value) {
          data.email = profile.emails[0].value;
        }

        if (profile.name && profile.name.givenName) {
          data.fistname = profile.name.givenName;
        }

        if (profile.name && profile.name.familyName) {
          data.lastname = profile.name.familyName;
        }

        User.create(data).done(function (err, user) {
          return done(err, user);
        });
      }
    });
  });
};

passport.serializeUser(function (user, done) {
  done(null, user.uid);
});

passport.deserializeUser(function (uid, done) {
  User.findOne({uid: uid}).done(function (err, user) {
    done(err, user)
  });
});

module.exports = {

  express: {
    customMiddleware: function (app) {
      passport.use(new GoogleStrategy({
        clientID: '532918952879.apps.googleusercontent.com',
        clientSecret: 'OQaNJZ35ryYuQtZMxsLHn844',
        callbackURL: 'http://localhost:1337/auth/google/return/'
      }, verifyHandler));

      app.use(passport.initialize());
      app.use(passport.session());
    }
  }
};
