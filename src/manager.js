const Ball = require('./ball.js');

class Manager {
  constructor($canvas, $fps) {
    this.$canvas = $canvas;
    this.$fps = $fps;
    this.$canvas.height = 500;
    this.ctx = this.$canvas.getContext("2d");
    this.objs = [];
    this.$canvas.addEventListener('click', this.clickHandler.bind(this));
    this.frameNo = 0;
    this.fpsTime = 0;
  }

  clickHandler(e) {
    const x = e.offsetX || (e.layerX - this.$canvas.offsetLeft);
    const y = e.offsetY || (e.layerY - this.$canvas.offsetTop);
    this.objs.push(new Ball(this.$canvas, this.ctx, x, y));
  }

  renderFPS() {
    const previousTime = this.fpsTime;
    this.fpsTime = performance.now();
    const totalTime = this.fpsTime - previousTime;
    this.$fps.innerText = Math.floor(50000 / totalTime);
    this.frameNo = 0;
  }

  render() {
    this.frameNo++;
    if (!(this.frameNo % 50)) {
      this.renderFPS();
    }
    this.ctx.clearRect(0, 0, this.$canvas.width, this.$canvas.height);
    const newObjs = [];
    for (let o of this.objs) {
      if (!o.color.isFullWhite()) {
        o.draw();
        newObjs.push(o);
      }
    }
    this.objs = newObjs;
    requestAnimationFrame(this.render.bind(this));
  }
}

module.exports = Manager;
