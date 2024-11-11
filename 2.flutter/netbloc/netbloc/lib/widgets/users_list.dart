import 'package:flutter/material.dart';

class UsersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
       itemCount: 10,
        itemBuilder: (context, index) =>
            Container(
       child: ListTile(
             leading: Text('data[index]'),
              title: Column(
                 children: <Widget>[
                   Text("Name"), 
                   Text("Email"), 
                   Text("Phone"),
                 ]
              )
           )
           )
        
    );
  }
  
}