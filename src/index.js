let account;
// (1) UNCOMMENT TO VERIFY METAMASK CONNECTION
const accountEl = document.getElementById('account');

const ethEnabled = async () => {
  if (window.ethereum) {
    console.log("Metamask connected successsfully");
    const accounts = await window.ethereum.request({method: 'eth_requestAccounts'});
    account = accounts[0];
    //(2) UNCOMMENT TO VERIFY METAMASK CONNECTION
    // accountEl.innerHTML = account;
    return true;
  }
  else{
    console.log("Metamask connection failed!");
    return false;
  }
  
}
ethEnabled();