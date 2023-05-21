module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*", // Match any network id
      networkCheckTimeout: 1000000 // Increase the timeout value as needed
    }
  },
  compilers:{
    solc: {
      version: "^0.8.17",
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  }
}