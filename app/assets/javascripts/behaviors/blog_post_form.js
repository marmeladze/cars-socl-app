MOTORBRAG.Behaviors.blog_post_form = function() {
  $('form#new_blog_post').on('ajax:error', function(jqXHR, error) {
    var $errorObj = $('form#new_blog_post .errors');
    $errorObj.html(error.responseText);
  });

  $('form#new_blog_post').on('ajax:success', function (response) {
    var $target = $($('form#new_blog_post').data('target'));
    $target.html(response.detail[0].body.innerHTML);
    MOTORBRAG.applyBehaviors($target);
  });

  $('form#new_post').on('ajax:success', function (response) {
    var $target = $($('form#new_post').data('target'));
    $target.html(response.detail[0].body.innerHTML);
    MOTORBRAG.applyBehaviors($target);
  });
}
