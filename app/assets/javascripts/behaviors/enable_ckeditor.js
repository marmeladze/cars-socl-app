MOTORBRAG.Behaviors.enable_ckeditor = function() {
  var target = $(this).attr('id');
  CKEDITOR.replace(target, {
    toolbar : 'MyToolbar'
  });
};
