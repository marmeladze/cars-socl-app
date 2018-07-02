$(function(){
    console.log('Page Loaded!');

    console.log(document.location);

    // Splash page slider
    $('.splash-page-slider').owlCarousel({
        items: 1,
        loop: true,
        animateOut: 'fadeOut',
        autoplay: true,
        autoplayTimeout: 10000
    });
    $('.clients-testimonials-slider').owlCarousel({
        items: 1,
        loop: true,
        animateOut: 'fadeOut',
        dots: true
    });


    // Text area
    function adjust_textarea(h) {
        h.style.height = "20px";
        h.style.height = (h.scrollHeight)+"px";
    }

    // Datepicker
    // $('#eventDateSelect1, #eventDateSelect2, #eventDateSelect3').datetimepicker({
    //     inline: true,
    //     collapse: false,
    //     format: "MMMM DD",
    //     icons: {
    //         previous: 'zmdi zmdi-chevron-left',
    //         next: 'zmdi zmdi-chevron-right'
    //     },
    //     locale: 'en-gb'
    // });

    // Tabs control
    $('#pageControlTabs').on('changed.bs.select', function (e) {
        var selectedTab = $(this).selectpicker('val');
        $('.nav-tabs a[href="#'+ selectedTab +'"]').tab('show');
    });

    $('.collapsible-widget .widget-header').on('click', function (e) {
       $(this).parent().toggleClass('collapsed');
    });

});

function initMap() {
    var mapContainer = document.getElementsByClassName('event-map');
    var eventPos = {lat: 51.3759838, lng: -0.1890131};
    if(mapContainer != null) {
        var map1 = new google.maps.Map(document.getElementById('eventMap1'), {
            center: eventPos,
            zoom: 14,
            mapTypeId: google.maps.MapTypeId.ROADMAP
        });
        var marker = new google.maps.Marker({
            position: eventPos,
            title: 'Event!',
            icon: 'images/icons/map-pin.png',
            map: map1
        });
        var map2 = new google.maps.Map(document.getElementById('eventMap2'), {
            center: eventPos,
            zoom: 14,
            mapTypeId: google.maps.MapTypeId.ROADMAP
        });
        var marker2 = new google.maps.Marker({
            position: eventPos,
            title: 'Event!',
            icon: 'images/icons/map-pin.png',
            map: map2
        });
        var map3 = new google.maps.Map(document.getElementById('eventMap3'), {
            center: eventPos,
            zoom: 14,
            mapTypeId: google.maps.MapTypeId.ROADMAP
        });
        var marker3 = new google.maps.Marker({
            position: eventPos,
            title: 'Event!',
            icon: 'images/icons/map-pin.png',
            map: map3
        });
    }
}
function goToPath(link, e){
    console.log(e);
    document.location.href = document.location.origin + '/' + link;
}