import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
        home: Center(
      child: (Text(
        "data",
        textDirection: TextDirection.ltr,
        maxLines: 14,
        selectionColor: Color.fromARGB(0, 50, 148, 136),
      )),
    )),
  );
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
