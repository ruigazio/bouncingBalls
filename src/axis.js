const elasticity = 0.9;
const stopThreshold = 0.01;

class Linear {
  constructor(pos1, speed1, farEnd1, radius1) {
    this.pos = pos1;
    this.speed = speed1;
    this.farEnd = farEnd1;
    this.radius = radius1;
    this.hasSpeed = true;
    this.nudgeIn();
  }

  nudgeIn() {
    const newPos = this.pos + this.speed;
    if ((newPos - this.radius) < 0) {
      this.pos = this.radius;
    } else if ((newPos + this.radius) > this.farEnd) {
      this.pos = this.farEnd - this.radius;
    } else {
      this.pos = newPos;
      return false;
    }
    return true;
  }

  setNextPos() {
    if (this.nudgeIn()) {
      this.scaleSpeed(-elasticity);
    }
  }

  scaleSpeed(n) {
    this.speed *= n;
    if (Math.abs(this.speed) < stopThreshold) {
      this.hasSpeed = false;
    }
  }
}


class Accel extends Linear {

  constructor(pos, speed, farEnd, radius, accel) {
    super(pos, speed, farEnd, radius);
    this.accel = accel;
  }

  nudgeIn() {
    const prevPos = this.pos;
    const candidatePos = this.pos + this.speed;
    let distance = 0;
    if ((distance = candidatePos - this.radius) < 0) {
      this.pos = this.radius;
    } else if ((distance = candidatePos + this.radius - this.farEnd) > 0) {
      this.pos = this.farEnd - this.radius;
    } else {
      this.pos = candidatePos;
      return 0;
    }
		/*
     if there is a bounce, return the ratio of the candidate move 
		 made outside of the boundary
    */
    return distance / this.speed;
  }

  setNextPos() {
    const nudgeRatio = this.nudgeIn();
    if (nudgeRatio) {
      this.speed -= this.accel * nudgeRatio;
      this.scaleSpeed(-elasticity);
    } else {
      this.speed += this.accel;
    }
  }
}

module.exports = {Linear, Accel};
