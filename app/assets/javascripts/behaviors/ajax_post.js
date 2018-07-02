MOTORBRAG.Behaviors.ajax_post = function () {
  $(this).on('click', function (e) {
    e.preventDefault();

    var $url, $target, $form, data;

    $url = $(this).data('href');
    $target = $('.' + $(this).data('target'));
    $postCommentsCounter = $('.post-' + $(this).data('post-id') + '-count-comments');

    if ($(this).data('type') == 'form') {
      $form = $(this).parent('form');
      data = $form.serialize();
      $url = $form.attr('action');
    }

    $.ajax({
      url: $url,
      type: 'POST',
      dataType: 'html',
      data: data,
      success: function (content) {
        $postCommentsCounter.html(parseInt($postCommentsCounter.html(), 10) + 1);
        $target.html(content);
        MOTORBRAG.applyBehaviors($target);
        if ($form !== undefined)
          $form.trigger('reset');
      }
    });
  });
};
