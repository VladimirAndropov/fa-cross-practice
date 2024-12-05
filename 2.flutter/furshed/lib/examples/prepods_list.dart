import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart' show rootBundle;


class DataItem {
  final String id;
  final String label;
  final String description;

  DataItem({required this.id, required this.label, required this.description});

  factory DataItem.fromJson(Map<String, dynamic> json) {
    return DataItem(
        id: json['id'],
        label: (json['label'] as String?) ?? '',
        description: (json['description'] as String?) ?? '');
  }
}




class PrepodsList extends StatelessWidget {

  const PrepodsList({super.key, });
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            // key: _scaffoldKey,
            appBar: AppBar(
              title: const Text(
                'Преподаватели',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                  color: Colors.white,
                ),
              ),
            ),
            body: const PrepodsListBody()));
  }
}

class PrepodsListBody extends StatefulWidget {
  const PrepodsListBody({super.key});
  @override
  State<PrepodsListBody> createState() => _PrepodsListBodyState();
}

class _PrepodsListBodyState extends State<PrepodsListBody> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DataItem>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
      onTap: 
          () => context.goNamed("ShedulingCalendar", pathParameters: {'id': snapshot.data![index].id}),
      child: Card(
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
                          snapshot.data![index].label,
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
                                    snapshot.data![index].description,
                                    style:
                                        const TextStyle(color: Colors.black87),
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    snapshot.data![index].id,
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
                )
                );
              });
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        // By default show a loading spinner.
        return const CircularProgressIndicator();
        });
  }
  Future<List<DataItem>> fetchData() async {
    String jsonString = await rootBundle.loadString('assets/prepods.json');
    List<dynamic> parsed = json.decode(jsonString);

    return List<DataItem>.from(
        parsed.map<DataItem>((dynamic e) => DataItem.fromJson(e)));
  }
  
}

  
