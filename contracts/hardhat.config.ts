import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "@openzeppelin/hardhat-upgrades";

//在配置文件中引用
require('dotenv').config()

const ALCHEMY_KEY = process.env.ALCHEMY_KEY || ''
const INFURA_KEY = process.env.INFURA_KEY || ''
const PRIVATE_KEY = process.env.PRIVATE_KEY || ''
const ETHERSCAN_API_KEY = process.env.ETHERSCAN_API_KEY || ''
const MNEMONIC = process.env.MNEMONIC || ''
const MNEMONIC_PATH = "m/44'/60'/0'/0"

const config: HardhatUserConfig = {
  // solidity: "0.8.9",
  // 配置网络 kovan, bsc, mainnet
  networks: {
    hardhat: {
    },
    goerli: {
      url: `https://eth-goerli.g.alchemy.com/v2/${ALCHEMY_KEY}`,
      accounts: [PRIVATE_KEY]
    }
  },
  // 配置自动化verify相关
  etherscan: {
    apiKey: {
      goerli: ETHERSCAN_API_KEY
    }
  },
  // 配置编译器版本
  solidity: {
    version: "0.8.10",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  },
};

export default config;
