module.exports.routes = {

  '/': {
    view: 'home/index'
  },

  '/login': {
    controller: 'AuthController',
    action: 'login'
  },

  '/logout': {
    controller: 'AuthController',
    action: 'logout'
  },

  '/auth/google': {

  },

  '/auth/google/return': {

  }
};
