import 'package:flutter/material.dart';

import 'package:netbloc/widgets/users_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/user_bloc.dart';
import '../services/users_repository.dart';
import 'package:alphabet_list_view/alphabet_list_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: HomePage(),
    );
  }
}


class HomePage extends StatelessWidget {
  final usersRepository = UsersRepository();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
        create: (context) => UserBloc(usersRepository),
        
        child: Scaffold(
          appBar: AppBar(
            // TRY THIS: Try changing the color here to a specific color (to
            // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
            // change color while the other colors stay the same.
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text('netBloc'),
            centerTitle: true,
          ),
          body: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[ActionButtons(), Expanded(child: UsersList())],
            ),
          ),
          
        ));
  }
}


class ActionButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserBloc userBloc = BlocProvider.of<UserBloc>(context);
    // TODO: implement build
     return Row(
       children: <Widget>[
        MaterialButton(
          onPressed: (){
            userBloc.add(LoadUserEvent());
          }, 
          child: Text("load"),
          color: Colors.red,
          ),

        MaterialButton(
          onPressed: (){
            userBloc.add(ClearUserEvent());
          }, 
          child: Text("clear"),
          color: Colors.green,
          ),
           
              ],
           );
   }
  }
