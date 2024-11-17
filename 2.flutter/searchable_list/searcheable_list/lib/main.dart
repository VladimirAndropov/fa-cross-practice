
import 'package:flutter/material.dart';
import 'examples/loadmore_listview.dart';


void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Load More and Refresh'),
        ),
        body: LoadMoreListV(),
        floatingActionButton:  
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [ 
                FloatingActionButton(
                onPressed: () {
                  // BlocProvider.of<ColorBloc>(context).add(RedColor());
                },
                tooltip: 'red',
                backgroundColor: Colors.red,
                child:  const Icon(Icons.stop_circle_outlined),
              ),
               FloatingActionButton(
                onPressed: () {
                  // BlocProvider.of<ColorBloc>(context, listen: false).add(GreenColor());
                },
                tooltip: 'green',
                backgroundColor: Colors.green,
                child:  const Icon(Icons.energy_savings_leaf_outlined), ////
                ),          
           ],
            
        )
        )
    );
  }
}