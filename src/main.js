// Generated by CoffeeScript 1.11.1
var Manager;

Manager = require('./manager.js');

document.addEventListener('DOMContentLoaded', function() {
  var $board, $fps;
  $board = document.querySelector('canvas#board');
  $fps = document.querySelector('span#fps');
  return setTimeout(function() {
    var manager;
    manager = new Manager($board, $fps);
    return manager.render();
  });
});