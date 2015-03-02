define ['app'], (app)->
  console.log 'registerDirective,,,,,'
  app.registerDirective 'openSubMenu', ()->
    console.log 'openSubMenu,,,,,'
    return {
      link: (scope, element, attrs)->
        console.log 'link,,,,,',element,attrs
        element.on 'click', ()->
          console.log 'addEventListener,,,,,'
          angular.element('[open-sub-menu]').forEach (e)->
            e.removeClass 'active'
          element.addClass 'active'
        , false
    }