var app = window.app = window.app || {};
app.Users = function(inputSearch, appendDom, behavior) {
  this._input = $('#' + inputSearch);
  this._appendDom = $(appendDom);
  this._behavior = behavior;
  this._initAutocomplete();
};

app.Users.prototype = {
  _initAutocomplete: function() {
    this._input
      .autocomplete({
        source: '/users/search',
        minLength: 0,
        select: $.proxy(this._select, this),
        response: $.proxy(this._response, this)
      })
      .autocomplete('instance')._renderMenu = $.proxy(this._rendermenu, this);
  },

  _response: function(e, ui) {
    if(ui.content.length == 0) {
      var $appendDom = this._appendDom;
      $appendDom.html('');
      if(this._input.val() == '') {
        $appendDom.html("<div class='list-item text-danger'>Enter key to search users</div>");
      } else {
        $appendDom.html("<div class='list-item text-danger'>No results found</div>");
      }
      return false;
    }
  },

  _select: function(e, ui) {
    return false;
  },

  _rendermenu: function(e, items) {
    var $appendDom = this._appendDom;
    $appendDom.html('');
    $behavior = this._behavior;
    $.each(items, function(index, item) {
      var htmlContent = ''
      htmlContent += "<div class='list-item' id='" + item.id + "'>";
      htmlContent += "<span class='avatar-container'>"
      htmlContent += "<img class='avatar-img' src='" + item.thumb_url + "' alt=''>"
      htmlContent += "</span><div class='info-container'><input type='hidden' value='" + item.id + "' />"
      htmlContent += "<a href='/users/" + item.id + "' target='_blank' class='title'>" + item.display_name + "</a>"
      htmlContent += "<span class='location'><i class='zmdi zmdi-pin'></i>" + item.city + "</span></div>"
      htmlContent += "<div class='button-container'><a href='#' class='btn btn-primary btn-block' "
      htmlContent += "data-behavior='" + $behavior + "'><span>Add</span></a></div></div>"
      $appendDom.append($(htmlContent));
    });
    MOTORBRAG.applyBehaviors($appendDom);
    return false;
  }
};

MOTORBRAG.Behaviors.users_autocomplete = function() {
  var inputSearch, inputSearch;
  inputSearch = $(this).attr('id');
  appendDom = $(this).data('appendDom');
  behavior = $(this).data('itemBehavior');
  new app.Users(inputSearch, appendDom, behavior);
}
