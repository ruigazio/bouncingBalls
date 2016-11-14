const Manager = require('./manager.js');

document.addEventListener('DOMContentLoaded', function() {
  const $board = document.querySelector('canvas#board');
  const $fps = document.querySelector('span#fps');
  return setTimeout(function() {
    const manager = new Manager($board, $fps);
    return manager.render();
  });
});
