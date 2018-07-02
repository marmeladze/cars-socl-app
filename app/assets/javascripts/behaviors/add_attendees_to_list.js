MOTORBRAG.Behaviors.add_attendees_to_list = function() {
  $(this).on("click", function(e){
    e.preventDefault();
    var link = $(this).data('href');
    window.location.href = link;
  });
}
