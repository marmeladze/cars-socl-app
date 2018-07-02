MOTORBRAG.Behaviors.load_blog_form = function() {
  $(this).on("click", function(e) {
    e.preventDefault();
    if(typeof $(this).data("formUrl") == 'undefined') {
      return false;
    } else {
      var form_url = $(this).data("formUrl");
    }
    var $target = $($(this).data("target"));
    $.ajax(form_url).then(function(response){
      $target.html(response);
      $('#blogsTab').trigger('click');
      MOTORBRAG.applyBehaviors($target);
    });
  });
};
