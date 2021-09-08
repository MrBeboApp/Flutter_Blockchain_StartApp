import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class FactoryContract extends ChangeNotifier{
  //192.168.1.4

  final String _networkUrl = "https://ropsten.infura.io/v3/768f39d26fab4c5ab58268e883532d4c";
  final String _networkSocketUrl = "wss://ropsten.infura.io/ws/v3/768f39d26fab4c5ab58268e883532d4c";
  final String _myAccountPrivateKey ="72ba4ba8c0b174e49b20c11facf03bbcab114cb3e1600932cfed4825ccb7aeb3";
  String myAddress = "0xA720eE5b6Fc85Ac3fc7438ca611Af88284E94113";
  String myContractAddress = "0x81502442c4d776f181f565c02eee32276d232c30";

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


Future <void>initialSetup() async {
    _client = Web3Client(_networkUrl,  Client(), socketConnector: () {
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
    _abiCode = jsonEncode(jsonAbi);
    _contractAddress =
        EthereumAddress.fromHex("0x81502442c4d776f181f565c02eee32276d232c30");
    print( "The Contract Address is "  + _contractAddress.toString());
    print(_abiCode);
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

