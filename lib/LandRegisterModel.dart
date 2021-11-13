import 'package:flutter/cupertino.dart';
import 'package:land_registration/constant/constants.dart';
import 'package:web3dart/credentials.dart';
import 'package:web3dart/web3dart.dart';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class LandRegisterModel extends ChangeNotifier {
  bool isLoading = true;
  final String _rpcUrl = "http://192.168.43.130:7545";
  final String _wsUrl = "ws://192.168.43.130:7545/";

  String _privateKey =
      privateKey; //"b480f30c68bc885cd404d6328db62d5ca7fb4e2ad743c802cb2e6db5ac7530cf";

  late Web3Client _client;
  late String _abiCode;
  late Credentials _credentials;
  late EthereumAddress _contractAddress;
  late EthereumAddress _ownAddress;
  late DeployedContract _contract;
  late ContractFunction _addLandInspector;
  late ContractFunction _registerUser;
  late ContractFunction _isLandInspector;
  late ContractFunction _isContractOwner;
  late ContractFunction _isUserRegistered;
  late ContractFunction _makePaymentTest;
  late ContractFunction _allUsers;
  late ContractFunction _userInfo;
  late ContractFunction _verifyUser;

  LandRegisterModel() {
    //initiateSetup();
  }

  Future<void> initiateSetup() async {
    _privateKey = privateKey;
    _client = Web3Client(_rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });

    await getAbi();
    await getCredentials();
    await getDeployedContract();
  }

  Future<void> getAbi() async {
    String abiStringFile =
        await rootBundle.loadString("build/contracts/Land.json");
    var jsonAbi = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonAbi["abi"]);
    _contractAddress =
        EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
    //print(_contractAddress);
  }

  Future<void> getCredentials() async {
    print(_privateKey);

    _credentials = await _client.credentialsFromPrivateKey(_privateKey);
    _ownAddress = await _credentials.extractAddress();
    print(_ownAddress.toString());
  }

  Future<void> getDeployedContract() async {
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode, "Land"), _contractAddress);

    _addLandInspector = _contract.function("addLandInspector");
    _registerUser = _contract.function("registerUser");
    _isLandInspector = _contract.function("isLandInspector");
    _isContractOwner = _contract.function("isContractOwner");
    _isUserRegistered = _contract.function("isUserRegistered");
    _makePaymentTest = _contract.function("makePaymentTestFun");
    _allUsers = _contract.function("ReturnAllUserList");
    _userInfo = _contract.function("UserMapping");
    _verifyUser = _contract.function("verifyUser");
    // _todos = _contract.function("todos");
    // _taskCreatedEvent = _contract.event("TaskCreated");
    // getTodos();
    // print("");
  }

  makePaymentTestFun() async {
    notifyListeners();
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract,
            function: _makePaymentTest,
            parameters: [
              EthereumAddress.fromHex(
                  '0x201EbBC7497F593200D03c76B6804Fc0E0590Aa8')
            ],
            value: EtherAmount.fromUnitAndValue(EtherUnit.ether, 10)));
  }

  isContractOwner(String address) async {
    final val = await _client.call(
        sender: _ownAddress,
        contract: _contract,
        function: _isContractOwner,
        params: [_ownAddress]);
    print(val);
    return val[0];
  }

  Future<List<dynamic>> allUsers() async {
    notifyListeners();
    final val = await _client
        .call(contract: _contract, function: _allUsers, params: []);
    print(val);
    return val[0];
  }

  verifyUser(String address) async {
    notifyListeners();
    // await _client.call(
    //     contract: _contract,
    //     function: _verifyUser,
    //     params: [EthereumAddress.fromHex(address)]);
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract,
            function: _verifyUser,
            parameters: [
              EthereumAddress.fromHex(address),
            ]));
  }

  Future<List<dynamic>> userInfo(String address) async {
    notifyListeners();
    final val =
        await _client.call(contract: _contract, function: _userInfo, params: [
      EthereumAddress.fromHex(address),
    ]);
    print(val);
    return val;
  }

  Future<List<dynamic>> myProfileInfo() async {
    notifyListeners();
    final val =
        await _client.call(contract: _contract, function: _userInfo, params: [
      _ownAddress,
    ]);
    print(val);
    return val;
  }

  addLandInspector(String address, String name, String age, String desig,
      String city) async {
    isLoading = true;
    notifyListeners();
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract,
            function: _addLandInspector,
            parameters: [
              EthereumAddress.fromHex(address),
              name,
              BigInt.parse(age),
              desig,
              city
            ]));

    //getTodos();
  }

  isLandInspector(String address) async {
    final val = await _client.call(
        contract: _contract, function: _isLandInspector, params: [_ownAddress]);
    return val[0];
    print(val);
  }

  isUserregistered() async {
    final val = await _client.call(
        contract: _contract,
        function: _isUserRegistered,
        params: [_ownAddress]);
    return val[0];
  }

  registerUser(String name, String age, String city, String adhar, String pan,
      String document, String email) async {
    isLoading = true;
    notifyListeners();

    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract,
            function: _registerUser,
            parameters: [
              name,
              BigInt.parse(age),
              city,
              adhar,
              pan,
              document,
              email
            ]));

    //getTodos();
  }
}
