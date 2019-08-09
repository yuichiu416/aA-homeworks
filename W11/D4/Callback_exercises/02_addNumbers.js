const readline = require('readline');

const reader = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

function addNumbers(sum, numsLeft, completionCallback) {
    if (numsLeft > 0) {
        reader.question('INPUT NUMBER HEATHEN:\n',
            function (integer){
                input = parseInt(integer);
                sum += input;
                console.log("New sum is " + sum);
                addNumbers(sum, --numsLeft, completionCallback);
            }
        );
    } else if (numsLeft === 0) {
        completionCallback(sum);
        reader.close();
    }
}

// addNumbers(0, 3, sum => console.log(`Total Sum: ${sum}`));