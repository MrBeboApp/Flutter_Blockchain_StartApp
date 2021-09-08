import 'package:flutter/material.dart';
import 'package:flutter_blockchain_strater/helpers/factory.dart';
import 'package:flutter_blockchain_strater/pages/homePage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FactoryContract>(create: (context)=>FactoryContract(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Arabic Dapps',
      theme: ThemeData(

        primarySwatch: Colors.teal,
      ),
      home: HomePage(),
    ));
  }
}