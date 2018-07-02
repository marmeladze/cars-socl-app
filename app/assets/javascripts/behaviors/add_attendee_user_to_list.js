MOTORBRAG.Behaviors.add_attendee_user_to_list = function() {
  $(this).on("click", function(e){
    e.preventDefault();
    var newRecord = $('#attendee-user-search-txt').data('newRecord');
    var $item = $(this).parents('.list-item').clone();
    var fieldName = 'invited_user_ids[]'
    $item.find('.info-container input').attr('name', fieldName);
    $(this).find('span').text('Added');
    if(newRecord) {
      $item.find('.button-container').remove();
      $item.find('.location').remove();
      $item.removeClass('list-item');
      $item.addClass('item boxed-item')
      $item.find('.info-container a').removeClass('title').addClass('item-title');
      $item.appendTo('.manage_attendees_widget .widget-items-list');
    } else {
      $item.find('.button-container a span').text('Remove');
      $item.appendTo('#manageAttendees .invitatees_containers');
    };
    MOTORBRAG.applyBehaviors($item);
  });
}
