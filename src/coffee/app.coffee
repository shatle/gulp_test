app = angular.module 'app', []
app.controller 'myCtrl', ['$scope', ($scope)->
    $scope.data = {name: 'text'}
  ]
