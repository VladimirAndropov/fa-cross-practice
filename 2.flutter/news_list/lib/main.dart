
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'post.dart';
import 'package:flutter/services.dart' show rootBundle;// для работы с файл

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
  State<Main> createState() => _MainState();
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



  @override
  Widget build(BuildContext context) {
    // List<dynamic> filteredItems = items.where((item) {
    //   int itemId = int.parse(item['id']);
    //   if (selectedCategory == 'My feed') return itemId >= 1 && itemId <= 4;
    //   if (selectedCategory == 'All streams') return true;
    //   if (selectedCategory == 'Development') return itemId >= 8 && itemId <= 10;
    //   if (selectedCategory == 'Marketing') return itemId >= 5 && itemId <= 7;
    //   return item['category'] == selectedCategory;
    // }).toList();

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
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Post(
                    title: items[index].title ,
                    date: items[index].date ?? '',
                    image: items[index].image ?? '',
                    text: items[index].text ?? '',
                    imageUrl: items[index].image ?? '',
                    url: items[index].url ?? '',
                    onImageTap: () {
                      _launchURL(items[index].url);
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

    Future<void> _fetchData() async {
    final response = await http.get(
      Uri.parse('https://ruz.fa.ru/api/schedule/group/137269?start=2024.11.18&finish=2024.11.24'),
    );

     if (response.statusCode == 200) {
    final List<dynamic> jsonResponse = json.decode(response.body);
    items = List<Post>.from(
          jsonResponse.map<Post>((dynamic e) => Post.fromJson(e))); 

  } else {
    String jsonString = await rootBundle.loadString('assets/andropov.json');
    List<dynamic> jsonResponse = json.decode(jsonString);
    items = List<Post>.from(
          jsonResponse.map<Post>((dynamic e) => Post.fromJson(e))); 
  }
    setState(() {
      items = items;   
      });
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      throw 'Unable to open link: $url';
    }
  }
}

