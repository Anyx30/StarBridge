import * as dotenvenc from "@chainlink/env-enc"
dotenvenc.config();
import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

const config: HardhatUserConfig = {
  solidity: "0.8.20",
  sourcify: {
    enabled: true
  },
  networks: {
    sepolia: {
      url: `${process.env.SEPOLIA_URL}`,
      accounts: [process.env.PRIVATE_KEY || ""],
    },
    mumbai: {
      url: `${process.env.MUMBAI_URL}`,
      accounts: [process.env.PRIVATE_KEY || ""],
    },
  },
  etherscan: {
    apiKey: {
      polygonMumbai: "VIT7XVFNT1RIGIMPDPY6QKEVJJ94DSNVVW",
      polygon: "9UHP9XAJW9C5CGVRG5IQ29ZEKTB7N12TRE",
      sepolia: "31WXEYFAGW4JBBSRRJZRJQB2GB5D6MB48W",
      mainnet: "31WXEYFAGW4JBBSRRJZRJQB2GB5D6MB48W",
    }
  }
};

export default config;
