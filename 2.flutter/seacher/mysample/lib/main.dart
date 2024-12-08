import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

/// Flutter code sample for [SearchAnchor].

void main() => runApp(const SearchAnchorAsyncExampleApp());

class SearchAnchorAsyncExampleApp extends StatelessWidget {
  const SearchAnchorAsyncExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('SearchAnchor - async'),
        ),
        body: const Center(
          child: _AsyncSearchAnchor(),
        ),
      ),
    );
  }
}

class _AsyncSearchAnchor extends StatefulWidget {
  const _AsyncSearchAnchor();

  @override
  State<_AsyncSearchAnchor> createState() => _AsyncSearchAnchorState();
}

class _AsyncSearchAnchorState extends State<_AsyncSearchAnchor> {
  // The query currently being searched for. If null, there is no pending
  // request.
  String? _searchingWithQuery;

  // The most recent options received from the API.
  late Iterable<Widget> _lastOptions = <Widget>[];

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
        builder: (BuildContext context, SearchController controller) {
      return IconButton(
        icon: const Icon(Icons.search),
        onPressed: () {
          controller.openView();
        },
      );
    }, suggestionsBuilder:
            (BuildContext context, SearchController controller) async {
      _searchingWithQuery = controller.text;
      print('_searchingWithQuery = $_searchingWithQuery');
      final List<Prepods> options =
          (await Prepods.search(_searchingWithQuery!)).toList();
      print('options = $options');
      // If another search happened after this one, throw away these options.
      // Use the previous options instead and wait for the newer request to
      // finish.
      if (_searchingWithQuery != controller.text) {
        return _lastOptions;
      }

      _lastOptions = List<ListTile>.generate(options.length, (int index) {
        final Prepods item = options[index];
        return ListTile(
          title: Text(item.label),
        );
      });

      return _lastOptions;
    });
  }
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

  factory Prepods.fromMap(Map<String, dynamic> map) {
    return Prepods(
      id: map['id'] as String,
      label: map['label'] as String,
      description: map['description'] as String,
    );
  }
 static Future<Iterable<Prepods>>  search(String query) async {
  if (query.isEmpty) {
    return <Prepods>[];
  }
final response = await Dio().get('https://ruz.fa.ru/api/search?type=person&term=$query');
  try {
    if (response.statusCode == 200) {
        final List<dynamic> data = List< dynamic>.from(response.data);
        var temp = List<Prepods>.from(data.map<Prepods>((dynamic e) => Prepods.fromJson(e)));
        return temp;

    } else {
      throw Exception('Error searching prepods: ${response.statusCode} ');
    }
  } catch (error) {
    return <Prepods>[];
  }
}
}