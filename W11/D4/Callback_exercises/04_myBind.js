// simple myBind with no args
Function.prototype.myBind = function (ctx) {
    return () => this.apply(ctx);
};

// myBind with arguments
Function.prototype.myBind = function (ctx, ...bindArgs) {
    return (...callArgs) => {
        return this.apply(ctx, bindArgs.concat(callArgs));
    };
};

class Cat {
    constructor(name) {
        this.name = name;
    }

    meow() {
        console.log(`${this.name} says meow!`);
    }
}

const curie = new Cat("Curie");
setTimeout(curie.meow.myBind(curie), 1000);





function greet(msg) {
    console.log(`${msg}: ${this.name}`);
}

greet.apply(obj, ["Hello"]);
obj.greet("Hello");