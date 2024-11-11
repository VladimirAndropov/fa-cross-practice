import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
     return Row(
       children: <Widget>[
        MaterialButton(
          onPressed: (){}, 
          child: Text("Button 1"),
          color: Colors.red,
          ),

        MaterialButton(
          onPressed: (){}, 
          child: Text("Button 2"),
          color: Colors.green,
          ),
           
              ],
           );
   }
  }
