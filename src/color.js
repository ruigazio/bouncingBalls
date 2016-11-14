const Random = require('./random.js');

class Color {
  constructor(maxLevel1) {
    this.maxLevel = maxLevel1 != null ? maxLevel1 : 250;
    this.setRandomColor();
  }

  setColorStr() {
    return this.string = `rgb(${this.r},${this.g},${this.b})`;
  }

  setRandomMaxBrightness(maxLevel) {
    return this.maxLevel = maxLevel;
  }

  setRandomColor() {
    this.r = Random.intUnder(this.maxLevel);
    this.g = Random.intUnder(this.maxLevel);
    this.b = Random.intUnder(this.maxLevel);
    return this.setColorStr();
  };

  isFullWhite() {
    return this.r === 255 && this.g === 255 && this.b === 255;
  };

  setBrighter() {
    const f = function(c) {
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
  }
}

module.exports = Color;
