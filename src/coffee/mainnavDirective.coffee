define ['app'], (app)->
  app.registerDirective 'openSubMenu', ()->
    return {
      link: (scope, element, attrs)->
        console.log 'openSubMenu'
        toActive = (element)->
          angular.element('li[open-sub-menu]').each (__, e)->
            angular.element(e)
              .removeClass 'active'
              .find('>ul.collapse').removeClass 'in'
          angular.element(element)
            .addClass 'active'
            .find('>ul.collapse').addClass 'in'
        toUnactive = (element)->
          angular.element(element)
            .removeClass 'active'
            .find('>ul.collapse').removeClass 'in'
        angular.element(element).on 'click', ()->
          return toUnactive(element) if element[0].classList.contains 'active'
          return toActive(element)     
    }

  # app.registerDirective 'nanoDropdown',['$timeout', ($timeout)->
  #   return {
  #     link: (scope, element, attrs)->
  #       console.log 'nanoDropdown'
  #       scope.status = 
  #         isopen: false

  #       scope.data = 
  #         nanoContentHeight: 265

  #       scope.toggleDropdown = ($event)->
  #         console.log 'toggleDropdown222', element
  #         $event.preventDefault()
  #         $event.stopPropagation()
  #         scope.status.isopen = !$scope.status.isopen

  #         $timeout ()->
  #           angular.element(element).find('.nano').nanoScroller({ scroll: 'top' }) if scope.status.isopen
  #   }
  # ]