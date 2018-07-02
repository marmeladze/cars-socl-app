MOTORBRAG.Behaviors.update_states = function() {
  $(this).on("change", function(e){
    e.preventDefault();
    $('#user_state_code').find('option').remove().end();
    $('#user_city').find('option').remove().end();

    $.ajax({
      url: '/utils/states_list',
      dataType: "json",
      data: 'country=' + $(this).val(),
      type: 'GET'
    }).done(function(data) {
      $('#user_state_code').prop('disabled', false);
      $.each(data, function(key, value) {
        $('#user_state_code').append(new Option(value, key));
      })
      $('#user_city').append(new Option("Select City", ""));
      $('#user_state_code, #user_city').selectpicker('refresh');
      $('#user_country').val($('#user_country_code option:selected').text());
    })
  });
}
