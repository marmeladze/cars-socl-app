MOTORBRAG.Behaviors.read_more = function() {
  $(this).on("click", function(e){
    e.preventDefault();
    var $parent = $(this).parents('div.notes');
    $parent.find('.short-note').addClass('hidden');
    $parent.find('.full-note').removeClass('hidden');
  });
}
