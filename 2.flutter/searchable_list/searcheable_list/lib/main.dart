import 'package:flutter/material.dart';
import 'package:searcheable_list/examples/loadmore_listview.dart';
import 'package:provider/provider.dart';



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
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:  LoadMoreListV(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              context.read<Counts>().setcounter('');
            },
            tooltip: 'true',
            child: const Icon(Icons.people),
          ),
          FloatingActionButton(
            onPressed: () {
              context.read<Counts>().setcounter('2');
            },
            tooltip: 'false',
            child: const Icon(Icons.calendar_month_outlined),
          ),
        ],
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
