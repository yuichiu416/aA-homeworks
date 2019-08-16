function DOMNodeCollection(nodes) {
    this.elements = nodes;
}


DOMNodeCollection.prototype.html = function(str) {
    if (str === undefined) {
        return this.elements[0].innerHTML;
    } else {
        this.elements.forEach(el => {
            el.innerHTML = str;
        });
    }
}
DOMNodeCollection.prototype.empty = function() {
    this.html("");
}

DOMNodeCollection.prototype.append = function (collection) {
    if (collection instanceof DOMNodeCollection)
        this.elements = this.elements.concat(collection.elements);
    else if(typeof collection === "string"){ 
        this.elements.forEach(el => {
            el.innerHTML += collection;
        });
    }
    else{
        let obj = new DOMNodeCollection(collection);
        this.append(obj);
    }
}
DOMNodeCollection.prototype.attr = function() {
}

// DOMNodeCollection.prototype.addClass = function(className) {
//     this.elements.forEach(el => {
//         if el.className 
//     })

// }

DOMNodeCollection.prototype.removeClass = function() {

}

DOMNodeCollection.prototype.children = function () {
    let kids = [];
    this.elements.forEach(ele => {
        kids = kids.concat(ele.children);
    });
    return new DOMNodeCollection(kids);
}

DOMNodeCollection.prototype.parent = function () {
    const parents = [];
    this.elements.forEach(el => {
        let p = el.parentNode;
        if(!parents.includes(p))
            parents.push(p);
    });
    return parents;

}

DOMNodeCollection.prototype.find = function (selector) {
    let elements = [];
    let parents = this.parent();
    parents.forEach(parent => {
        elements = elements.concat(parent.querySelectorAll(selector))
    });
    return elements;
}

DOMNodeCollection.prototype.remove = function () {
    this.elements.forEach(el => {
        el.parentNode.removeChild(el);
    });
}

DOMNodeCollection.prototype.on = function(event, callback) {
    this.elements.forEach( el => {
        el.addEventListener(event, callback);
        el["callback"] = callback;
    });
}

DOMNodeCollection.prototype.off = function(event) {
    debugger;
    this.elements.forEach(el => {
        el.removeEventListener(event, el["callback"]);
    });
}



module.exports = DOMNodeCollection;