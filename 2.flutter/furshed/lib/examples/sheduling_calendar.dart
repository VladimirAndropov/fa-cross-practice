import 'dart:convert';

import 'package:time_scheduler_table/time_scheduler_table.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;

class ShedulingCalendar extends StatefulWidget {

   String? id;
   ShedulingCalendar({super.key,  this.id });

  
  
  @override
  State<ShedulingCalendar> createState() => _ShedulingCalendarState();
}

class _ShedulingCalendarState extends State<ShedulingCalendar>
    with SingleTickerProviderStateMixin {
  

  List<Event> eventList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getEventList());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          // title, back button, etc. can be added here
          TimeSchedulerTable(
            eventList: eventList,
            cellHeight: 52,
            cellWidth: 64,
            currentColumnTitleIndex: DateTime.now().weekday,
            columnLabels: const [ // You can assign any value to columnLabels. For Example : ['Column 1','Column 2','Column 3', ...]
"Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"
        ],
        rowLabels: const [ // You can assign any value to rowLabels. For Example : ['Row 1','Row 2','Row 3', ...]
         
          '08:30 - 10:00',
          '10:10 - 11:40',
          '11:50 - 13:20',
          '14:00 - 15:30',
          '15:40 - 17:10',
          '17:20 - 18:50',
          '18:55 - 20:25',
          '20:30 - 22:00'
          
        ],
            // column & row labels can be added
            eventAlert: EventAlert(
              addOnPressed: (event) {
                showSnackBar(context, '${event.title} added', event.color!);
              },
              deleteOnPressed: (event) {
                showSnackBar(context, '${event.title} deleted', event.color!);
              },
              updateOnPressed: (event) {
                showSnackBar(context, '${event.title} updated', event.color!);
              },
            ),
          ),
        ],
      ),
    );
  }

  void showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
      showCloseIcon: true,
      closeIconColor: Colors.white,
      backgroundColor: color,
    ));
  }

 Future getEventList() async {
    // eventList.clear();

     var url =
      Uri.parse('https://ruz.fa.ru/api/schedule/person/${widget.id}?start=2024.11.18&finish=2024.11.24');

  // Await the http get response, then decode the json-formatted response.
  var response = await http.get(url);
  if (response.statusCode == 200) {
    final List<dynamic> jsonResponse = json.decode(response.body);
    eventList = List<Event>.from(
          jsonResponse.map<Event>((dynamic e) => Event.fromJson(e))); 

  } else {
    String jsonString = await rootBundle.loadString('assets/andropov.json');
    List<dynamic> jsonResponse = json.decode(jsonString);
    eventList = List<Event>.from(
          jsonResponse.map<Event>((dynamic e) => Event.fromJson(e))); 
  }
    setState(() {
      eventList = eventList;   
      });
  }

}
// это надо добавиь в класс Event 
  //   factory Event.fromJson(Map<String, dynamic> json) { //import 'package:intl/intl.dart';
  //   return Event(
  //       title: (json['lecturer'] as String?) ?? '',
  //       time: (json['kindOfWork'] as String?) ?? '',
  //       columnIndex: DateFormat('y.MM.dd').parse(json['date']).weekday - 1,
  //       rowIndex: (((DateFormat('H:mm').parse(json['beginLesson']).hour)/2.4+(DateFormat('H:mm').parse(json['beginLesson']).minute)/60)*1.6).toInt(),
  //   );
  // }