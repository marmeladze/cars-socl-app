MOTORBRAG.Behaviors.date_picker = function() {
  var $this = $(this);
  $(this).datetimepicker({
    inline: true,
    collapse: false,
    format: "MMMM DD",
    icons: {
      previous: 'zmdi zmdi-chevron-left',
      next: 'zmdi zmdi-chevron-right'
    },
    minDate: moment(),
    locale: 'en-gb'
  })
  .on('dp.change', function(e) {
    var month = $this.find('th[title="Select Month"]').text().split(' ')[0];
    var selectedDate = month + ' ' + e.date.date();
    $('.selected-date span').text(selectedDate);
    var date = e.date.year() + '/' + (e.date.month()+1) + '/' + e.date.date()
    $('.selected-date input').val(date);
  });
}
