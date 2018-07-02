MOTORBRAG.Behaviors.flex_slider = function() {
  var itemMargin = $(this).data('margin');
  var carousel = $(this).data('carousel');
  var slider = $(this).data('slider');

  $(carousel).flexslider({
    animation: "slide",
    controlNav: false,
    slideshow: false,
    itemWidth: 145,
    itemMargin: itemMargin,
    asNavFor: slider
  });
  $(slider).flexslider({
    animation: "fade",
    directionNav: true,
    controlNav: false,
    slideshow: false,
    sync: carousel
  });
}
