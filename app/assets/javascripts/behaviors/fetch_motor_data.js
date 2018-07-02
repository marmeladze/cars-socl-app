MOTORBRAG.Behaviors.fetch_motor_data = function() {
  var $targetUrl = $(this).data('url');
  $(this).on('blur keyup keypress', function(e) {
    e.stopPropagation();
    $this = $(this);
    if (e.type == 'blur' || e.keyCode == '13') {
      console.log("Its blur or enter");
      console.log($this.val());
      $.ajax({
        url: $targetUrl,
        dataType: "json",
        data: 'reg_no=' + $(this).val(),
        type: 'GET'
      }).done(function(data) {
        console.log("Its in done function");
        updateMotorCategoryDetails(data);
      }).fail(function(response, data){
        alert("Its in failed function");
        $this.val('');
        console.log("Its in failed function");
      });
    }
  });
}

var updateMotorCategoryDetails = function(data) {
  $.each(data, function(key, value) {
    var id = '#' + ('motor-' + key).toCamelCase();
    $(id + ' option:last').after(new Option(value, value));
    $(id).val(value).change();
    $(id).selectpicker('refresh');
  })
};
