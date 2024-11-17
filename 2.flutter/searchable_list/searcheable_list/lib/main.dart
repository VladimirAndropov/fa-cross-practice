
import 'package:flutter/material.dart';

import 'package:searcheable_list/examples/sheduling_calendar.dart';

import 'package:searcheable_list/examples/loadmore_listview.dart';


void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FloatingButtons(title: 'Flutter Demo Home Page'),
    );
  }
}

class FloatingButtons extends StatefulWidget {
  const FloatingButtons({super.key, required this.title});

  final String title;

  @override
  State<FloatingButtons> createState() => _MyFloatingButtonsState();
}


class _MyFloatingButtonsState extends State<FloatingButtons> {
  bool _widget = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Load More and Refresh'),
        ),
        body: _widget ? LoadMoreListV(): ShedulingCalendar(),
        floatingActionButton:  
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
        children: [
           FloatingActionButton(
        onPressed: (){setState(() => _widget = true);},
        tooltip: 'true',
        child: const Icon(Icons.people),
      ), 
      FloatingActionButton(
        onPressed: (){setState(() => _widget = false);},
        tooltip: 'false',
        child: const Icon(Icons.calendar_month_outlined),
      ), 
        ],
     // This trailing comma makes auto-formatting nicer for build methods.
    ),
    );
  }
}
