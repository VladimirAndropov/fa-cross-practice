import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'post.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Main(),
    );
  }
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  List<dynamic> items = [];
  String selectedCategory = 'My feed';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final response = await http.get(
      Uri.parse('https://67190fb57fc4c5ff8f4c4767.mockapi.io/habr'),
    );

    if (response.statusCode == 200) {
      String decodedBody = utf8.decode(response.bodyBytes);
      setState(() {
        items = json.decode(decodedBody);
      });
    } else {
      if (kDebugMode) {
        print('Error downloading data');
      }
    }
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      throw 'Unable to open link: $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> filteredItems = items.where((item) {
      int itemId = int.parse(item['id']);
      if (selectedCategory == 'My feed') return itemId >= 1 && itemId <= 4;
      if (selectedCategory == 'All streams') return true;
      if (selectedCategory == 'Development') return itemId >= 8 && itemId <= 10;
      if (selectedCategory == 'Marketing') return itemId >= 5 && itemId <= 7;
      return item['category'] == selectedCategory;
    }).toList();

    return Scaffold(
      key: _scaffoldKey,
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
        centerTitle: true,
        backgroundColor: const Color(0xFF303B44),
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      drawer: Drawer(
        child: Container(
          width: 200,
          color: const Color(0xFF303B44),
          child: Column(
            children: [
              Container(
                height: 100,
                alignment: Alignment.center,
                child: const Text(
                  'Sections',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.list, color: Color(0xFFD4D4D4)),
                      title: const Text('My feed', style: TextStyle(color: Color(0xFFD4D4D4))),
                      onTap: () {
                        setState(() {
                          selectedCategory = 'My feed';
                        });
                        Navigator.pop(context);
                      },
                    ),
                    const Divider(color: Colors.white),
                    ListTile(
                      leading: const Icon(Icons.article, color: Color(0xFFD4D4D4)),
                      title: const Text('All streams', style: TextStyle(color: Color(0xFFD4D4D4))),
                      onTap: () {
                        setState(() {
                          selectedCategory = 'All streams';
                        });
                        Navigator.pop(context);
                      },
                    ),
                    const Divider(color: Colors.white),
                    ListTile(
                      leading: const Icon(Icons.developer_mode, color: Color(0xFFD4D4D4)),
                      title: const Text('Development', style: TextStyle(color: Color(0xFFD4D4D4))),
                      onTap: () {
                        setState(() {
                          selectedCategory = 'Development';
                        });
                        Navigator.pop(context);
                      },
                    ),
                    const Divider(color: Colors.white),
                    ListTile(
                      leading: const Icon(Icons.business_center, color: Color(0xFFD4D4D4)),
                      title: const Text('Marketing', style: TextStyle(color: Color(0xFFD4D4D4))),
                      onTap: () {
                        setState(() {
                          selectedCategory = 'Marketing';
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                selectedCategory,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  var item = filteredItems[index];
                  return Post(
                    title: item['title'] ?? '',
                    date: item['date'] ?? '',
                    image: item['image'] ?? '',
                    text: item['text'] ?? '',
                    imageUrl: item['image'] ?? '',
                    url: item['url'] ?? '',
                    onImageTap: () {
                      _launchURL(item['url']);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

