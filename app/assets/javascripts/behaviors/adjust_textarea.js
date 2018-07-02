MOTORBRAG.Behaviors.adjust_textarea = function() {
  $(this).on('keyup', function(e) {
    if (e.which === 13) {
      e.preventDefault();

      var $url, $target, $form, data;

      $target = $('.' + $(this).data('target'));
      $postCommentsCounter = $('.post-' + $(this).data('post-id') + '-count-comments');
      $form = $(this).parent().parent('form');
      data = $form.serialize();
      $url = $form.attr('action');

      $.ajax({
        url: $url,
        type: 'POST',
        dataType: 'html',
        data: data,
        success: function (content) {
          $target.html(content);

          $postCommentsCounter.html(parseInt($postCommentsCounter.html(), 10) + 1);

          MOTORBRAG.applyBehaviors($target);
          if ($form !== undefined) {
            $form.trigger('reset');
          }
        }
      });
    }
  });
}
