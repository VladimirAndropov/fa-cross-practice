import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'color_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => ColorBloc(),
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
        appBar: AppBar(
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('flutter bloc'),
        ),

        body: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: BlocBuilder<ColorBloc, int>(
              builder: (context, currentColor) => AnimatedContainer(
                width: 100,
                height: 100,
                duration: Duration(milliseconds: 500),
                color:  Color(currentColor)

          ),
        )
        ),

        floatingActionButton: 
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [ 
                FloatingActionButton(
                onPressed: () {
                  BlocProvider.of<ColorBloc>(context).add(RedColor());
                },
                tooltip: 'red',
                backgroundColor: Colors.red,
                child:  const Icon(Icons.stop_circle_outlined),
              ),
               FloatingActionButton(
                onPressed: () {
                  BlocProvider.of<ColorBloc>(context, listen: false).add(GreenColor());
                },
                tooltip: 'green',
                backgroundColor: Colors.green,
                child:  const Icon(Icons.energy_savings_leaf_outlined), ////
                ),          
           ],
            
        ));
  }
}
