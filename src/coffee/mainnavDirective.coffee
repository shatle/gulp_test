define ['app'], (app)->
  console.log 'registerDirective,,,,,'
  app.registerDirective 'openSubMenu', ()->
    console.log 'openSubMenu,,,,,'
    return {
      link: (scope, element, attrs)->
        element.addEventListener 'click', ()->
          console.log 'linkkk,,,,,'
          angular.element('[open-sub-menu]').forEach ($e)->
            $e.classList.remove 'active'
          element.classList.add 'active'
        , false
    }