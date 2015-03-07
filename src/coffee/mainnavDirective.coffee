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

  # 
  # Example:
  #   <li nano-dropdown="Callback(isopen) ng-class="{active: status.isopen}" ></li>
  #   
  #   The element's Controller should have Callback(isopen) method, 
  #   which transmit open status to the Controller.
  #   
  # Attention: should not be isolate scope, ie, {scope: true, ...}
  # 
  app.registerDirective 'nanoDropdown',['$timeout', '$parse', ($timeout, $parse)->
    return {
      link: (scope, element, attrs)->
        invoker = $parse(attrs.nanoDropdown)
        # console.log 'nanoDropdown'
        scope.status = 
          isopen: false

        scope.data = 
          nanoContentHeight: 265

        scope.toggleDropdown = ($event)->
          $event.preventDefault()
          $event.stopPropagation()
          scope.status.isopen = !scope.status.isopen

          $timeout ()->
            # scope.nanoDropdown {isopen: scope.status.isopen}
            invoker scope, {isopen: scope.status.isopen}
            angular.element(element).find('.nano').nanoScroller({ scroll: 'top' }) if scope.status.isopen
    }
  ]