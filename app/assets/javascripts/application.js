//= require rails-ujs
//= require jquery-3.2.1.min
//= require moment.min
//= require popper
//= require jquery-ui/widgets/autocomplete
//= require bootstrap
//= require turbolinks
//= require ckeditor-jquery
//= require custom/motor_brag
//= require custom/string
//= require custom/utils
//= require_tree ./behaviors
//= require_tree .

$(document).on('turbolinks:load', function() {
  $(document).on('click', '.remove-btn', function(e) {
    e.preventDefault();
    $(this).parent().remove();
  });

  var fullpageSection = $('#fullpageSection');
  if(fullpageSection.length !== 0 && $(window).width() > 991) {
    fullpageSection.fullpage();
  };

  $('.selectpicker').selectpicker({
    style: 'btn-info'
  });

  $(function(){
    // On page load, loading specific tab content
    var url = document.location.toString();
    if (url.match('#')) {
      $('.nav-tabs a[href="#' + url.split('#')[1] + '"]').trigger('click');
    }

    // Update url hashtag on clicking tabs
    var hash = window.location.hash;
    hash && $('tabs-container ul.nav-tabs a.nav-link[href="' + hash + '"]').tab('show');

    $('ul.nav-tabs a.nav-link').click(function (e) {
      window.location.hash = this.hash;
    });
  });
});
