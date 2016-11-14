const Axis = require('./axis.js');
const Random = require('./random.js');
const Color = require('./color.js');

const gravity = 0.6;
const drag = 0.99;
const fullCircleRadian = Math.PI * 2;


class Ball {

  constructor(canvas, ctx, x, y) {
    this.canvas = canvas;
    this.ctx = ctx;
    this.speed = Random.range(5, 10);
    this.radius = 10;
    const dx = this.speed * Random.range(-1, 1);
    const dy = this.speed * Random.range(-1, 0);
    this.x = new Axis.Linear(x, dx, this.canvas.width, this.radius);
    this.y = new Axis.Accel(y, dy, this.canvas.height, this.radius, gravity);
    this.color = new Color();
    this.stopped = false;
    this.stoppedX = false;
  }

  setNextPos () {
    if (this.y.hasSpeed) {
      this.y.setNextPos();
    } else {
      this.stoppedX || (this.stoppedX = true);
    }
    if (this.x.hasSpeed) {
      this.x.setNextPos();
      if (!this.y.hasSpeed) {
        return this.x.scaleSpeed(drag);
      }
    } else {
      if (this.stoppedX) {
        return this.stopped = true;
      }
    }
  }

  draw() {
    if (this.stopped) {
      this.color.setBrighter();
    } else {
      this.setNextPos();
    }
    this.ctx.fillStyle = this.color.string;
    this.ctx.beginPath();
    this.ctx.arc(this.x.pos, this.y.pos, this.radius, 0, fullCircleRadian, true);
    this.ctx.closePath();
    return this.ctx.fill();
  }
}

module.exports = Ball;
