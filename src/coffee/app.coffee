define ['angular',
  'angular-couch-potato', 'angular-ui-router', 'angular-ui-bootstrap',
  'nanoscroller',
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
              views: {
                '': { template: '<a ui-sref="app.contacts">contacts</a><div ui-view></div>' },
                'mainnav': {templateUrl: 'templates/mainnav.html'}
              },
              resolve: {
                dummy: $couchPotatoProvider.resolveDependencies(['mainnavDirective'])
              }
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

    # Global controllers
    # which can be able to delay
    app.controller 'messagesCtrl', [ '$scope', '$state', '$timeout',
      ($scope, $state, $timeout)->
        console.log 'messagesCtrl'
        $scope.status = 
          isopen: false
        $scope.data = 
          nanoContentHeight: 265

        $scope.toggleDropdown = ($event)->
          console.log 'toggleDropdown'
          $event.preventDefault()
          $event.stopPropagation()
          $scope.status.isopen = !$scope.status.isopen

          $timeout ()->
            $($event.target).closest('li.dropdown').find('.nano').nanoScroller({ scroll: 'top' }) if $scope.status.isopen

          # height:{{ data.nanoContentHeight}}
          # .height(265)
        $timeout ()->
          console.log 'nanoScroller'
          # $('.nano').nanoScroller({ scroll: 'top' })
            # .find('.nano-pane').css({'display': 'block'})
        # , 1000

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