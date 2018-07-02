MOTORBRAG.Behaviors.click_link = function() {
  $(this).on("click", function(e){
    e.preventDefault();
    var link = $(this).data('href');
    window.location.href = link;
  });
}
