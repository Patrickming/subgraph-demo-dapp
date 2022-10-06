# Subgraph实现dapp实战教程

> 本文收录于我的开源项目：https://github.com/dukedaily/solidity-expert ，欢迎star转发，文末加V入群。

通过学习本文，将全面掌握如何搭建graphnode，创建部署subgraph，以及如何与合约前端结合展示，通过一个完整的dapp案例，展示dapp开发的全部流程

背景知识，subgraph是什么，另见文章: https://dukedaily.github.io/solidity-expert/07_subgraph/01_%E6%A6%82%E8%BF%B0.html

- 本文代码：https://github.com/dukedaily/subgraph-demo

- 本文视频：本文视频：录制中⏺️

- 效果展示：https://dukedaily.github.io/subgraph-demo-dapp （需要先下载代码，本地运行docker-compose up）

  ![image](assets/image-5022356.png)



## 1. 下载代码

```sh
git clone git@github.com:dukedaily/subgraph-demo-dapp.git
```

## 2. 部署合约

```Bash
# 进入合约目录
cd subgraph-demo-dapp/contracts

# 配置.env信息
ETHERSCAN_API_KEY=''
ALCHEMY_KEY=''
INFURA_KEY=''

MNEMONIC=''
PRIVATE_KEY=''

# 安装
npm i

# 编译
npm run compile

# 部署：address: 0x48d2825f3238db40797dF659C97188d289401311
npx hardhat run scripts/deploy.ts --network goerli

# 初始化
npx hardhat run scripts/setup.ts --network goerli

# verify
npx hardhat verify 0x48d2825f3238db40797dF659C97188d289401311 --network goerli
```

## 3. 配置subgraph

请查看具体文件：

```sh
# 三个文件的关系：
subgraph.yaml：需要监听合约信息配置，包括：
    - 合约地址
    - 网络
    - 事件
    - 起始块高
schema.graphql：映射到本地db中的格式
    - 定义本地数据表，与脸上事件进行映射等
    
src/mapping.ts；真正的映射逻辑，业务逻辑
    - NewGravatar 链上合约发送到事件
    - Gravatar graph本地定义的结构（schema）
    - NewGravatar -> mappings -> Gravatar -> 入库
```

## 4. 启动graphnode（docker）

```sh
# 先修改监听的网络rpc: ethereum: 'goerli:https://ethereum-goerli-rpc.allthatnode.com'

# 确保docker已经启动
docker-compose up
```

## 5. 创建subgraph（本地）

```sh
# 先创建subgraph
yarn create-local

# 后部署
yarn deploy-local
```

![image-20220519221014419](assets/image-20220519221014419.png)

## 6. 测试一下效果

url：http://127.0.0.1:8000/subgraphs/name/dukedaily/example-subgraph/graphql

```sql
{
  gravatars {
    id
    owner
    displayName
    imageUrl
  }
}
```

执行请求成功！

![image-20220519221147734](assets/image-20220519221147734.png)

## 7. 准备前端

进入到dapp文件夹，修改内容如下：

```sh
#echo "REACT_APP_GRAPHQL_ENDPOINT=http://localhost:8000/subgraphs/name/<GITHUB_USERNAME>/example-subgraph" > .env

REACT_APP_GRAPHQL_ENDPOINT=http://127.0.0.1:8000/subgraphs/name/dukedaily/subgraph-demo
```

启动前端

```sh
yarn install  # global VPN mode
yarn start
```

## 8. 安装有问题（可选）

```sh
# 删除文件
rm -rf yarn.lock

# 安装nvm，安装后需要配置文件，请仔细查看打印的log，有指导
brew install nvm

# 切换node版本，版本查询：https://www.npmjs.com/package/node
nvm install v10.24.1
nvm use v10.24.1

# 重新安装
npm install
```



## 9. 查看效果

效果如下，切换Order By可以调整展示顺序，由于网络问题，图片没能正常展示，可以在代码中自行替换。

![image](assets/image.png)



加V入群：Adugii，公众号：阿杜在新加坡，一起抱团拥抱web3，下期见！



> 关于作者：国内第一批区块链布道者；2017年开始专注于区块链教育(btc, eth, fabric)，目前base新加坡，专注海外defi,dex,元宇宙等业务方向。