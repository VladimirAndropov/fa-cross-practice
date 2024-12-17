import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repo/main.dart';

class Counter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('Counter');

    return context.watch<Counts>().count == '' ? 
    Text(context.watch<Counts>().count) :
    Text(context.watch<Counts>().count);
  }
}