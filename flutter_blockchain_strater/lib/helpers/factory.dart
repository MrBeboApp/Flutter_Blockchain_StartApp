import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class Factory {

  final String _networkUrl = "http://127.0.0.1:7545";
  final String _myAccountPrivateKey ="d6c8ac5b9e1a1b53fd0ae54d291b50dc5067e294dab13b1d638989b13535bb20";

  Web3Client _client;
  String _abiCode;
  EthereumAddress _contractAddress;
  Credentials _credentials;
  EthereumAddress _ownAddress;
  DeployedContract _contract;
  ContractFunction _siteName;


  Factory(){
    initialSetup();
  }


  Future<void> initialSetup() async {
    _client = Web3Client(_networkUrl, Client());

    await getAbi();
    await getCredentials();
    await getDeployedContract();
  }

  Future<void> getAbi() async {
    String abiStringFile = await rootBundle.loadString("src/abis/Name.json");
    var jsonAbi = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonAbi["abi"]);
    _contractAddress =
        EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
    print(_contractAddress);
  }

  Future<void> getCredentials() async {
    _credentials = await _client.credentialsFromPrivateKey(_myAccountPrivateKey);
    _ownAddress = await _credentials.extractAddress();
  }

  Future<void> getDeployedContract() async {
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode, "Name"), _contractAddress);

    _siteName = _contract.function("Name");
    // print("");
  }

}

