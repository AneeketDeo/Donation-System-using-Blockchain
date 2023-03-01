

// const Web3 = require('web3');
// const web3 = new Web3(Web3.givenProvider);

// const Authentication = artifacts.require("Authentication");

const contract = require('truffle-contract');
const myContract = contract(require('./build/contracts/Authentication.json'));
myContract.setProvider(web3.currentProvider);


function Register(){
    alert("is resgitered:");
    console.log("inside resgiter()");
    web3.eth.getAccounts().then(accounts => {
        console.log("Current user", accounts[0]); // this is the current user's address
        let userAddress = accounts[0];
        accessControl.authorize(userAddress, {from: "0x0792a69cc6aDd69E8c59957883aF1BE20f657366"});
        console.log(userAddress, " is now an admin");
      });
    
}


// authentication smart contract object
// const Authentication = artifacts.require("Authentication");

// web3.eth.getAccounts().then(accounts => {
//   let userAddress = accounts[0];
//   console.log("User address: ", userAddress);

//   //authorize user
//   Authentication.authorize(userAddress, {from: "0x0792a69cc6aDd69E8c59957883aF1BE20f657366"});
//   console.log("User is now an admin");
// }); 


// new steps
// web3.eth.getAccounts().then(accounts => {
//   console.log(accounts[0]); // this is the current user's address
// });

// Authentication.methods.isAuthorized(accounts[0]).call().then(function(authorized){
//   if(authorized) {
//       console.log("User is authorized");
//   } else {
//       console.log("User is not authorized");
//   }
// });



// ----------------------- artifacts---------------------------------//
// const contract = require("@truffle/contract");
// const MyContractJSON = require("../build/contracts/Authentication.json");

// const MyContract = contract(MyContractJSON);

// MyContract.setProvider(web3.currentProvider);

// // Now you can use the MyContract instance to interact with the contract
// MyContract.deployed().then(function(instance) {
//   // Call contract methods or send transactions here
//   console.log("it works");
// });


