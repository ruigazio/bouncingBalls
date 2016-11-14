class Random {
  static range(l, r) {
    const breath = r - l;
    return breath * Math.random() + l;
  }

  static under(r) {
    return r * Math.random();
  }

  static intUnder() {
    return Math.floor(this.under.apply(this, arguments));
  }

  static intRange() {
    return Math.floor(this.range.apply(this, arguments));
  }
}

module.exports = Random;
