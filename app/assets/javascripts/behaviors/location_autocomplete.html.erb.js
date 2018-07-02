// var app = window.app = {};
var app = window.app = window.app || {};
app.Locations = function() {
  this._input = $('#location-search-txt');
  this._initAutocomplete();
};

app.Locations.prototype = {
  _initAutocomplete: function() {
    this._input
      .autocomplete({
        source: '/utils/location_search',
        appendTo: '#location-search-results',
        select: $.proxy(this._select, this)
      })
      .autocomplete('instance')._renderItem = $.proxy(this._render, this);
  },

  _render: function(ul, item) {
    var markup = [
      '<span class="name">' + item.name + '</span>'
    ];
    return $('<li>')
      .append(markup.join(''))
      .appendTo(ul);
  },

  _select: function(e, ui) {
    this._input.val(ui.item.name);
    return false;
  }
};


MOTORBRAG.Behaviors.location_autocomplete = function() {
  new app.Locations;
}
