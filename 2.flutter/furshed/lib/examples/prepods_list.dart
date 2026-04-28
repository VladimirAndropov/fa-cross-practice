import 'package:flutter/material.dart';

import 'package:flutter_switch/flutter_switch.dart';
import 'package:dio/dio.dart';
import 'package:furshed/examples/sheduling_calendar.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'group_list_body.dart';

class Prepods {
  String id;
  String label;
  String description;

  Prepods({required this.id, required this.label, required this.description});

  factory Prepods.fromJson(Map<String, dynamic> json) {
    return Prepods(
        id: (json['id'] as String?) ?? '',
        label: (json['label'] as String?) ?? '',
        description: (json['description'] as String?) ?? '');
  }

  static Future<Iterable<Prepods>> search(String query, bool status) async {
    if (query.trim().isEmpty) {
      return <Prepods>[];
    }
    final uri = Uri.https('ruz.fa.ru', '/api/search',  {'type': status ? 'person' : 'group', 'term': query},);

    // final response = await Dio().get(
        // 'http://localhost:3000/search?type=${status ? "person" : "group"}&term=$query');

    try {
       final response = await Dio().getUri(uri);

      if (response.statusCode == 200 && response.data is List) {
         List<dynamic>data = List<dynamic>.from(response.data);
        return List<Prepods>.from(
            data.map<Prepods>((dynamic e) => Prepods.fromJson(Map<String, dynamic>.from(e))));
      } else {
        throw Exception('Error searching prepods: ${response.statusCode} ');
      }
    } catch (error, stackTrace) {
      // Выводим ошибку и стек в консоль для отладки
      print('Search request failed: $error');
      print('StackTrace: $stackTrace');
      return <Prepods>[];
    }
  }
}

class PrepodsList extends StatelessWidget {
  const PrepodsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            // key: _scaffoldKey,
            appBar: AppBar(
              title: const Text(
                'Расписание',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                  color: Colors.black,
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
  Prepods? _selectedIItem;
  String? _searchingWithQuery;
  String? selectedresult;
  bool _isLoading = true;
bool calendar = true;
  bool status = false;
  double start = 0;
  double end = 0;
  late Iterable<Widget> _lastresults = <Widget>[];

  @override
  void initState() {
    super.initState();
        initializeDateFormatting('ru', null);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
floatingActionButton: FloatingActionButton(
        onPressed:   () {
                    setState(() {
                      calendar = !calendar;
                    });},
        tooltip: 'Календарь-Список',
        child: const Icon(Icons.calendar_month_outlined),
      ), 
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.grey.shade400, Colors.green.shade200],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          actions: [
            RangeSlider( 
              divisions: 10,

            values: RangeValues(start, end), 
            labels: RangeLabels(start.round().toString(), end.round().toString()), 
            onChanged: (value) { 
              setState(() { 
                start = value.start; 
                end = value.end; 
              }); 
            }, 
            min: -14, 
            max: 14, 
          ), 

            FlutterSwitch(
              activeText: "Лектор",
              inactiveText: "Группа",
              inactiveColor: Colors.green,
              value: status,
              valueFontSize: 16.0,
              width: 140,
              height: 30,
              borderRadius: 30.0,
              showOnOff: true,
              onToggle: (val) {
                setState(() {
                  status = val;
                });
              },
            ),

          ],
          title: SearchAnchor(
            builder: (BuildContext context, SearchController controller) {
              return SearchBar(
                trailing: [
                  IconButton(
                    icon: const Icon(Icons.keyboard_voice),
                    onPressed: () {
                      print('Use voice command');
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.camera_alt),
                    onPressed: () {
                      print('Use image search');
                    },
                  ),
                ],
                side: WidgetStateProperty.all(
                    const BorderSide(color: Colors.black)),
                overlayColor: WidgetStateProperty.all(Colors.grey.shade100),
                controller: controller,
                padding: const WidgetStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 16.0)),
                onTap: () {
                  controller.openView();
                },
                leading: const Icon(Icons.search),
                hintText: status
                    ? 'Наберите русскими буквами фамилию преподавателя'
                    : 'Наберите русскими буквами название группы',
              );
            },
            suggestionsBuilder:
                (BuildContext context, SearchController controller) async {
              _searchingWithQuery = controller.text;
              final results =
                  (await Prepods.search(_searchingWithQuery!, status)).toList();
              if (_searchingWithQuery != controller.text) {
                return <Widget>[]; //Prepods item = results[index];
              }

              _lastresults =
                  List<ListTile>.generate(results.length, (int index) {
                return ListTile(
                  title: Text(results[index].label),
                  onTap: () {
                    setState(() {
                      _isLoading = false;
                      _selectedIItem = results[index];
                    });
                    controller.closeView(selectedresult);
                    controller.text = results[index].label;
                  },
                  //  () => context.goNamed("ShedulingCalendar", pathParameters: {'id': results[index].id.toString()}),
                );
              });

              return _lastresults;
            },
          ),
        ),
        body: _isLoading
            ? const Center(
                child: Icon(
                Icons.swipe_up_outlined,
                color: Colors.black87,
                size: 80,
              ))
            : calendar ?
            GroupListBody(
                thisselectedCategory: _selectedIItem!.id,
                thisselectedstatus: status,
                thisdatastart: start,
                thisdataend: end
)
                : 
                // Text(_selectedIItem!.id,),
                ShedulingCalendar(
                  id: _selectedIItem!.id,
                ),
        backgroundColor: Colors.green.shade100,
      );
}
