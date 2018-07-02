var MOTORBRAG = {
    applyBehaviors: function (scope) {
        $("[data-behavior]", scope).addBack('[data-behavior]').each(function () {
            var $el = $(this);
            var behaviorsToApply = $el.attr('data-behavior').split(' ');
            $.each(behaviorsToApply, function (i, behaviorName) {
              if (!MOTORBRAG.Behaviors[behaviorName]) {
                throw behaviorName + " does not exist in MOTORBRAG.Behaviors";
              }
                MOTORBRAG.Behaviors[behaviorName].apply($el);
            });
        });
    },
    reload: function() {
      window.location.reload();
    },
    redirect: function(location) {
      window.location.replace(location);
    },
    Behaviors: {}
};

$(document).on('turbolinks:load', function() {
  $(function() {
    MOTORBRAG.applyBehaviors($('body'));
  });
});
