define(['app'], function(app) {
  app.registerController('topheadCtrl', [
    '$scope', '$state', function($scope, $state) {
      return $scope.nanoOpen = function(isopen) {
        return console.log("topheadCtrl $scope.nanoOpen,,,,", isopen);
      };
    }
  ]);
  app.registerController('messagesCtrl', [
    '$scope', '$state', '$rootScope', function($scope, $state, $rootScope) {
      var isLocalBroadcast;
      isLocalBroadcast = false;
      $scope.$on('isopen', function(event, isopen) {
        if (isopen && !isLocalBroadcast) {
          $scope.status.isopen = false;
        }
        return isLocalBroadcast = false;
      });
      return $scope.nanoOpen = function(isopen) {
        if (isopen) {
          isLocalBroadcast = true;
          return $rootScope.$broadcast("isopen", true);
        }
      };
    }
  ]);
  return app.registerController('notificationsCtrl', [
    '$scope', '$state', '$rootScope', function($scope, $state, $rootScope) {
      var isLocalBroadcast;
      isLocalBroadcast = false;
      $scope.$on('isopen', function(event, isopen) {
        if (isopen && !isLocalBroadcast) {
          $scope.status.isopen = false;
        }
        return isLocalBroadcast = false;
      });
      return $scope.nanoOpen = function(isopen) {
        if (isopen) {
          isLocalBroadcast = true;
          return $rootScope.$broadcast("isopen", true);
        }
      };
    }
  ]);
});
