import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hello App'),
        ),
        body: Center(
          child: Text(
            'Hello World',
            style: TextStyle(
              color: Colors.red, // Здесь мы указываем красный цвет
              fontSize: 24, // Можно добавить размер шрифта
            ),
          ),
        ),
      ),
    );
  }
}
