define(['app'], function(app) {
  console.log('registerDirective,,,,,');
  return app.registerDirective('openSubMenu', function() {
    console.log('openSubMenu,,,,,');
    return {
      link: function(scope, element, attrs) {
        console.log('link,,,,,', element, attrs);
        return element.on('click', function() {
          console.log('addEventListener,,,,,');
          angular.element('[open-sub-menu]').forEach(function(e) {
            return e.removeClass('active');
          });
          return element.addClass('active');
        }, false);
      }
    };
  });
});
