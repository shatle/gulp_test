define(['app'], function(app) {
  console.log('registerDirective,,,,,');
  return app.registerDirective('openSubMenu', function() {
    console.log('openSubMenu,,,,,');
    return {
      link: function(scope, element, attrs) {
        return element.addEventListener('click', function() {
          console.log('linkkk,,,,,');
          angular.element('[open-sub-menu]').forEach(function($e) {
            return $e.classList.remove('active');
          });
          return element.classList.add('active');
        }, false);
      }
    };
  });
});
