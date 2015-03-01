define ['angular','angular-couch-potato', 'angular-ui-router'], (angular, couchPotato)->

  app = angular.module('app', ['scs.couch-potato', 'ui.router'])
  couchPotato.configureApp(app);

  app.config ['$stateProvider','$urlRouterProvider', '$couchPotatoProvider', 
        ($stateProvider,$urlRouterProvider,$couchPotatoProvider)->
          $urlRouterProvider.when('', '/')

          $stateProvider
            .state('app', {
                url: '/',
                template: '<a ui-sref="app.contacts">contacts</a><div ui-view></div>'
              })
            .state('app.contacts', {
                url: 'contacts',
                templateUrl: 'templates/contacts.html',
                controller: 'contactsCtrl',
                resolve: {
                  dummy: $couchPotatoProvider.resolveDependencies(['contactsCtrl'])
                }
              })
  ]

  app.run ['$couchPotato', '$state', '$stateParams', '$rootScope', 
    ($couchPotato, $state, $stateParams, $rootScope)-> 
      app.lazy = $couchPotato;
      $rootScope.$state = $state;
      $rootScope.$stateParams = $stateParams;
  ]

  return app