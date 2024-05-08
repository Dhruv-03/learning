const outer = () => {
    const outerVar = "Hello!";

    
    const inner = () => {  // this inner function is a closure
        const innerVar = "Hi!";

        console.log(outerVar, innerVar);
    }

    return inner;
}

//Below code is possible
const innerFn = outer(); // here the inner function is returned before its executed

innerFn();

// inner(); -> this is not possible


// IMPORTANCE OF CLOSURE

/*

Normally in other languages Whenever a function is finished executing all the data/variables inside it gets deleted.
But sometimes we require that data/variables, so in order to use them we use closures.
Closures is something that gets created whenever a function returns a inner function.
This inner function can access parent fucnction's variable/data.

Without closure neither i can call the inner function directly.

Javascript uses closures!

*/