import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repo/examples/buttons.dart';
import 'package:repo/examples/counter.dart';

class Counts with ChangeNotifier {
  String _count = 'false';
  String get count => _count;

  void add(name) {
    _count = name;
    notifyListeners();
  }

  void remove() {
    _count= 'false';
    notifyListeners();
  }
}




void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Counts()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Provider'),
      ),
      body: ChangeNotifierProvider(
        create: (BuildContext context) => Counts(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Counter(),
              Buttons(),
              
            ],
          ),
        ),
      ),
    );
  }
}