MOTORBRAG.Behaviors.toggle_comment_container = function() {
  $(this).on("click", function(e){
    e.preventDefault();
    var target = $(this).data('target')
    $('.' + target).toggleClass('hidden');
  });
}
