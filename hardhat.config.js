require("@nomicfoundation/hardhat-toolbox");
require("@openzeppelin/hardhat-upgrades");

const PRIVATE_KEY =
  "4ebc18edd0ac887ecf4b180afa98f0522191b44042952fb75de5da76269fa8c6";
const ETHERSCAN_API_KEY = "ADBB7AHJNJX28YGGSYDDYU883FX7DC7UBA";
const POLYGON_API_KEY = "B7WXSVHGACBV2UT5BCU8CX6A7QI7XI6ZSZ";

module.exports = {
  solidity: "0.8.17",
  networks: {
    goerli: {
      url: "https://goerli.infura.io/v3/328ff9ac7ccf4b8b98de2b55b4047bd6",
      accounts: [PRIVATE_KEY],
      timeout: 200000,
      confirmations: 2,
      gas: 21000000,
    },

    mumbai: {
      url: "https://matic-mumbai.chainstacklabs.com",
      accounts: [PRIVATE_KEY],
      timeout: 200000,
      confirmations: 2,
      gas: 21000000,
    },
  },
  etherscan: {
    apiKey: {
      goerli: ETHERSCAN_API_KEY,
      polygonMumbai: POLYGON_API_KEY,
    },
  },
};
