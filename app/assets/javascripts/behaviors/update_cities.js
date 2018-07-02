MOTORBRAG.Behaviors.update_cities = function() {
  $(this).on("change", function(e){
    e.preventDefault();
    $('#user_city').find('option').remove().end();
    $.ajax({
      url: '/utils/cities_list',
      dataType: "json",
      data: 'country=' + $('#user_country_code').val() + '&state=' + $(this).val(),
      type: 'GET'
    }).done(function(data) {
      $('#user_city').prop('disabled', false);
      $.each(data, function(key, value) {
        $('#user_city').append(new Option(value, key));
      })
      $('#user_city').selectpicker('refresh');
      $('#user_state').val($('#user_state_code option:selected').text());
    })
  });
}
