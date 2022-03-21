require('dotenv').config();
require("@nomiclabs/hardhat-waffle");

const {API_URL_KEY, PRIVATE_KEY} = process.env;

module.exports = {
  solidity: "0.8.1",
  defaultNetwork: "rinkeby",
  networks: {
    hardhat: {},
    rinkeby: {
      url: API_URL_KEY,
      accounts: [`0x${PRIVATE_KEY}`]
    }
  }
};