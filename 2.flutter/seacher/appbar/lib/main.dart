import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Prepods {
  String id;
  String label;
  String description;

  Prepods({required this.id, required this.label, required this.description});

  factory Prepods.fromJson(Map<String, dynamic> json) {
    return Prepods(
        id: (json['id'] as String?) ?? '',
        label: (json['label'] as String?) ?? '',
        description: (json['description'] as String?) ?? '');
  }

  factory Prepods.fromMap(Map<String, dynamic> map) {
    return Prepods(
      id: map['id'] as String,
      label: map['label'] as String,
      description: map['description'] as String,
    );
  }

  static Future<Iterable<Prepods>> search(String query) async {
    if (query.isEmpty) {
      return <Prepods>[];
    }
    final response =
        await Dio().get('https://ruz.fa.ru/api/search?type=person&term=$query');

    try {
      if (response.statusCode == 200) {
        final List<dynamic> data = List<dynamic>.from(response.data);
        return List<Prepods>.from(
            data.map<Prepods>((dynamic e) => Prepods.fromJson(e)));
      } else {
        throw Exception('Error searching prepods: ${response.statusCode} ');
      }
    } catch (error) {
      return <Prepods>[];
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Search Bar Example',
        theme: ThemeData(
          textTheme: const TextTheme(
            bodyMedium: TextStyle(color: Colors.white),
          ),
        ),
        home: const MyHomePage(),
      );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Prepods? _selectedIItem;
  String? _searchingWithQuery;
  String? selectedresult;
  bool _isLoading = false;
  late Iterable<Widget> _lastresults = <Widget>[];

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurple, Colors.purple.shade300],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: SearchAnchor(
            builder: (BuildContext context, SearchController controller) {
              return SearchBar(
                controller: controller,
                padding: const MaterialStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 16.0)),
                onTap: () {
                  controller.openView();
                },
                leading: const Icon(Icons.search),
                hintText: 'Наберите русскими буквами фамилию преподавателя',
              );
            },
            suggestionsBuilder:
                (BuildContext context, SearchController controller) async {
              _searchingWithQuery = controller.text;
              final results =
                  (await Prepods.search(_searchingWithQuery!)).toList();
              if (_searchingWithQuery != controller.text) {
                return <Widget>[]; //Prepods item = results[index];
              }

              _lastresults =
                  List<ListTile>.generate(results.length, (int index) {
                return ListTile(
                  title: Text(results[index].label),
                  onTap: () {
                    setState(() {
                      _isLoading = false;
                      _selectedIItem = results[index];
                    });
                    controller.closeView(selectedresult);
                  },
                );
              });

              return _lastresults;
            },
          ),
        ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(color: Colors.white),
              )
            : ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) => ListTile(
                  title: Text(
                    _selectedIItem!.label,
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    _selectedIItem!.description,
                    style: const TextStyle(color: Colors.white),
                  ),
                  leading: Text(
                    _selectedIItem!.id,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
        backgroundColor: Colors.deepPurple.shade900,
      );
}
