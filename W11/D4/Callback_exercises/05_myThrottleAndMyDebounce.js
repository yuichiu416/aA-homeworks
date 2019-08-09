Function.prototype.myThrottle = function (interval) {
  // declare a variable outside of the returned function
  let tooSoon = false;
  return (...args) => {
    // the function only gets invoked if tooSoon is false
    // it sets tooSoon to true, and uses setTimeout to set it back to
    // false after interval ms
    // any invocation within this interval will skip the if 
    // statement and do nothing
    if (!tooSoon) {
      tooSoon = true;
      setTimeout(() => tooSoon = false, interval);
      this(...args);
    }
  }
}


Function.prototype.myDebounce = function (interval) {
  // declare a variable outside of the returned function
  let timeout;
  // return a function that takes an arbitrary number of arguments
  return (...args) => {
    // declare a function that sets timeout to null and invokes this with args
    const fnCall = () => {
      timeout = null;
      this(...args);
    }
    // each time this function is called, it will clear the previous timeout
    // and create a new one that invokes fnCall after the interval has passed
    // since the timeout is reset every time the function is invoked, 
    // fnCall will only be called once the interval has passed without any new 
    // invocations
    clearTimeout(timeout);
    timeout = setTimeout(fnCall, interval);
  }
}
function debounce(func, interval) {
  var timeout;
  return function () {
    var context = this, args = arguments;
    var later = function () {
      timeout = null;
      func.apply(context, args);
    };
    clearTimeout(timeout);
    timeout = setTimeout(later, interval || 200);
  }
}



class Neuron {
  fire() {
    console.log("Firing!");
  }
};

const neuron1 = new Neuron;
const neuron2 = new Neuron;
// When we create a new Neuron, 
// we can call #fire as frequently as we want

// The following code will try to #fire the neuron every 10ms. Try it in the console:
const interval = setInterval(() => {
  neuron.fire();
}, 10);

// You can use clearInterval to stop the firing:
clearInterval(interval);

// Using Function#myThrottle, we should be able to throttle 
// the #fire function of our neuron so that it can only fire 
// once every 500ms:

neuron1.fire = neuron1.fire.myThrottle(3);
// neuron2.fire = neuron2.fire.myDebounce(3000);

function sleep(miliseconds) {
  var currentTime = new Date().getTime();

  while (currentTime + miliseconds >= new Date().getTime()) {
  }
}

// neuron1.fire();
// neuron1.fire();
// neuron1.fire();
// sleep(3000);
// neuron1.fire();
// neuron1.fire();
// neuron1.fire();
// neuron2.fire();
// console.log("HELLO FRIEND")
// This time, if our Function#myThrottle worked correctly, 
// the Neuron#fire function should only be able to execute 
// every 500ms, even though we're still trying to invoke it 
// every 10ms!

// If we want this behavior for ALL neurons, we can do the same logic in the constructor:


class SearchBar {
  constructor() {
    this.query = "";

    this.type = this.type.bind(this);
    this.search = this.search.bind(this);
  }

  type(letter) {
    this.query += letter;
    this.search();
  }

  search() {
    console.log(`searching for ${this.query}`);
  }
}

const searchBar = new SearchBar;

const queryForHelloWorld = () => {
  searchBar.type("h");
  searchBar.type("e");
  searchBar.type("l");
  searchBar.type("l");
  searchBar.type("o");
  searchBar.type(" ");
  searchBar.type("w");
  searchBar.type("o");
  searchBar.type("r");
  searchBar.type("l");
  searchBar.type("d");
}

queryForHelloWorld();