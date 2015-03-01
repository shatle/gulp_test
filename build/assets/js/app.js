var app;

app = angular.module('app', []);

app.controller('myCtrl', [
  '$scope', function($scope) {
    return $scope.data = {
      name: 'text'
    };
  }
]);
