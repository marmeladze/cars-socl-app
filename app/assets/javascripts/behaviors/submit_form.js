MOTORBRAG.Behaviors.submit_form = function() {
  $(this).on("change", function(e){
    $(this).parent('form').submit();
  });
}
