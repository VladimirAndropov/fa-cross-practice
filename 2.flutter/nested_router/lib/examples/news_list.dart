import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;// для работы с файл


class Category {
  final String id;
  final String label;
  final String description;

  Category({required this.id, required this.label, required this.description});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        id: (json['id'] as String?) ?? '',
        label: (json['label'] as String?) ?? '',
        description: (json['description'] as String?) ?? '');
  }
}

class NewsList extends StatelessWidget {
  const NewsList({super.key});

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
  late String thisselectedCategory;
  List<dynamic> selectedCategory = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getList());
    _fetchData();
  }

Future getList() async {
    String jsonString = await rootBundle.loadString('assets/groups.json');
    List<dynamic> parsed = json.decode(jsonString);

// List<Map<String, dynamic>> ppp = parsed.cast<Map<String, dynamic>>();


    setState(() {
      selectedCategory = List<Category>.from(
          parsed.map<Category>((dynamic e) => Category.fromJson(e)));
    });
  }


  @override
  Widget build(BuildContext context) {
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
                  'Groups',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
  itemCount: 10,
  itemBuilder: (BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
               thisselectedCategory =selectedCategory[index].id.toString();
                        });
                        Navigator.pop(context);
      },
      child: ListTile(
      title: Text( selectedCategory[index].label),
    )

    );
  },
)

              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
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
                    onImageTap: () { print('ontap');
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
      Uri.parse('https://ruz.fa.ru/api/schedule/group/$thisselectedCategory?start=2024.11.18&finish=2024.11.24'),
    );

     if (response.statusCode == 200) {
    final List<dynamic> jsonResponse = json.decode(response.body);
    items = List<Post>.from(
          jsonResponse.map<Post>((dynamic e) => Post.fromJson(e))); 

  } else {
    String jsonString = await rootBundle.loadString('assets/137226.json');
    List<dynamic> jsonResponse = json.decode(jsonString);
    items = List<Post>.from(
          jsonResponse.map<Post>((dynamic e) => Post.fromJson(e))); 
  }
    setState(() {
      items = items;   
      });
  }
}

  
class Post extends StatelessWidget {
  final String title;
  final String date;
  final String image;
  final String text;
  final String imageUrl;
  final String url;
  final VoidCallback? onImageTap;

  const Post({super.key,
    required this.title,
    required this.date,
    required this.image,
    required this.text,
    required this.imageUrl,
    required this.url,
     this.onImageTap,
  });

   factory Post.fromJson(Map<String, dynamic> json) { 
      return Post(
        title: (json['discipline'] as String?) ?? '',
        text: (json['kindOfWork'] as String?) ?? '',
        image: (json['lecturer'] as String?) ?? '',
        imageUrl: (json['parentschedule'] as String?) ?? '',
        url: (json['author'] as String?) ?? '',
        date: (json['beginLesson'] as String?) ?? '',
        // date: DateFormat('y.MM.dd').parse(json['date']) as String,// Переваем в строку
        // onImageTap: (((DateFormat('H:mm').parse(json['beginLesson']).hour)/2.4+(DateFormat('H:mm').parse(json['beginLesson']).minute)/60)*1.6).toString,
    );
  }



  @override
  Widget build(BuildContext context) {
    return  Card(
        margin: const EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                maxLines: 3,
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 100, width: 100, child: Icon(Icons.image, size: 50)),  // Заглушка, если нет изображения
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          text,
                          style: const TextStyle(color: Colors.black87),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          date,
                          style: const TextStyle(color: Colors.black54, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
    );
  }
}