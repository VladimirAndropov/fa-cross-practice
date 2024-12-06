import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'debounced_search_bar.dart';


void main() {
  runApp(const MyApp());
}

class ITunesItem {
  String wrapperType;
  String kind;
  String trackName;
  String artistName;
  String collectionName;
  String? artworkUrl30;
  String? artworkUrl60;
  String? artworkUrl100;

  ITunesItem({
    required this.wrapperType,
    required this.kind,
    required this.trackName,
    required this.artistName,
    required this.collectionName,
    this.artworkUrl30,
    this.artworkUrl60,
    this.artworkUrl100,
  });

  factory ITunesItem.fromJson(Map<String, dynamic> json) {
    return ITunesItem(
      wrapperType: json['wrapperType'] as String,
      kind: json['kind'] as String,
      trackName: json['trackName'] as String,
      artistName: json['artistName'] as String,
      collectionName: json['collectionName'] as String,
      artworkUrl30: json['artworkUrl30'] as String?,
      artworkUrl60: json['artworkUrl60'] as String?,
      artworkUrl100: json['artworkUrl100'] as String?,
    );
  }
}

Future<Iterable<ITunesItem>> searchITunes(String query) async {
  if (query.isEmpty) {
    return <ITunesItem>[];
  }

  final response = await http.get(
    Uri.parse('https://itunes.apple.com/search?term=$query&media=music&limit=10'),
  );

  try {
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final results = List<Map<String, dynamic>>.from(data['results']);
      return results.map((result) => ITunesItem.fromJson(result)).toList();
    } else {
      throw Exception('Error searching iTunes: ${response.statusCode} ${response.reasonPhrase}');
    }
  } catch (error) {
    print(error);
    return <ITunesItem>[];
  }
}

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
  ITunesItem? _selectedITunesItem;

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
            DebouncedSearchBar<ITunesItem>(
              hintText: 'Search iTunes for music',
              onResultSelected: (ITunesItem result) {
                setState(() {
                  _selectedITunesItem = result;
                });
              },
              resultToString: (ITunesItem result) => result.trackName,
              resultTitleBuilder: (ITunesItem result) => Text(result.trackName),
              resultSubtitleBuilder: (ITunesItem result) => Text(result.artistName),
              resultLeadingBuilder: (ITunesItem result) => result.artworkUrl30 != null
                  ? Image.network(result.artworkUrl30!)
                  : const Icon(Icons.music_note),
              searchFunction: searchITunes,
            ),
            if (_selectedITunesItem != null) ...[
              const SizedBox(height: 16),
              Text(_selectedITunesItem!.trackName, style: Theme.of(context).textTheme.titleLarge),
              Text(_selectedITunesItem!.artistName, style: Theme.of(context).textTheme.titleSmall),
              if (_selectedITunesItem!.artworkUrl100 != null) ...[
                const SizedBox(height: 16),
                Image.network(_selectedITunesItem!.artworkUrl100!),
              ],
            ],
          ],
        ),
      ),
    );
  }
}