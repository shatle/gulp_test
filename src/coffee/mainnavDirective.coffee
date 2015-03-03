define ['app'], (app)->
  app.registerDirective 'openSubMenu', ()->
    return {
      link: (scope, element, attrs)->
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