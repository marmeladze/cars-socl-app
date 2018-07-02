String.prototype.toCamelCase = function() {
  return this.trim()
             .replace(/[^A-Za-z0-9]/g, ' ')
             .replace(/(.)/g, function (a, l) { return l.toLowerCase(); })
             .replace(/(\s.)/g, function (a, l) { return l.toUpperCase(); })
             .replace(/[^A-Za-z0-9]/g, '');
};
