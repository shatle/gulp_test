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
        # $scope.status = 
        #   isopen: false
        # $scope.data = 
        #   nanoContentHeight: 265

        # $scope.toggleDropdown = ($event)->
        #   $event.preventDefault()
        #   $event.stopPropagation()
        #   $scope.status.isopen = !$scope.status.isopen

        #   $timeout ()->
        #     $($event.target).closest('li.dropdown').find('.nano').nanoScroller({ scroll: 'top' }) if $scope.status.isopen

    ]

    # Global Directive
    app.directive 'nanoDropdown', ['$timeout', ($timeout)->
      return {
        link: (scope, element, attrs)->
          console.log 'nanoDropdown2222'
          scope.status = 
            isopen: false

          scope.data = 
            nanoContentHeight: 265

          scope.toggleDropdown = ($event)->
            console.log 'toggleDropdown222', element
            $event.preventDefault()
            $event.stopPropagation()
            scope.status.isopen = !scope.status.isopen

            $timeout ()->
              angular.element(element).find('.nano').nanoScroller({ scroll: 'top' }) if scope.status.isopen
      }
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