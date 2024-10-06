import 'package:flutter/material.dart';

void main() {
  runApp(
    Directionality(
      textDirection: TextDirection.ltr,
      child: Center(
        child: Text(
          'HELLO WORLD',
          style: TextStyle(color: Colors.red),
        ),
      ),
    ),
  );
}
