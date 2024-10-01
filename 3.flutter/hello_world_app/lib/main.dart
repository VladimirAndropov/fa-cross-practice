import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          onPrimary: Colors.red,
        ),
        useMaterial3: true,
      ),
      home: Builder(
        builder: (context) => Scaffold(
          body: Center(
            child: Text(
              'Hello World!',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: MediaQuery.of(context).size.width / 7),
            ),
          ),
        ),
      ),
    );
  }
}
