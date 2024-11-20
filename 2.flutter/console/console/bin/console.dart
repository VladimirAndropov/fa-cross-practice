import 'package:console/console.dart' as console;

// import 'dart:math';
import 'dart:convert';

import 'package:intl/intl.dart';

// import 'package:flutter/services.dart' show rootBundle;


class DataItem {
  final String id;
  final String label;
  final String description;

  DataItem({required this.id, required this.label, required this.description});

  factory DataItem.fromJson(Map<String, dynamic> json) {
    return DataItem(
        id: (json['id'] as String?) ?? '',
        label: (json['label'] as String?) ?? '',
        description: (json['description'] as String?) ?? '');
  }

// factory DataItem.fromJson(Map<String, dynamic> json) =>
//       _$DataItemFromJson(json);
//   Map<String, dynamic> toJson() => _$DataItemToJson(this);

  // method
  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'id': id,
      'description': description,
    };
  }

  @override
  String toString() {
    return id;
  }
}
void main(List<String> arguments) {
  print('Hello world: ${console.calculate()}!');




  bool _hasNextData = true;
  List<String> list = [];
  final _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
 


    list.clear();
    _hasNextData = true;
    final users = [
{"id":"-2", "label":"1", "description":"Кафедра бизнес-информатики", "type":"person"},
{"id":"df1ef977-af94-11ee-9525-005056bf7de8", "label":"Ду Хуэй", "description":"Кафедра иностранных языков и межкультурной коммуникации", "type":"person"},
{"id":"-182", "label":"ИЖК_вак", "description":"Базовая кафедра Ипотечное жилищное кредитование и финансовые инструменты рынка недвижимости", "type":"person"},
{"id":"-194", "label":"КОР_вак", "description":"Кафедра отраслевых рынков", "type":"person"},
{"id":"7e92b5a3-98bb-11ee-86b1-005056bf5929", "label":"Юй Лань", "description":"Кафедра политологии", "type":"person"},
{"id":"-1", "label":"!Вакансия", "description":"!Не определена", "type":"person"},
{"id":"fdfaf62b-04fc-11ee-be7b-005056bf7de8", "label":"Али Бушра", "description":"Кафедра искусственного интеллекта", "type":"person"},
{"id":"da844020-160c-11ec-897b-005056bf7de8", "label":"Ахмад Авс", "description":"Кафедра искусственного интеллекта", "type":"person"},
{"id":"-197", "label":"КСиИР_вак", "description":"Кафедра стратегического и инновационного развития", "type":"person"},
{"id":"a0eedbfe-4639-11ed-a1ba-005056bf7de8", "label":"Муса Ваэл", "description":"Кафедра иностранных языков и межкультурной коммуникации", "type":"person"},
{"id":"7e779035-a066-11ed-af13-005056bf5929", "label":"Чжан Вэнь", "description":"Кафедра иностранных языков и межкультурной коммуникации;Кафедра международного бизнеса", "type":"person"},
{"id":"ae706b12-afb8-11ee-86b1-005056bf5929", "label":"Ким Сучжон", "description":"Кафедра психологии и развития человеческого капитала", "type":"person"},
{"id":"0ca1ad12-2e96-11ed-84d4-005056bf5929", "label":"Цой Гунвон", "description":"Кафедра психологии и развития человеческого капитала", "type":"person"},{"id":"e766e2cf-80a6-11ef-b003-005056bf7de8", "label":"Крепак Иван", "description":"Кафедра информационной безопасности", "type":"person"},{"id":"3f166068-9bac-11ed-af13-005056bf5929", "label":"Раджуб Гинд", "description":"Кафедра английского языка и профессиональной коммуникации", "type":"person"}];

    print(users);
    final res = json.encode(users);
    List<dynamic> parsed = json.decode(res);
  List<DataItem> listItems =
      List<DataItem>.from(parsed.map<DataItem>((dynamic e) => DataItem.fromJson(e)));

  print(listItems);
//     List<dynamic> jsonList = json.decode(jsonString);
//      print(jsonList);
//     var parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
//      print(parsed);
//     var jsons = parsed.map<DataItem>((json) => DataItem.fromJson(json)).toList();
//      print(jsons);
//   final u1 = DataItem.fromJson(json.decode(parsed));
//    print(u1);
// CalendarEventData event2 = CalendarEventData(date: DateTime.parse('2024-11-18 03:00:00.000'), startTime: DateTime.parse('2024-11-18 00:00:00.000'), endTime: DateTime.parse('2024-11-18 23:50:00.000'), event: null, title: 'title', description: 'desc', endDate: DateTime.parse('2024-11-19 00:00:00.000'));

 date: DateFormat('yyyy.mm.dd').parse(json['date'] as String),DateFormat('y.MM.dd').parse(dmyString);
// List<DataItem> users2 = List<DataItem>.from(jsons.map<DataItem>((dynamic e) => DataItem.fromJson(e)));
 print(users2);
    //   list = users2.map( (item) {
    //     return item
    //   },
    // ).toList();
 print(list);
  }

