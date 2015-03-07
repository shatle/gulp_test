define ['app'], (app)->
  app.registerController 'topheadCtrl', [ '$scope', '$state', ($scope, $state)->

    $scope.nanoOpen = (isopen)->
      console.log "topheadCtrl $scope.nanoOpen,,,,", isopen

  ]

  app.registerController 'messagesCtrl', [ '$scope', '$state', '$rootScope', 
    ($scope, $state, $rootScope)->

      isLocalBroadcast = false
      $scope.$on 'isopen', (event, isopen)->
        $scope.status.isopen = false if isopen&&!isLocalBroadcast
        isLocalBroadcast = false

      $scope.nanoOpen = (isopen)->
        if isopen
          isLocalBroadcast = true
          $rootScope.$broadcast("isopen", true)
        
  ]

  app.registerController 'notificationsCtrl', [ '$scope', '$state', '$rootScope', 
    ($scope, $state, $rootScope)->

      isLocalBroadcast = false
      $scope.$on 'isopen', (event, isopen)->
        $scope.status.isopen = false if isopen&&!isLocalBroadcast
        isLocalBroadcast = false

      $scope.nanoOpen = (isopen)->
        if isopen
          isLocalBroadcast = true
          $rootScope.$broadcast("isopen", true)

  ]