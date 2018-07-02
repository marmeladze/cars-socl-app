MOTORBRAG.Behaviors.add_admin_user_to_list = function() {
  $(this).on("click", function(e){
    e.preventDefault();
    var entityType = $('.manage_admins_widget').data('entityType');
    var $item = $(this).parents('.list-item').clone();
    $item.find('.button-container').remove();
    $item.find('.location').remove();
    $item.removeClass('list-item');
    $item.addClass('item boxed-item')
    $item.find('.info-container a').removeClass('title').addClass('item-title');
    var fieldName = entityType + '[admin_user_ids][]'
    $item.find('.info-container input').attr('name', fieldName);
    $item.appendTo('.manage_admins_widget .widget-items-list');
  });
}
