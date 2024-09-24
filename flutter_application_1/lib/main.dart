import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Center(
      child: Text(
        "Hello world!",
        style: TextStyle(
          color: Colors.red, 
          decoration: TextDecoration.none,
        ),
      ),
    ),
  ));
}

// class MainApp extends StatelessWidget {
//   const MainApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: Text('Hello World!'),
//         ),
//       ),
//     );
//   }
// }
