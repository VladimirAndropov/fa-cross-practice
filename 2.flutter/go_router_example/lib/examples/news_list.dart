import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;// для работы с файл


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
  String selectedCategory = 'My feed';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _fetchData();
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