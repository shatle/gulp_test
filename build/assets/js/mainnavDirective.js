define(['app'], function(app) {
  app.registerDirective('openSubMenu', function() {
    return {
      link: function(scope, element, attrs) {
        var toActive, toUnactive;
        console.log('openSubMenu');
        toActive = function(element) {
          angular.element('li[open-sub-menu]').each(function(__, e) {
            return angular.element(e).removeClass('active').find('>ul.collapse').removeClass('in');
          });
          return angular.element(element).addClass('active').find('>ul.collapse').addClass('in');
        };
        toUnactive = function(element) {
          return angular.element(element).removeClass('active').find('>ul.collapse').removeClass('in');
        };
        return angular.element(element).on('click', function() {
          if (element[0].classList.contains('active')) {
            return toUnactive(element);
          }
          return toActive(element);
        });
      }
    };
  });
  return app.registerDirective('nanoDropdown', [
    '$timeout', '$parse', function($timeout, $parse) {
      return {
        link: function(scope, element, attrs) {
          var invoker;
          invoker = $parse(attrs.nanoDropdown);
          scope.status = {
            isopen: false
          };
          scope.data = {
            nanoContentHeight: 265
          };
          return scope.toggleDropdown = function($event) {
            $event.preventDefault();
            $event.stopPropagation();
            scope.status.isopen = !scope.status.isopen;
            return $timeout(function() {
              invoker(scope, {
                isopen: scope.status.isopen
              });
              if (scope.status.isopen) {
                return angular.element(element).find('.nano').nanoScroller({
                  scroll: 'top'
                });
              }
            });
          };
        }
      };
    }
  ]);
});
