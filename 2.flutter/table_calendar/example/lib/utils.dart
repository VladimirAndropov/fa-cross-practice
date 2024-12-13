// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';
import 'dart:convert';

import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;

/// Example event class.
/// Example event class.
class Event {
  final String title;
  // final String id;
  // final String label;
  // final String description;

   Event(
      {
        required this.title,
      // required this.id,
      // required this.description,
      // required this.label
      });

  @override
  String toString() => title;
 
   factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
        // id: json['id'],
        // label: (json['label'] as String?) ?? '',
        // description: (json['description'] as String?) ?? '', 
        title: (json['title'] as String?) ?? '');
  }
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      // 'label': label,
      // 'description': description,
      // 'eventDate': eventDate,
      // 'eventDescription': eventDescription,
      // 'agentId': agentId,
      // 'agencyId': agencyId,
    };
}
}

// LinkedHashMap<DateTime, List<AppEvent>>? _groupedEvents;
class AppEvent {
  late String id;
  late String userId;
  late String title;
  late String description;
  late DateTime startDate;
}

//this is the code am trying to use, and its not running nor giving an error

Map<DateTime, List<Event>> _kEventSource = {};
Future<List<Event>> mike() async {
  String url ='';
  final response = await http.get(Uri.parse(url));
    // print(response.body);
  if(response.statusCode == 200){
    
    // print("response is 200");
    final List<dynamic> jsonResponse = json.decode(response.body);
    List jsonData = List<Event>.from(
          jsonResponse.map<Event>((dynamic e) => Event.fromJson(e))).toList(); 

    // print(jsonData);

    jsonData.forEach((element) {
      // print(element.date.substring(8,10));
    int year = int.parse(element.date.substring(0,4));
    int month = int.parse(element.date.substring(5,7));
    int day = int.parse(element.date.substring(8,10));
    _kEventSource[DateTime(
        year,
        month,
        day,
      )] = _kEventSource[DateTime(
                year,
                month,
                day,
              )] != null
          ? [
              ...?_kEventSource[DateTime(
                year,
                month,
                day,
              )],
              Event(element.title),
            ]
          : [Event(element.title)];
  });
    return welcomeFromMap(response.body).toList();
  } else {
    throw Exception('Failed to load data');
  }
}

/// Example events.
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
  // actual code 
)..addAll(_kEventSource);

// the actual code that comes with the package, this code generates events which will 
//be displayed on the calender, i have commented it so that i can use my own code the 
//above code


//   final _kEventSource = Map.fromIterable(List.generate(365, (index) => index),
//     key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item+1),
//     value: (item) => List.generate(
//         1, (index) => Event('Muharram')))
//   ..addAll({
//     kToday: [
//       Event('Event 1'),
//       Event('Muharram 4th'),
//     ],
//   });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  // print(dayCount);
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(2022);
final kLastDay = DateTime(2062);