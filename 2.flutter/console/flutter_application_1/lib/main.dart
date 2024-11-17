import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter/services.dart' show rootBundle;
// import 'package:alphabet_search_view/alphabet_search_view.dart';
import 'package:csv/csv.dart';

import 'package:flutter/services.dart';

void main() {
  runApp(const MainApp());
}

class DataItem {
   int id;
  final String name;
  final String title;
  final String subtitle;
  
  DataItem( {required this.id, required this.name, required this.title ,required this.subtitle  });

  // DataItem.fromList(List<String> items) : this(dynamic.parse(items[0]), items[1], items[2]);

  // @override
  // String toString() {
  //   return 'FoodCrop{id: $id, cropType: $name, cropName: $title}';
  }

    void _loadCSV() async {
    final rawData = await rootBundle.loadString("assets/prepods.csv");
    List<List<DataItem>> listItems = const CsvToListConverter().convert(rawData);
    print(listItems);
    }
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
