
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;// для работы с файл


class Post {
  final int id;
  final String discipline;
  final String kindOfWork;
  final String lecturer;
  final String auditorium;
  final String building;
  final String group;
  final String beginLesson;
  final String endLesson;
  // final VoidCallback? onImageTap;

  const Post({
    required this.id,
    required this.discipline,
    required this.kindOfWork,
    required this.lecturer,
    required this.auditorium,
    required this.building,
    required this.group,
    required this.beginLesson,
    required this.endLesson,
    //  this.onImageTap,
  });

   factory Post.fromJson(Map<String, dynamic> json) { 
      return Post( 
      id: json['lessonOid'],
        discipline: json['discipline'],
        kindOfWork: json['kindOfWork']  ?? '',
        lecturer: json['lecturer']  ?? '',
        auditorium: json['auditorium']  ?? '',
        building: json['building'] ?? '',
        group: json['group']  ?? '',
        beginLesson: json['beginLesson'] ?? '',
        endLesson: json['endLesson']  ?? '',
        // date: DateFormat('y.MM.dd').parse(json['date']) as String,// Переваем в строку
        // onImageTap: (((DateFormat('H:mm').parse(json['beginLesson']).hour)/2.4+(DateFormat('H:mm').parse(json['beginLesson']).minute)/60)*1.6).toString,
    );
  }
}

class GroupListBody extends StatefulWidget {
  final String? thisselectedCategory;
  const GroupListBody({super.key, required this.thisselectedCategory});
  @override
  State<GroupListBody> createState() => _GroupListBodyState();
}

class _GroupListBodyState extends State<GroupListBody> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Post>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Card(
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
                          snapshot.data![index].discipline,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          maxLines: 3,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                                height: 100,
                                width: 100,
                                child: Icon(Icons.image,
                                    size:
                                        50)), // Заглушка, если нет изображения
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data![index].kindOfWork,
                                    style:
                                        const TextStyle(color: Colors.black87),
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '${snapshot.data![index].auditorium}(${snapshot.data![index].building})',
                                    style:
                                        const TextStyle(color: Colors.black87),
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '${snapshot.data![index].beginLesson} - ${snapshot.data![index].endLesson}',
                                    style:
                                        const TextStyle(color: Colors.black87),
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    snapshot.data![index].group,
                                    style: const TextStyle(
                                        color: Colors.black54, fontSize: 12),
                                  ),
                                  Text(
                                    snapshot.data![index].lecturer,
                                    style: const TextStyle(
                                        color: Colors.black54, fontSize: 12),
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
              });
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        // By default show a loading spinner.
        return const CircularProgressIndicator();
        });
  }
  Future<List<Post>> fetchData() async {
    final response = await http.get(
      Uri.parse(
          'https://ruz.fa.ru/api/schedule/group/${widget.thisselectedCategory}?start=2024.11.23&finish=2024.11.24'),
    );
    if (response.statusCode == 200) {
      final List jsonResponse = json.decode(response.body);
      return List<Post>.from(
          jsonResponse.map<Post>((dynamic e) => Post.fromJson(e)));
    } else {
      String jsonString = await rootBundle.loadString('assets/137226.json');
      List jsonResponse = json.decode(jsonString);
      return List<Post>.from(
          jsonResponse.map<Post>((dynamic e) => Post.fromJson(e)));
    }
  }
}

  
