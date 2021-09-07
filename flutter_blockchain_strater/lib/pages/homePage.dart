import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage() : super();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
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
                child: Text("Welcome From arDapps.com",style:TextStyle(fontSize: 20),),
              ),
            ],
          )),
      ),
    );
  }
}
