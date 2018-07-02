MOTORBRAG.Behaviors.read_less = function() {
  $(this).on("click", function(e){
    e.preventDefault();
    var $parent = $(this).parents('div.notes');
    $parent.find('.short-note').removeClass('hidden');
    $parent.find('.full-note').addClass('hidden');
  });
};
