const Random = require('./random.js');

class Color {
  constructor(maxLevel = 250) {
    this.maxLevel = maxLevel;
    this.setRandomColor();
  }

  setColorStr() {
    this.string = `rgb(${this.r},${this.g},${this.b})`;
  }

  setRandomMaxBrightness(maxLevel) {
    this.maxLevel = maxLevel;
  }

  setRandomColor() {
    this.r = Random.intUnder(this.maxLevel);
    this.g = Random.intUnder(this.maxLevel);
    this.b = Random.intUnder(this.maxLevel);
    this.setColorStr();
  };

  isFullWhite() {
    return this.r === 255 && this.g === 255 && this.b === 255;
  };

  setBrighter() {
    const f = function(c) {
      if (c < 255) {
        return c+1;
      } else {
        return c;
      }
    };

    this.r = f(this.r);
    this.g = f(this.g);
    this.b = f(this.b);
    this.setColorStr();
  }
}

module.exports = Color;
