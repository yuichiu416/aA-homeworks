const DOMNodeCollection = require('./dom_node_collection');

const queue = [];

window.addEventListener('DOMContentLoaded', (event) => {
    console.log('DOM fully loaded and parsed');
    queue.forEach(func => {
        func();
    });
});

function $l (el) {
    if (typeof el === "function") {
        queue.push(el);
    }
    else if (el instanceof HTMLElement) {
        return new DOMNodeCollection(Array.from(el));
    } else {
        const elements = document.querySelectorAll(el);
        return new DOMNodeCollection(Array.from(elements));
    }
};

$l.extend = function (...args) {
    const first = args[0];
    args = args.slice(1);
    args.forEach(arg => {
        const keys = Object.keys(arg);
        keys.forEach(key => {
            first[key] = arg[key];
        })
    })
    return first;
};

$l.ajax = function(obj) {
    method = "GET";
    url = 'http://api.openweathermap.org/data/2.5/weather' +
        '?q=London,uk&appid=bcb83c4b54aee8418983c2aff3073b3b';

    //step 1 - create xhr object
    const xhr = new XMLHttpRequest();
    // step 2 - specify path and verb
    xhr.open(`${method}`, `${url}`);  
    // step 3 - register a callback
    let status;
    let data;

    xhr.onload = function () {
        status = xhr.status; // for status info
        data = xhr.response; //the actual response. For JSON api calls, this will be a JSON string
    };

    xhr.send();
    success = (obj && obj["success"]) ? obj["sucess"] : function(data){console.log("ajax succeeded")};
    error = (obj && obj["error"]) ? obj["error"] : function (data) {console.error("An error occurred. Hehehehe.")};
    
    if (status)
        success();
    else
        error();   
    console.log(`status is ${status}`);
    
}


window.$l = $l;





// $l(function () {
//     console.log("下班囉");
// });
// $l(function () {
//     console.log("社畜還想下班  笑死");
// });