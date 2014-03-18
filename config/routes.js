module.exports.routes = {

  '/': {
    view: 'home/index'
  },

  '/login' : {
    controller : 'AuthController',
    action     : 'index'
  },

  '/logout' : {
    controller : 'AuthController',
    action     : 'logout'
  }
};
