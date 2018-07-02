MOTORBRAG.Utils = {
  location: function() {
    return window.location;
  },

  updateImagePlaceholder: function(placeHolder, fileInput, updateStyle) {
    updateStyle = updateStyle || false;
    if (fileInput.files && fileInput.files[0]) {
      var reader = new FileReader();

      reader.onload = function(e) {
        if(updateStyle) {
          var imageUrl = 'url(' + e.target.result + ')';
          placeHolder.css('background-image', imageUrl);
        } else {
          placeHolder.find('img').attr('src', e.target.result);
        }
      }
      reader.readAsDataURL(fileInput.files[0]);
    }
  },

  printObject: function(data) {
    var propValue;
    for(var propName in data) {
      console.log('key: ' + propName, '; value: ' + data[propName]);
    }
  }
};
