define(['angular', 'angular-couch-potato', 'angular-ui-router', 'angular-ui-bootstrap'], function(angular, couchPotato) {
  var app;
  app = angular.module('app', ['scs.couch-potato', 'ui.router']);
  couchPotato.configureApp(app);
  app.config([
    '$stateProvider', '$urlRouterProvider', '$couchPotatoProvider', function($stateProvider, $urlRouterProvider, $couchPotatoProvider) {
      $urlRouterProvider.when('', '/');
      return $stateProvider.state('app', {
        url: '/',
        template: '<a ui-sref="app.contacts">contacts</a><div ui-view></div>',
        resolve: {
          dummy: $couchPotatoProvider.resolveDependencies(['mainnavDirective'])
        }
      }).state('app.contacts', {
        url: 'contacts',
        templateUrl: 'templates/contacts.html',
        controller: 'contactsCtrl',
        resolve: {
          dummy: $couchPotatoProvider.resolveDependencies(['contactsCtrl'])
        }
      });
    }
  ]);
  app.run([
    '$couchPotato', '$state', '$stateParams', '$rootScope', function($couchPotato, $state, $stateParams, $rootScope) {
      app.lazy = $couchPotato;
      $rootScope.$state = $state;
      return $rootScope.$stateParams = $stateParams;
    }
  ]);
  console.log('app,,,,');
  return app;
});
