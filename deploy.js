const HDWalletProvider = require('truffle-hdwallet-provider');
const Web3 = require('web3');
const {interface, bytecode} = require('./compile.js');

const provider = new HDWalletProvider(
    'open genuine misery razor saddle lion exclude work cover stuff report barely',
    'https://rinkeby.infura.io/v3/eb85d6cc147847dab83bda32794ef493'
)

const web3 = new Web3(provider);

const deploy = async () => {
    const accounts = await web3.eth.getAccounts();
    console.log('Attempting to deploy from:',accounts[0]);

    const result = await new web3.eth.Contract(JSON.parse(interface))
        .deploy({ data: bytecode, arguments: ['Hi there!']})
        .send({from: accounts[0], gas: '1000000'})
    
    console.log('Contract deployed to',result.options.address);
};

deploy();