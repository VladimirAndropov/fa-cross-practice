import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:nested_router/examples/group_list_body.dart';// для работы с файл


class Category {
  final String id;
  final String label;
  final String description;

  Category({required this.id, required this.label, required this.description});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        id: json['id'] ,
        label: json['label']  ?? '',
        description: json['description'] ?? '');
  }
}

Future<List<Category>> getList() async {
    String jsonString = await rootBundle.loadString('assets/groups.json');
    List<dynamic> parsed = json.decode(jsonString);
    return List<Category>.from(
          parsed.map<Category>((dynamic e) => Category.fromJson(e)));
}



class GroupList extends StatelessWidget {
    final String? thisselectedCategory = '137226';
  const GroupList({super.key, });
  // GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            // key: _scaffoldKey,
            appBar: AppBar(
              title: const Text(
                'Habr',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                  color: Colors.white,
                ),
              ),
            ),
            drawer: const MyDrawer(),
            body: GroupListBody(thisselectedCategory: thisselectedCategory,)));
  }
}

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key, });
  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        width: 200,
        color: const Color.fromARGB(255, 199, 199, 199),
        child: Column(
          children: [
            Container(
              height: 100,
              alignment: Alignment.center,
              child: const Text(
                'Groups',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
                child: FutureBuilder<List<Category>>(
      future: getList(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return
                ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap:      () => context.goNamed("GroupListBody", pathParameters: {'thisselectedCategory': snapshot.data![index].id.toString()}),
                    child: ListTile(//
                      title: Text(snapshot.data![index].label),
                    ));
              },
            );
            } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        // By default show a loading spinner.
        return const CircularProgressIndicator();
  }
  ),
  )
          ],
        ),
      ),
    );
  }
}

