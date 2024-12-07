import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import '../debounced_search_bar.dart';


void main() {
  runApp(const MyApp());
}

class Prepods {
    String id;
    String label;
    String description;

  Prepods({
    required this.id, 
  required this.label, 
  required this.description
  });

  factory Prepods.fromJson(Map<String, dynamic> json) {
    return Prepods(
        id: (json['id'] as String?) ?? '',
        label: (json['label'] as String?) ?? '',
        description: (json['description'] as String?) ?? ''
        );
  }
}

Future<Iterable<Prepods>> search(String query) async {
  if (query.isEmpty) {
    return <Prepods>[];
  }

  final response = await http.get(
    Uri.parse('https://ruz.fa.ru/api/search?type=person&term=$query'),
  );
  try {
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      // final results = List<Map<String, dynamic>>.from(data['results']);
      // print(results);
      var temp = List<Prepods>.from(data.map<Prepods>((dynamic e) => Prepods.fromJson(e)));
      // var temp = results.map((result) => Prepods.fromJson(result)).toList();
      print(temp);
      return temp;
    } else {
      throw Exception('Error searching prepods: ${response.statusCode} ${response.reasonPhrase}');
    }
  } catch (error) {
    print(error);
    return <Prepods>[];
  }
}


// Future<Iterable<Prepods>> search(String query) async {
//   if (query.isEmpty) {
//     print('empty');
//     return <Prepods>[];
//   }

//   String response = await rootBundle.loadString('assets/prepods.json');

//   try {
//     if (response != '') {
//       final List<dynamic> data = jsonDecode(response);
//       // final results = List<Map<String, dynamic>>.from(data['results']);
//       // print(results);
//       var temp = List<Prepods>.from(data.map<Prepods>((dynamic e) => Prepods.fromJson(e)));
//       // var temp = results.map((result) => Prepods.fromJson(result)).toList();
//       print('temp = $temp');
//       return temp;
//     } else {
//       throw Exception('Error searching prepods: ${response}');
//     }
//   } catch (error) {
//     print('error $error');
//     return <Prepods>[];
//   }
// }


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Debounced Search Bar',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Debounced Search Bar'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Prepods? _selectedITunesItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DebouncedSearchBar<Prepods>(
              hintText: 'Наберите русскими буквами фамилию преподавателя',
              onResultSelected: (Prepods result) {
                setState(() {
                  _selectedITunesItem = result;
                });
              },
              resultToString: (Prepods result) => result.label,
              resultTitleBuilder: (Prepods result) => Text(result.label),
              // resultSubtitleBuilder: (Prepods result) => Text(result.description),
              // resultLeadingBuilder: (Prepods result) => Text(result.id),
              searchFunction: search,
            ),
            if (_selectedITunesItem != null) ...[
              const SizedBox(height: 16),
              Text(_selectedITunesItem!.id, style: Theme.of(context).textTheme.titleSmall),
              Text(_selectedITunesItem!.label, style: Theme.of(context).textTheme.titleLarge),
              Text(_selectedITunesItem!.description, style: Theme.of(context).textTheme.titleLarge),
            ],
          ],
        ),
      ),
    );
  }
}