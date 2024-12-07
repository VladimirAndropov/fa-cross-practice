import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'debounced_search_bar.dart';
import 'group_list_body.dart';
import 'sheduling_calendar.dart';


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
   Prepods? _selectedITunesItem;

  @override
  Widget build(BuildContext context) {
    return  Column(
          children: [
            DebouncedSearchBar<Prepods>(
              hintText: 'Наберите русскими буквами фамилию преподавателя',
              onResultSelected:
              
               (Prepods result) {
                setState(() {
                  _selectedITunesItem = result;
                });
              },
              resultToString: (Prepods result) => result.label,
              resultTitleBuilder: (Prepods result) => Text(result.label),
              // resultSubtitleBuilder: (Prepods result) => Text(result.description),
              // resultLeadingBuilder: (Prepods result) => Text(result.id),
              searchFunction: search,
          
            ),
            if (_selectedITunesItem != null) ...[
              const SizedBox(height: 16),
              Text(_selectedITunesItem!.label, style: Theme.of(context).textTheme.titleSmall),
              // ShedulingCalendar(id: _selectedITunesItem!.id),
              // GroupListBody(thisselectedCategory: _selectedITunesItem!.id)
            ],
            GroupListBody(thisselectedCategory: "144421")
          ],
        );
  }


  // Widget build(BuildContext context) {
  //   return FutureBuilder<List<DataItem>>(
  //       future: fetchData(),
  //       builder: (context, snapshot) {
  //         if (snapshot.hasData) {
  //         return ListView.builder(
  //             itemCount: snapshot.data!.length,
  //             itemBuilder: (context, index) {
  //               return GestureDetector(
  //     onTap: 
  //         () => context.goNamed("ShedulingCalendar", pathParameters: {'id': snapshot.data![index].id}),
  //     child: Card(
  //                 margin: const EdgeInsets.symmetric(vertical: 10),
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(12),
  //                 ),
  //                 elevation: 4,
  //                 child: Padding(
  //                   padding: const EdgeInsets.all(15.0),
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text(
  //                         snapshot.data![index].label,
  //                         style: const TextStyle(
  //                             fontSize: 16, fontWeight: FontWeight.bold),
  //                         overflow: TextOverflow.ellipsis,
  //                         softWrap: true,
  //                         maxLines: 3,
  //                       ),
  //                       const SizedBox(height: 8),
  //                       Row(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           const SizedBox(
  //                               height: 100,
  //                               width: 100,
  //                               child: Icon(Icons.image,
  //                                   size:
  //                                       50)), // Заглушка, если нет изображения
  //                           const SizedBox(width: 16),
  //                           Expanded(
  //                             child: Column(
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               children: [
  //                                 Text(
  //                                   snapshot.data![index].description,
  //                                   style:
  //                                       const TextStyle(color: Colors.black87),
  //                                   maxLines: 4,
  //                                   overflow: TextOverflow.ellipsis,
  //                                 ),
  //                                 const SizedBox(height: 8),
  //                                 Text(
  //                                   snapshot.data![index].id,
  //                                   style: const TextStyle(
  //                                       color: Colors.black54, fontSize: 12),
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               )
  //               );
  //             });
  //       } else if (snapshot.hasError) {
  //         return Text(snapshot.error.toString());
  //       }
  //       // By default show a loading spinner.
  //       return const CircularProgressIndicator();
  //       });
  }
Future<Iterable<Prepods>> search(String query) async {
  if (query.isEmpty) {
    return <Prepods>[];
  }

  final response = await http.get(
    Uri.parse('https://ruz.fa.ru/api/search?type=group&term=$query'),
  );
  try {
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      // final results = List<Map<String, dynamic>>.from(data['results']);
      // print(results);
      var temp = List<Prepods>.from(data.map<Prepods>((dynamic e) => Prepods.fromJson(e)));
      // var temp = results.map((result) => Prepods.fromJson(result)).toList();
      print(temp);
      return temp;
    } else {
      throw Exception('Error searching prepods: ${response.statusCode} ${response.reasonPhrase}');
    }
  } catch (error) {
    print(error);
    return <Prepods>[];
  }
  
}

  
