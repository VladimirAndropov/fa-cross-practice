import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netbloc/bloc/user_bloc.dart';

class UsersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<UserBloc,UserState>(
      builder: (context, state) {
        if(state is Loaded){
          return  ListView.builder(
                  itemCount: state.loadedusers.length,
                    itemBuilder: (context, index) =>
                        Container(
                            child: ListTile(
                                  leading: Text(state.loadedusers[index].id),
                                    title: Row(
                                      children: <Widget>[
                                        Text(state.loadedusers[index].label), 
                                        Text(state.loadedusers[index].description), 
                                        Text(state.loadedusers[index].type),
                                      ]
                                    )
                                )
                                )                                
                );
      }
    if(state is Loading){}  
  //  throw UnimplementedError();
   return CircularProgressIndicator(
     backgroundColor: Colors.red
   );
  }
  );
  }
}