MOTORBRAG.Behaviors.upload_image = function() {
  $(this).on("click", function(e) {
    var entityType = $(this).data('entityType');
    addImageItem(entityType);
    var $inputFile = $('<input>', {
        type: 'file',
        name: entityType + '[photos_attributes][][file]'
    })
    $('.hidden_images').append($inputFile);
    $inputFile.on('change', function() {
      changeImagePlaceholder(this);
    })
    $inputFile.click();
    return false;
  });
};

function changeImagePlaceholder(fileInput) {
  var index = $('.hidden_images input').index(fileInput);
  var $placeHolder = $('.images-upload-container .image-item').eq(index);

  MOTORBRAG.Utils.updateImagePlaceholder($placeHolder, fileInput);

  $placeHolder.find('a i').removeClass('zmdi-camera-add').addClass('zmdi-delete');
  $placeHolder.find('a').removeClass('add-item').addClass('remove-item');
  $placeHolder.find('span').text('Remove');
  MOTORBRAG.applyBehaviors($placeHolder);
};

function addImageItem(entityType) {
  var count = $('.hidden_images input').length
  var imageContent = '<div class="image-item"> \
        <div class="image-wrapper"><img src="" alt=""></div> \
        <a href="#" ><i class="zmdi"></i><span></span></a> \
    </div>';

  var addItemContent = '<div class="image-item image-placeholder add-image-item"> \
      <a href="#" class="add-item" data-behavior="upload_image" data-entity-type="'
  addItemContent += entityType 
  addItemContent += '"> <i class="zmdi zmdi-camera-add"></i><span>Add photo</span></a></div>';
  if(count == 0) {
    $('.images-list').append(addItemContent);
    MOTORBRAG.applyBehaviors($('.images-list'));
  } else if (count > 0) {
    $(imageContent).insertBefore('.images-list .add-image-item')
  }
};
