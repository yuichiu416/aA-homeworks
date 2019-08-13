/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, { enumerable: true, get: getter });
/******/ 		}
/******/ 	};
/******/
/******/ 	// define __esModule on exports
/******/ 	__webpack_require__.r = function(exports) {
/******/ 		if(typeof Symbol !== 'undefined' && Symbol.toStringTag) {
/******/ 			Object.defineProperty(exports, Symbol.toStringTag, { value: 'Module' });
/******/ 		}
/******/ 		Object.defineProperty(exports, '__esModule', { value: true });
/******/ 	};
/******/
/******/ 	// create a fake namespace object
/******/ 	// mode & 1: value is a module id, require it
/******/ 	// mode & 2: merge all properties of value into the ns
/******/ 	// mode & 4: return value when already ns object
/******/ 	// mode & 8|1: behave like require
/******/ 	__webpack_require__.t = function(value, mode) {
/******/ 		if(mode & 1) value = __webpack_require__(value);
/******/ 		if(mode & 8) return value;
/******/ 		if((mode & 4) && typeof value === 'object' && value && value.__esModule) return value;
/******/ 		var ns = Object.create(null);
/******/ 		__webpack_require__.r(ns);
/******/ 		Object.defineProperty(ns, 'default', { enumerable: true, value: value });
/******/ 		if(mode & 2 && typeof value != 'string') for(var key in value) __webpack_require__.d(ns, key, function(key) { return value[key]; }.bind(null, key));
/******/ 		return ns;
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = "./src/index.js");
/******/ })
/************************************************************************/
/******/ ({

/***/ "./src/asteroid.js":
/*!*************************!*\
  !*** ./src/asteroid.js ***!
  \*************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

eval("const Util = __webpack_require__(/*! ./util.js */ \"./src/util.js\");\nconst MovingObject = __webpack_require__(/*! ./moving_object.js */ \"./src/moving_object.js\")\n\nconst DEFAULTS = {\n    COLOR: \"#333333\",\n    RADIUS: 10,\n    SPEED: 4,   \n};\n\nfunction Asteroid(options) {\n    options = options || {};\n    options.color = DEFAULTS.COLOR;\n    options.pos = options.pos || options.game.randomPosition();\n    options.radius = DEFAULTS.RADIUS;\n    options.vel = options.vel || Util.randomVec(DEFAULTS.SPEED);\n\n    MovingObject.call(this, options)\n};\n\n\nUtil.inherits(Asteroid, MovingObject);\n\nmodule.exports = Asteroid;\n\n\n//# sourceURL=webpack:///./src/asteroid.js?");

/***/ }),

/***/ "./src/game.js":
/*!*********************!*\
  !*** ./src/game.js ***!
  \*********************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

eval("const Asteroid = __webpack_require__(/*! ./asteroid.js */ \"./src/asteroid.js\")\nconst Util = __webpack_require__(/*! ./util.js */ \"./src/util.js\")\nconst Ship = __webpack_require__(/*! ./ship */ \"./src/ship.js\");\n\nfunction Game() {\n    this.DIM_X = 800;\n    this.DIM_Y = 600;\n    this.NUM_ASTEROIDS = 10;\n    this.asteroids = [];\n    this.ships = [];\n    this.addAsteroids();\n}\n\n\nGame.prototype.addAsteroids = function(){\n    for (let i = 0; i < this.NUM_ASTEROIDS; i++) {\n        // this.add(new Asteroid());\n        this.asteroids.push(new Asteroid({game: this}));\n    }\n}\n\nGame.prototype.addShip = function() {\n    const ship = new Ship({\n        pos: [this.DIM_X/2, this.DIM_Y/2],\n        game: this\n    });\n    this.ships.push(ship);\n    return ship;\n}\n\nGame.prototype.randomPosition = function() {\n    return [this.DIM_X * Math.random(), this.DIM_Y * Math.random()];\n}\n\nGame.prototype.draw = function(ctx) {\n    ctx.clearRect(0, 0, this.DIM_X, this.DIM_Y);\n    this.asteroids.forEach(asteroid => asteroid.draw(ctx));\n    this.ships.forEach(ship => ship.draw(ctx));\n}\n\n\nGame.prototype.moveObjects = function(delta) {\n    this.asteroids.forEach(asteroid => asteroid.move(delta));\n}\n\nGame.prototype.isOutOfBounds = function(pos) {\n  return pos[0] < 0 || pos[1] < 0 || pos[0] > Game.DIM_X || pos[1] > Game.DIM_Y;\n};\n\nGame.prototype.wrap = function(pos) {\n    return [\n        Util.wrap(pos[0], this.DIM_X), Util.wrap(pos[1], this.DIM_Y)\n    ];\n};\n\nGame.prototype.remove = function remove(object) {\n    if (object instanceof Asteroid) {\n        this.asteroids.splice(this.asteroids.indexOf(object), 1);\n    } else {\n        throw new Error(\"unknown type of object\");\n    }\n};\n\nGame.prototype.checkCollisions = function() {\n    for (let i = 0; i < this.asteroids.length - 1; i++) {        \n        for (let j = i + 1; j < this.asteroids.length; j++) {\n            let obj1 = this.asteroids[i];\n            let obj2 = this.asteroids[j];\n            if (obj1.isCollidedWith(obj2)) {\n                this.remove(obj2);\n                this.remove(obj1);\n            }\n        }\n    }\n};\n\nGame.prototype.step = function(delta) {\n    this.moveObjects(delta);\n    this.checkCollisions();\n};\n\nGame.prototype.remove = function(asteroid) {\n    this.asteroids.splice(this.asteroids.indexOf(asteroid), 1);\n}\n\nmodule.exports = Game;\n\n\n//# sourceURL=webpack:///./src/game.js?");

/***/ }),

/***/ "./src/game_view.js":
/*!**************************!*\
  !*** ./src/game_view.js ***!
  \**************************/
/*! no static exports found */
/***/ (function(module, exports) {

eval("function GameView(game, ctx) {\n    this.ctx = ctx;\n    this.game = game;\n    this.ship = this.game.addShip();\n}\n\nGameView.prototype.start = function() {\n    this.setInterval(20);\n}\n\n\nGameView.prototype.setInterval = function(delta){\n    setInterval(\n        function(){ \n            this.game.draw(ctx);\n            this.game.step(delta);\n        }\n    , delta);\n}\n\nmodule.exports = GameView;\n\n//# sourceURL=webpack:///./src/game_view.js?");

/***/ }),

/***/ "./src/index.js":
/*!**********************!*\
  !*** ./src/index.js ***!
  \**********************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

eval("const MovingObject = __webpack_require__(/*! ./moving_object.js */ \"./src/moving_object.js\");\nconst Asteroid = __webpack_require__(/*! ./asteroid.js */ \"./src/asteroid.js\");\nconst Game = __webpack_require__(/*! ./game.js */ \"./src/game.js\");\nconst GameView = __webpack_require__(/*! ./game_view.js */ \"./src/game_view.js\")\n\nwindow.MovingObject = MovingObject;\nwindow.Asteroid = Asteroid;\n\ndocument.addEventListener(\"DOMContentLoaded\", function () {\n    const canvasEl = document.getElementsByTagName(\"canvas\")[0];\n    const game = new Game();\n    canvasEl.width = game.DIM_X;\n    canvasEl.height = game.DIM_Y;\n    const ctx = canvasEl.getContext(\"2d\");\n    window.ctx = ctx;\n    window.game = game;\n    const gv = new GameView(game, ctx);\n    gv.start();\n});\n\n\n//# sourceURL=webpack:///./src/index.js?");

/***/ }),

/***/ "./src/moving_object.js":
/*!******************************!*\
  !*** ./src/moving_object.js ***!
  \******************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

eval("const Util = __webpack_require__(/*! ./util */ \"./src/util.js\");\n\nfunction MovingObject(obj){\n    this.pos = obj.pos;\n    this.vel = obj.vel;\n    this.radius = obj.radius;\n    this.color = obj.color;\n    this.game = obj.game;\n};\n\n// var mo = new MovingObject(\n//     { pos: [30, 30], vel: [10, 10], radius: 5, color: \"#00FF00\" }\n// );\n\n\nMovingObject.prototype.draw = function draw(ctx){\n    // console.log(`calling draw on ${this}`);\n    ctx.fillStyle = this.color;\n    ctx.beginPath();\n    ctx.arc(\n        this.pos[0], this.pos[1], this.radius, 0, 2 * Math.PI, true\n    );\n    ctx.fill();\n};\n\nMovingObject.prototype.move = function move(delta) {\n    this.pos = [this.pos[0] + this.vel[0], this.pos[1] + this.vel[1]];\n\n    if (this.game.isOutOfBounds(this.pos)) {\n        this.pos = this.game.wrap(this.pos);\n    }\n};\n\nMovingObject.prototype.remove = function remove() {\n    this.game.remove(this);\n};\n\nMovingObject.prototype.isCollidedWith = function(otherObject) {\n    let distance = Util.distance(this.pos, otherObject.pos);\n    return distance < (this.radius + otherObject.radius);\n};\n\n// MovingObject.prototype.collideWith = function(otherObject) {\n    \n// }\n\nmodule.exports = MovingObject;\n\n//# sourceURL=webpack:///./src/moving_object.js?");

/***/ }),

/***/ "./src/ship.js":
/*!*********************!*\
  !*** ./src/ship.js ***!
  \*********************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

eval("const MovingObject = __webpack_require__(/*! ./moving_object */ \"./src/moving_object.js\");\nconst Util = __webpack_require__(/*! ./util */ \"./src/util.js\");\n\nconst DEFAULTS = {\n    COLOR: \"#0015FF\",\n    RADIUS: 10,\n};\n\nfunction Ship(options) {\n    options.radius = options.radius || DEFAULTS.RADIUS;\n    options.color = options.color || DEFAULTS.COLOR;\n    options.vel = options.vel || [0, 0];\n\n    MovingObject.call(this, options);\n};\n\nUtil.inherits(Ship, MovingObject);\n\nmodule.exports = Ship;\n\n//# sourceURL=webpack:///./src/ship.js?");

/***/ }),

/***/ "./src/util.js":
/*!*********************!*\
  !*** ./src/util.js ***!
  \*********************/
/*! no static exports found */
/***/ (function(module, exports) {

eval("const Util = {\n\ninherits (childClass, parentClass)  {\n    // function Surrogate(){}\n    // Surrogate.prototype = parentClass.prototype;\n    childClass.prototype = Object.create(parentClass.prototype);\n    childClass.prototype.constructor = childClass;\n},\n// Return a randomly oriented vector with the given length.\nrandomVec(length) {\n    const deg = 2 * Math.PI * Math.random();\n    return Util.scale([Math.sin(deg), Math.cos(deg)], length);\n},\n// Scale the length of a vector by the given amount.\nscale(vec, m) {\n    return [vec[0] * m, vec[1] * m];\n},\nwrap(coord, max) {\n    if (coord < 0) {\n        return max - (coord % max);\n    } else if (coord > max) {\n        return coord % max;\n    } else {\n        return coord;\n    }\n},\ndistance(pos1, pos2) {\n    return Math.sqrt(Math.pow((pos1[0] - pos2[0]), 2) + Math.pow((pos1[1] - pos2[1]), 2));\n}\n\n\n\n\n\n\n\n\n};\n\n// Other properties are filled in for you.\n// new Asteroid({ pos: [30, 30] });\n\nmodule.exports = Util;\n\n//# sourceURL=webpack:///./src/util.js?");

/***/ })

/******/ });