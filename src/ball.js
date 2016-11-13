// Generated by CoffeeScript 1.11.1
var Axis, Ball, Color, Random;

Axis = require('./axis.js');

Random = require('./random.js');

Color = require('./color.js');

Ball = (function() {
  var drag, fullCircleRadian, gravity;

  gravity = 0.6;

  drag = 0.99;

  fullCircleRadian = Math.PI * 2;

  function Ball(canvas, ctx, x, y) {
    var dx, dy;
    this.canvas = canvas;
    this.ctx = ctx;
    this.speed = Random.range(5, 10);
    this.radius = 10;
    dx = this.speed * Random.range(-1, 1);
    dy = this.speed * Random.range(-1, 0);
    this.x = new Axis.Linear(x, dx, this.canvas.width, this.radius);
    this.y = new Axis.Accel(y, dy, this.canvas.height, this.radius, gravity);
    this.color = new Color();
    this.stopped = false;
    this.stoppedX = false;
  }

  Ball.prototype.setNextPos = function() {
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
  };

  Ball.prototype.draw = function() {
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
  };

  return Ball;

})();

module.exports = Ball;