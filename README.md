# Blockchain-Based-Property-Registration

<a href="LICENSE"><img src="https://img.shields.io/static/v1?label=license&message=MIT&color=green"></a>
<img src="https://img.shields.io/badge/Ethereum-20232A?style=for-the-badge&logo=ethereum&logoColor=white">
<img src="https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white">
## Land Registration using Blockchain
## Problem it Solves:
1.) Removal of middlemen.\
Removal of middlemen or brokers makes the process less expensive. Brokers trying to cheat uneducated
people will no longer be able to do so. Brokers often take a long time to complete the procedures and so
our project will also save people time.\
2.) Distributed tamper proof ledger which prevents any fraud in ownership.\
3.) Secure storage of sensitive property registration documents using IPFS.

## Technology Stack:
1. Ethereum Blockchain
2. Polygon/Matic
3. Web3Dart
4. IPFS
5. Flutter
6. Metamask

## Demo
Demonstration video of our Dapp [here](https://youtu.be/0Coz_ivOaHs)

## Run Application on deployed website
Check deployed website [here](https://landregistry.live/)\
https://landregistry.live/ 

This is demo purpose. You can login as Land Inspector using this key:
 6b86cddfedbec68ed2a1c7e14b993840a0848595ba5787aec9e8a38b18f0d96a\
For user: 3ed4aff1a8ff8e28df3cd307112f9166886edcc85a27136908e3b1687b111f89\
For user you can also use your own Ethereum wallet key

#### Check Smart contract At Ropsten Ethereum Testnet: [here](https://ropsten.etherscan.io/address/0x702058ba021cd4e4f847b40f32b58aa5be3a4661)

## Run Application Locally
1.Clone the github repository and cd to the folder\
2.Install flutter,nodejs\
3.Install ganache and truffle
```
npm install -g truffle
```
4.Open Ganache and keep it running in the Background
5.Install Metamask chrome extension,choose local network and import accounts
6.Compile and run our migrations from the command line like this
```
truffle compile
truffle migrate
```
6.Copy contract address paste in ./lib/constant/constant.dart - 'contractAddress'\
7.In constant.dart file Change chainId to '1337' and change 'rpcUrl' to "http://127.0.0.1:7545" \
8.Run flutter web app
```
flutter run -d web-server --web-port 5555
```
9.Open the browser and the dapp will be running in http://localhost:5555/

## Project Flowchart
<img src="screenshots/flowchart.png" height="450">

## Screenshots
Home Page                   |                   Wallet connect/Login
:---------------------------------:        |      :------------------------------:
<img src="screenshots/Screenshot1.png" height="225">  |<img src="screenshots/Screenshot7.png" height="225">

Contract Owner Dashboard               |                   User Registration
:---------------------------------:        |      :------------------------------:
<img src="screenshots/Screenshot10.png" height="225">  |<img src="screenshots/Screenshot12.png" height="225">

Land Inspector Dashboard                   |                  User Verification 
:---------------------------------:        |      :------------------------------:
<img src="screenshots/Screenshot11.png" height="225">     |<img src="screenshots/Screenshot5.png" height="225">

User Dashboard               |                  Adding land on Map    
:---------------------------------:        |      :------------------------------:
<img src="screenshots/Screenshot2.png" height="225">     |<img src="screenshots/Screenshot8.png" height="225">

Land Gallery                |                   Land Details    
:---------------------------------:        |      :------------------------------:
<img src="screenshots/Screenshot3.png" height="225">     |<img src="screenshots/Screenshot9.png" height="225">

Received Request           |                   Make Payment  
:---------------------------------:        |      :------------------------------:
<img src="screenshots/Screenshot6.png" height="225">     |<img src="screenshots/Screenshot4.png" height="225">

Transfer ownership,Seller,buyer photo capture   |                Witness info,photo capture,transfer ownership 
:---------------------------------:        |      :------------------------------:
<img src="screenshots/Screenshot14.png" height="225">     |<img src="screenshots/Screenshot13.png" height="225">
