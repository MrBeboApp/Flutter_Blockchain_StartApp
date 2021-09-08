import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class FactoryContract extends ChangeNotifier{
  //192.168.1.4

  final String _networkUrl = "http://192.168.1.3:7545/";
  final String _networkSocketUrl = "ws://192.168.1.3:7545/";
  final String _myAccountPrivateKey ="cbd3dacf46cfbc8dcc3bf9490bda551eaab41dbe31bcccf09db47b9471ae615e";

  bool isLoading = true;
  Web3Client _client;

  String _abiCode;
  EthereumAddress _contractAddress;

  Credentials _credentials;
  EthereumAddress _ownAddress;


  DeployedContract _contract;
  ContractFunction _siteName;

  String siteNameDeplyed;


  FactoryContract(){
    initialSetup();
  }


initialSetup() async {
    _client = Web3Client(_networkUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_networkSocketUrl).cast<String>();
    });

    await getAbi();
    await getCredentials();
    await getDeployedContract();

  }

  //Get the abi from local file
  Future<void> getAbi() async {
    String abiStringFile = await rootBundle.loadString("src/abis/Name.json");
    var jsonAbi = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonAbi["abi"]);
    _contractAddress =
        EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
    print( "The Contract Address is "  + _contractAddress.toString());
  }

  Future<void> getCredentials() async {
    _credentials = await _client.credentialsFromPrivateKey(_myAccountPrivateKey);
    //Know What is the address of this contract
    _ownAddress = await _credentials.extractAddress();
    print("My Wallet Address is " + _ownAddress.toString());
  }

  Future<void> getDeployedContract() async {
    _contract =  DeployedContract(
        ContractAbi.fromJson(_abiCode, "Name"), _contractAddress);

    _siteName =  _contract.function("siteName");
    //Call teh function the return the name
    getSiteName();
  }

  getSiteName() async{
    print("we are in Get name function");
    try{
      List <dynamic>currentName = await _client.call(contract: _contract, function: _siteName, params: []);
      print("we are in Get name function after current array");
      siteNameDeplyed =currentName[0];
      isLoading = false;
    }catch(e){
      print(e);
    }

    notifyListeners();
  }

}

