MOTORBRAG.Behaviors.add_category = function() {
  $this = $(this);
  var type = $(this).data('entityType');
  $('.category-block #motor_model').on('change', function(e) {
    if($(this).val() !== "") {
      $('#add_category_btn').removeClass('disabled');
    } else {
      $('#add_category_btn').addClass('disabled');
    }
  })
  $('#add_category_btn').on("click", function(e){
    e.preventDefault();
    var make = $('#motor_make').val();
    var model = $('#motor_model').val();
    var tagName = make + ' ' + model;
    if(!checkTagExistance($this, tagName)) {
      $('p.text-danger').hide();
      var $html = tagHtml(tagName, type);
      $this.find('.tags-container .tags-list').append($html);
    } else {
      $('p.text-danger').show();
    }
    $('#add_category_btn').addClass('disabled');
  });
}

var tagHtml = function(tagName, type) {
  var tag = '<li class="tag"><span>';
  tag += tagName;
  tag +='</span> \
      <a href="#" class="remove-btn"> \
        <i class="zmdi zmdi-close"></i> \
      </a>';
  tag += fieldAttrs(type);
  tag += '</li>';
  return tag;
};

var fieldAttrs = function(type) {
  var makeField = type + '[categories_attributes][][make]';
  var modelField = type + '[categories_attributes][][model]';
  str = '<input type="hidden" name="' + makeField + '" value="' + $('#motor_make').val() + '" />'
  str += '<input type="hidden" name="' + modelField + '" value="' + $('#motor_model').val() + '" />'
  return str
}

var checkTagExistance = function(container, tagName) {
  var isExist = false;
  $this.find('.tags-container .tags-list li.tag').each(function(index) {
    if(tagName == $(this).text().trim()) {
      isExist = true;
    }
  });
  return isExist;
};
