const Ball = require('./ball.js');

class Manager {
  constructor($canvas, $fps) {
    this.$canvas = $canvas;
    this.$fps = $fps;
    this.$canvas.height = 500;
    this.ctx = this.$canvas.getContext("2d");
    this.objs = [];
    this.timeStamp = 0;
    this.bbox = {
      left: this.$canvas.offsetLeft,
      top: this.$canvas.offsetTop,
      bottom: this.$canvas.offsetTop + this.$canvas.height - this.$canvas.clientTop,
      right: this.$canvas.offsetLeft + this.$canvas.width - this.$canvas.clientLeft
    };
    this.$canvas.addEventListener('click', this.clickHandler.bind(this));
    this.frameNo = 0;
    this.fpsTime = 0;
  }

  clickHandler(e) {
    const x = e.offsetX || (e.layerX - this.bbox.left);
    const y = e.offsetY || (e.layerY - this.bbox.top);
    return this.objs.push(new Ball(this.$canvas, this.ctx, x, y));
  }

  setElapsedTime() {
    const previousTime = this.timeStamp;
    this.timeStamp = performance.now();
    return this.elapsedTime = (this.timeStamp - previousTime) / 1000;
  }

  renderFPS() {
    const previousTime = this.fpsTime;
    this.fpsTime = performance.now();
    const totalTime = this.fpsTime - previousTime;
    this.$fps.innerText = Math.floor(50000 / totalTime);
    return this.frameNo = 0;
  }

  render() {
    this.frameNo++;
    if (!(this.frameNo % 50)) {
      this.renderFPS();
    }
    const elapsedTime = this.setElapsedTime();
    this.ctx.clearRect(0, 0, this.$canvas.width, this.$canvas.height);
    const newObjs = [];
    const objs = this.objs;
    const len = objs.length; 
    for (let i = 0; i < len; i++) {
      const o = objs[i];
      o.draw();
      if (!o.color.isFullWhite()) {
        newObjs.push(o);
      }
    }
    this.objs = newObjs;
    return requestAnimationFrame(this.render.bind(this));
  }
}

module.exports = Manager;
