define(['angular', 'angular-couch-potato', 'angular-ui-router', 'angular-ui-bootstrap', 'nanoscroller'], function(angular, couchPotato) {
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
      console.log('messagesCtrl');
      $scope.status = {
        isopen: false
      };
      $scope.toggleDropdown = function($event) {
        console.log('toggleDropdown');
        $event.preventDefault();
        $event.stopPropagation();
        return $scope.status.isopen = !$scope.status.isopen;
      };
      return $timeout(function() {
        console.log('nanoScroller');
        return $('.nano').nanoScroller({
          scroll: 'top'
        }).height(265);
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
