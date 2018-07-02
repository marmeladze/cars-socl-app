MOTORBRAG.Behaviors.remove_box = function() {
  $(this).on('click', function(e) {
    var $commentIdBox = $('#box_' + $(this).data('box-id'));
    $commentIdBox.slideUp(500);

    $postCommentsCounter = $('.post-' + $(this).data('post-id') + '-count-comments');
    $postCommentsCounter.html(parseInt($postCommentsCounter.html(), 10) - 1);
  });
}
