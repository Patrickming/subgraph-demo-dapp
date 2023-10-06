import { ethers } from "hardhat";

async function main() {
  //换成自己的地址
  let address = '0xf8488a8953d8ec67295fdeb841d2d7b3431e84f7'
  const registry = await ethers.getContractAt("GravatarRegistry", address)

  console.log('address:', registry.address)
  //拿到这个钱包所有的账户
  let [account1, account2] = await ethers.getSigners()
  //前两个账户调用createGravatar方法
  await registry.connect(account1).createGravatar('Carl', 'https://gateway.pinata.cloud/ipfs/QmRRPWG96cmgTn2qSzjwr2qvfNEuhunv6FNeMFGa9bx6mQ')
  await registry.connect(account2).createGravatar('Lucas', 'https://gateway.pinata.cloud/ipfs/QmcJYkCKK7QPmYWjp4FD2e3Lv5WCGFuHNUByvGKBaytif4')
  // await registry.connect(accounts[0]).updateGravatarName('Lucas');
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
