import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Event {
  /// [title] is title of event.
  String? title;

  /// [time] is time of event.
  String? time;

  /// [color] is color of event.
  Color? color;

  /// [columnIndex] indicates in which column index the Event is located.
  int columnIndex;

  /// [rowIndex] indicates in which row index the Event is located.
  int rowIndex;

  Event({
    this.title,
    this.time,
    this.color,
    required this.columnIndex,
    required this.rowIndex,
  });

    factory Event.fromJson(Map<String, dynamic> json) { //import 'package:intl/intl.dart';
    return Event(
        title: (json['lecturer'] as String?) ?? '',
        time: (json['kindOfWork'] as String?) ?? '',
        columnIndex: DateFormat('y.MM.dd').parse(json['date']).weekday - 1,
        rowIndex: (((DateFormat('H:mm').parse(json['beginLesson']).hour)*60+(DateFormat('H:mm').parse(json['beginLesson']).minute))/96).toInt()-5,
        // date: DateFormat('y.MM.dd').parse(json['date'] as String),
        // startTime:DateFormat('y.MM.dd H:mm').parse(json['date'] +' '+ json['beginLesson']),
        // endTime: DateFormat('y.MM.dd H:mm').parse(json['date'] +' '+ json['endLesson']),
    );
  }
}
