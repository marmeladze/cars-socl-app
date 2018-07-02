MOTORBRAG.Behaviors.update_search_action = function() {
  $(this).on("click", function(e){
    e.preventDefault();
    var href = $(this).attr('href');
    $('#search_form').attr('action', href);
    $('.nav.nav-tabs .nav-item a').removeClass('active');
    $(this).addClass('active');
  });
}
