
import 'package:flutter/material.dart';
import 'package:dio/dio.dart'; // для работы с файл
import 'package:intl/intl.dart';

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
  final String date;
  // final VoidCallback? onImageTap;

  Post({
    required this.id,
    required this.discipline,
    required this.kindOfWork,
    required this.lecturer,
    required this.auditorium,
    required this.building,
    required this.group,
    required this.beginLesson,
    required this.endLesson,
    required this.date,
    //  this.onImageTap,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['lessonOid'],
      discipline: json['discipline'],
      kindOfWork: json['kindOfWork'] ?? '',
      lecturer: json['lecturer'] ?? '',
      auditorium: json['auditorium'] ?? '',
      building: json['building'] ?? '',
      group: json['group'] ?? '',
      beginLesson: json['beginLesson'] ?? '',
      endLesson: json['endLesson'] ?? '',
      // date: DateFormat.yMMMMEEEEd().format(json['date']),
      date: DateFormat.yMMMMEEEEd('ru').format(DateFormat('y.MM.dd').parse(json['date'])) ,
      // onImageTap: (((DateFormat('H:mm').parse(json['beginLesson']).hour)/2.4+(DateFormat('H:mm').parse(json['beginLesson']).minute)/60)*1.6).toString,
    );
  }

  factory Post.fromJsonPrepods(Map<String, dynamic> json) {
    return Post(
      id: json['lecturerOid'],
      discipline: (json['discipline']) as String,
      kindOfWork: (json['kindOfWork']) as String,
      lecturer: (json['lecturer']) as String,
      auditorium: (json['auditorium']) as String,
      building: (json['building']) as String,
      group: (json['group']) as String,
      beginLesson: (json['beginLesson']) as String,
      endLesson: (json['endLesson']) as String,
      date: DateFormat.yMMMMEEEEd('ru').format(DateFormat('y.MM.dd').parse(json['date'])) ,
      // onImageTap: (((DateFormat('H:mm').parse(json['beginLesson']).hour)/2.4+(DateFormat('H:mm').parse(json['beginLesson']).minute)/60)*1.6).toString,
    );
  }

  static Future<List<Post>> fetchData(
      String query, bool status, double datastart, double dataend) async {
    String type;
    status ? type = "person" : type = "group";
    String formattedDateBefor = DateFormat('yyyy.MM.dd')
        .format(DateTime.now().add(Duration(days: datastart.ceil())));
    String formattedDateAfter = DateFormat('yyyy.MM.dd')
        .format(DateTime.now().add(Duration(days: dataend.ceil())));
    final response = await Dio().get(
        'https://ruz.fa.ru/api/schedule/$type/$query?start=$formattedDateBefor&finish=$formattedDateAfter'); //'https://ruz.fa.ru/api/schedule/group/${query}?start=$formattedDateNow&finish=$formattedDateNow'
    if (response.statusCode == 200) {
      final List data = List<dynamic>.from(response.data);
      return status
          ? List<Post>.from(
              data.map<Post>((dynamic e) => Post.fromJsonPrepods(e)))
          : List<Post>.from(data.map<Post>((dynamic e) => Post.fromJson(e)));
    } else {
      throw Exception('Error searching prepods: ${response.statusCode} ');
    }
  }
}

class GroupListBody extends StatefulWidget {
  final String thisselectedCategory;
  final bool thisselectedstatus;
  final double thisdataend;
  final double thisdatastart;

  const GroupListBody(
      {super.key,
      required this.thisselectedCategory,
      required this.thisselectedstatus,
      required this.thisdatastart,
      required this.thisdataend});

  @override
  State<GroupListBody> createState() => _GroupListBodyState();
}


class _GroupListBodyState extends State<GroupListBody> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Post>>(
        future: Post.fetchData(
            widget.thisselectedCategory,
            widget.thisselectedstatus,
            widget.thisdatastart,
            widget.thisdataend),
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
                              Column(children: [
                                const SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: Icon(Icons.image,
                                        size:
                                            50)), // Заглушка, если нет изображения
                                Text(
                                  snapshot.data![index].date,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ]),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data![index].kindOfWork,
                                      style: const TextStyle(
                                          color: Colors.black87),
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      '${snapshot.data![index].auditorium}(${snapshot.data![index].building})',
                                      style: const TextStyle(
                                          color: Colors.black87),
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      '${snapshot.data![index].beginLesson} - ${snapshot.data![index].endLesson}',
                                      style: const TextStyle(
                                          color: Colors.black87),
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
}
