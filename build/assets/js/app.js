define(['angular', 'angular-couch-potato', 'angular-ui-router', 'angular-ui-bootstrap'], function(angular, couchPotato) {
  var app;
  app = angular.module('app', ['scs.couch-potato', 'ui.router']);
  couchPotato.configureApp(app);
  app.config([
    '$stateProvider', '$urlRouterProvider', '$couchPotatoProvider', function($stateProvider, $urlRouterProvider, $couchPotatoProvider) {
      $urlRouterProvider.when('', '/');
      return $stateProvider.state('app', {
        url: '/',
        views: {
          '': {
            template: '<a ui-sref="app.contacts">contacts</a><div ui-view></div>'
          },
          'mainnav': {
            templateUrl: 'templates/mainnav.html'
          }
        },
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
  app.controller('messagesCtrl', [
    '$scope', '$state', '$timeout', function($scope, $state, $timeout) {
      return console.log('messagesCtrl');
    }
  ]);
  app.directive('nanoDropdown', [
    '$timeout', function($timeout) {
      return {
        link: function(scope, element, attrs) {
          console.log('nanoDropdown2222');
          scope.status = {
            isopen: false
          };
          scope.data = {
            nanoContentHeight: 265
          };
          return scope.toggleDropdown = function($event) {
            console.log('toggleDropdown222', element);
            $event.preventDefault();
            $event.stopPropagation();
            scope.status.isopen = !scope.status.isopen;
            return $timeout(function() {
              if (scope.status.isopen) {
                return angular.element(element).find('.nano').nanoScroller({
                  scroll: 'top'
                });
              }
            });
          };
        }
      };
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
