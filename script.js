//function declaration
//these are used only if u want to use `this` keyword
function cube(number){
    return number*number*number;
}

//function expression
let result = function (number){
     return number*number;
}

//arrow function (expression)
//these are used mostly to create functions
let name = (parameter) => {
    console.log(`Hi ${parameter}`);
}

//calling the arrow function
// name("DKS")

// * FUNCTIONS RETURN UNDEFINED IF NOT SPECIFIED* //
// console.log(typeof NaN)


//strings exercise
const guestList = 'Our guests are: emma, jacob, isabella, ethan';

const length = guestList.length;

console.log(length);

const upperCasedGuestList = guestList.toUpperCase();
console.log(upperCasedGuestList);

const isEthanOnTheList = upperCasedGuestList.includes('ETHAN');

console.log(isEthanOnTheList);

const substringGuests = upperCasedGuestList.slice(upperCasedGuestList.indexOf('EMMA'));
console.log(substringGuests);

let guests = substringGuests.split(", ");
console.log(guests);


//map is similar to forEach. only difference is that map returns an array while forEach does not return anything
// it returns undefined. also map allocates memory to store and return values while forEach does not allocate 
// any memory.

const inventory = [1,2,3,4,5,6];

const incrBy2 = inventory.map((value,i) => value+2);

console.log(incrBy2);

