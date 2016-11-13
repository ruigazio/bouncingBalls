// Generated by CoffeeScript 1.11.1
var Color, Random;

Random = require('./random.js');

Color = (function() {
  function Color(maxLevel1) {
    this.maxLevel = maxLevel1 != null ? maxLevel1 : 250;
    this.setRandomColor();
  }

  Color.prototype.setColorStr = function() {
    return this.string = "rgb(" + this.r + "," + this.g + "," + this.b + ")";
  };

  Color.prototype.setRandomMaxBrightness = function(maxLevel) {
    return this.maxLevel = maxLevel;
  };

  Color.prototype.setRandomColor = function() {
    this.r = Random.intUnder(this.maxLevel);
    this.g = Random.intUnder(this.maxLevel);
    this.b = Random.intUnder(this.maxLevel);
    return this.setColorStr();
  };

  Color.prototype.isFullWhite = function() {
    return this.r === 255 && this.g === 255 && this.b === 255;
  };

  Color.prototype.setBrighter = function() {
    var f;
    f = function(c) {
      if (c < 255) {
        return ++c;
      } else {
        return c;
      }
    };
    this.r = f(this.r);
    this.g = f(this.g);
    this.b = f(this.b);
    return this.setColorStr();
  };

  return Color;

})();

module.exports = Color;