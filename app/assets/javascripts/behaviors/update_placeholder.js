MOTORBRAG.Behaviors.update_placeholder = function() {
  $(this).on('change', function() {
    var $placeHolder = $($(this).data('reference'));
    $isBackgroundImage = $(this).data('update-style')
    MOTORBRAG.Utils.updateImagePlaceholder($placeHolder, this, $isBackgroundImage);
    $placeHolder.show();

    // This is only for addming new blog
    $placeHolder.find('span i').removeClass('zmdi-camera-add').addClass('zmdi-delete');
    $placeHolder.find('span.add-item span').text('Remove');
    $placeHolder.find('span.add-item').removeClass('add-item').addClass('remove-item');
    MOTORBRAG.applyBehaviors($placeHolder);
  });
};
