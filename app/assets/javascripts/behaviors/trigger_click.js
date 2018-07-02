MOTORBRAG.Behaviors.trigger_click = function() {
  $(this).on("click", function(e){
    e.preventDefault();
    var $target = $('#' + $(this).data('target'));
    $target.trigger('click');
    $('html, body').animate({
      scrollTop: $target.offset().top
    }, 500);
  });
}
