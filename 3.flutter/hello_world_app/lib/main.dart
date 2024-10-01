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
          onSurface: Colors.red,
        ),
        useMaterial3: true,
      ),
      home: Builder(
        builder: (context) {
          return Scaffold(
            body: Center(
              child: Text(
                'Hello World!',
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
          );
        }
      ),
    );
  }
}
