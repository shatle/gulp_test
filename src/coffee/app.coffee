define ['angular',
  'angular-couch-potato', 'angular-ui-router', 'angular-ui-bootstrap'
  ], (angular, couchPotato)->

    app = angular.module('app', ['scs.couch-potato', 'ui.router'])
    couchPotato.configureApp(app);

    # Config router
    app.config ['$stateProvider','$urlRouterProvider', '$couchPotatoProvider', 
      ($stateProvider,$urlRouterProvider,$couchPotatoProvider)->
        $urlRouterProvider.when('', '/')

        $stateProvider
          .state('app', {
              url: '/',
              # template: '<a ui-sref="app.contacts">contacts</a><div ui-view></div>',
              resolve: {
                dummy: $couchPotatoProvider.resolveDependencies(['mainnavDirective'])
              },
              views: {
                '': { template: '<a ui-sref="app.contacts">contacts</a><div ui-view></div>' },
                'mainnav': {templateUrl: 'templates/mainnav.html'},
                'topheader': { 
                  templateUrl: 'templates/topheader.html',
                  controller: 'topheadCtrl',
                  resolve: {
                    dummy: $couchPotatoProvider.resolveDependencies(['topheadCtrl'])
                  }
                }
              },
              
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

    # init run
    app.run ['$couchPotato', '$state', '$stateParams', '$rootScope', 
      ($couchPotato, $state, $stateParams, $rootScope)-> 
        app.lazy = $couchPotato;
        $rootScope.$state = $state;
        $rootScope.$stateParams = $stateParams;
    ]

    console.log 'app,,,,'
    return app