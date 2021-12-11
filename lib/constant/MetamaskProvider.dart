import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web3/flutter_web3.dart';

class MetaMaskProvider extends ChangeNotifier {
  static const operatingChain = 80001;

  String currentAddress = '';

  int currentChain = -1;

  bool get isEnabled => ethereum != null;

  bool get isInOperatingChain => currentChain == operatingChain;

  bool get isConnected => isEnabled && currentAddress.isNotEmpty;

  final rpcProvider = JsonRpcProvider(
      'https://rpc-mumbai.maticvigil.com/v1/a5be973518c173bacd9be16a6314dd08b6abcd23');

  var contract;

  final abi = [
    // Some details about the token
    "function ReturnAllLandList() public view returns(uint[] memory)",
    "function ReturnAllUserList() public view returns(address[] memory)",
    "function isUserRegistered(address _addr) public view returns(bool)",
    "function makePaymentTestFun(address payable _reveiver) public payable",
    "function UserMapping(address) public view returns(address id,string name,uint age,string city,string aadharNumber,string panNumber,string document,string email,bool isUserVerified)",
    "function addLand(uint _area, string memory _city,string memory _state, uint landPrice, uint _propertyPID,uint _surveyNum, string memory _document) public",
    "function myAllLands(address id) public view returns( uint[] memory)",
    "function lands(uint) public view returns(uint id,uint area,string city,string state,uint landPrice,uint propertyPID,uint physicalSurveyNumber,string document,bool isforSell,address payable ownerAddress,bool isLandVerified)",
    "function ReturnAllLandList() public view returns(uint[] memory)",
    "function makeItforSell(uint id) public",
    "function requestforBuy(uint _landId) public",
    "function myReceivedLandRequests() public view returns(uint[] memory)",
    "function mySentLandRequests() public view returns(uint[] memory)",
    "function LandRequestMapping(uint) public view returns(uint reqId,address payable sellerId,address payable buyerId,uint landId,uint8 requestStatus,bool isPaymentDone)",
    "function acceptRequest(uint _requestId) public",
    "function rejectRequest(uint _requestId) public",
    "function registerUser(string memory _name, uint _age, string memory _city,string memory _aadharNumber, string memory _panNumber, string memory _document, string memory _email) public",
    "function makePayment(uint _requestId) public payable"
  ];

  Future<void> connect() async {
    if (isEnabled) {
      final accs = await ethereum!.requestAccount();
      if (accs.isNotEmpty) currentAddress = accs.first;
      print(currentAddress);
      currentChain = await ethereum!.getChainId();

      // Get signer from provider
      // final signer = provider!.getSigner();
      // var t = await signer.getBalance();

      contract = Contract(
        "0x5Fa4972AB37701FA32907E79b46DDD436bd73B05",
        Interface(abi),
        provider!.getSigner(),
      );
      notifyListeners();
    }
  }

  sendtrans() async {
    final tx = await provider!.getSigner().sendTransaction(
          TransactionRequest(
            to: '0xf9949ED609523b1F550094E6c19Be80e6DBE38F1',
            value: BigInt.from(100000),
          ),
        );
  }

  clear() {
    currentAddress = '';
    currentChain = -1;
    notifyListeners();
  }

  init() {
    if (isEnabled) {
      ethereum!.onAccountsChanged((accounts) {
        clear();
      });
      ethereum!.onChainChanged((accounts) {
        clear();
      });
    }
  }

  Future<bool> isUserRegistered() async {
    final t =
        await contract.call<dynamic>('isUserRegistered', [currentAddress]);
    print(t);
    return t;
  }

  Future<List<dynamic>> myProfileInfo() async {
    final t = await contract.call<dynamic>('UserMapping', [currentAddress]);
    print(t);
    return t;
  }

  addLand(String area, String city, String state, String landPrice, String PID,
      String surveyNo, String docu) async {
    await contract.send(
      'addLand',
      [area, city, state, landPrice, PID, surveyNo, docu],
    );
  }

  Future<List<dynamic>> myAllLands() async {
    final val = await contract.call<dynamic>('myAllLands', [currentAddress]);
    print(val);
    return val;
  }

  Future<List<dynamic>> landInfo(dynamic id) async {
    final val = await contract.call<dynamic>('lands', [id.toString()]);
    print(val);
    return val;
  }

  Future<List<dynamic>> allLandList() async {
    final val = await contract.call<dynamic>('ReturnAllLandList', []);
    print(val);
    return val;
  }

  makeForSell(dynamic id) async {
    await contract.send(
      'makeItforSell',
      [id.toString()],
    );
  }

  sendRequestToBuy(dynamic landId) async {
    await contract.send(
      'requestforBuy',
      [landId.toString()],
    );
  }

  Future<List<dynamic>> myReceivedRequest() async {
    final val = await contract.call<dynamic>('myReceivedLandRequests', []);
    print(val);
    return val;
  }

  Future<List<dynamic>> mySentRequest() async {
    final val = await contract.call<dynamic>('mySentLandRequests', []);
    print(val);
    return val;
  }

  Future<List<dynamic>> requestInfo(dynamic requestId) async {
    final val = await contract
        .call<dynamic>('LandRequestMapping', [requestId.toString()]);
    //print(val);
    return val;
  }

  acceptRequest(dynamic reqId) async {
    await contract.send(
      'acceptRequest',
      [reqId.toString()],
    );
  }

  rejectRequest(dynamic reqId) async {
    await contract.send(
      'rejectRequest',
      [reqId.toString()],
    );
  }

  registerUser(String name, String age, String city, String adhar, String pan,
      String document, String email) async {
    await contract.send(
      'registerUser',
      [name, age, city, adhar, pan, document, email],
    );
  }

  makePayment(dynamic reqId, dynamic price) async {
    final tx = await contract.send(
      'makePayment',
      [reqId.toString()],
      TransactionOverride(
        value: BigInt.from(price * pow(10, 18)),
      ),
    );
  }

  makeTestPayment() async {
    final tx = await contract.send(
      'makePaymentTestFun',
      ['0xf9949ED609523b1F550094E6c19Be80e6DBE38F1'],
      TransactionOverride(
        value: BigInt.from(100000000000),
      ),
    );
  }
}
