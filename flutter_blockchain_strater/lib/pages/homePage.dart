import 'package:flutter/material.dart';
import 'package:flutter_blockchain_strater/helpers/factory.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var siteNameFactory = Provider.of<FactoryContract>(context);
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text("Arabic Dapps"),
      ),
      body: Container(
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("images/ardapps.png",scale: .8,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:siteNameFactory.isLoading? CircularProgressIndicator(color: Colors.red,):Text("Welcome From arDapps.com  the name from the contract is " + siteNameFactory.siteNameDeplyed ,style:TextStyle(fontSize: 20),)
                ),
              ],
            )),
      ),
    );
  }
}
