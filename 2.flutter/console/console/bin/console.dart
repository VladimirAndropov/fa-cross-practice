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
{"auditorium":"В4\/ауд.3212(кк)","auditoriumAmount":27,"auditoriumGUID":"00000000-0000-0000-0000-000000000000","auditoriumOid":2915,"auditoriumfloor":0,"author":"FADOMAIN\\IPVladimirova","beginLesson":"14:00","building":"4-й Вешняковский проезд, 4","buildingGid":349,"buildingOid":51,"contentOfLoadOid":759322,"contentOfLoadUID":"Нагрузка.281474977106118","contentTableOfLessonsName":"4","contentTableOfLessonsOid":13,"createddate":"2024-10-21T18:20:24Z00:00","date":"2024.10.11","dateOfNest":"\/Date(1728594000000+0300)\/","dayOfWeek":5,"dayOfWeekString":"Пт","detailInfo":"","discipline":"Кроссплатформенная разработка","disciplineOid":36185,"disciplineinplan":null,"disciplinetypeload":0,"duration":2,"endLesson":"15:30","group":"ПИ21-5","groupGUID":"49f53db9-b4c4-4238-a97b-0668d55fc4a7","groupOid":137271,"groupUID":"26007.281474976715107","group_facultyname":"Факультет информационных технологий и анализа больших данных","group_facultyoid":6,"hideincapacity":0,"isBan":false,"kindOfWork":"Практические (семинарские) занятия","kindOfWorkComplexity":1,"kindOfWorkOid":143,"kindOfWorkUid":"26003.281474976710658","lecturer":"Андропов В.В.","lecturerCustomUID":"58a18388-9a69-11ee-86b1-005056bf5929","lecturerEmail":"VVAndropov@fa.ru","lecturerGUID":"086110d6-ac0c-4b44-af2d-7e032eb38395","lecturerOid":38635,"lecturerUID":"26115.281474976719767","lecturer_post_oid":2,"lecturer_rank":"Ассистент","lecturer_title":"Андропов Владимир Викторович","lessonNumberEnd":4,"lessonNumberStart":4,"lessonOid":1324753,"listGroups":[{"group":"ПИ21-5","groupGUID":"49f53db9-b4c4-4238-a97b-0668d55fc4a7","groupGid":0,"groupOid":137271,"groupUID":"26007.281474976715107","group_facultyname":"Факультет информационных технологий и анализа больших данных","group_facultyoid":6}],"listOfLecturers":[{"lecturer":"Андропов В.В.","lecturerCustomUID":"58a18388-9a69-11ee-86b1-005056bf5929","lecturerEmail":"VVAndropov@fa.ru","lecturerGUID":null,"lecturerOid":38635,"lecturerUID":"26115.281474976719767","lecturer_post_oid":2,"lecturer_rank":"Ассистент","lecturer_title":"Андропов Владимир Викторович"}],"modifieddate":"2024-10-21T18:20:24Z00:00","note":null,"note_description":"","openlesson":0,"parentSchedule_Status":0,"parentschedule":"ПИ21-1-6(7 семестр)","replaces":null,"specialization_name":null,"specialization_oid":0,"stream":null,"streamOid":0,"stream_facultyoid":0,"subGroup":null,"subGroupOid":0,"subgroup_facultyoid":0,"subgroup_groupOid":0,"tableofLessonsName":"Единая сетка расписания","tableofLessonsOid":2,"url1":"","url1_description":"","url2":"","url2_description":""}
];

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

 var weekday = DateFormat('y.MM.dd').parse('2024.10.11').weekday;
        //  ldate: DateFormat('y.MM.dd').parse(listItems['date']);
var beginLessonH = DateFormat('H:mm').parse('11:00').hour;
var beginLessonm = DateFormat('H:mm').parse('14:00').minute;
print(beginLessonH);print(beginLessonm);
var bb = (((DateFormat('H:mm').parse('11:00').hour)/2.4+(DateFormat('H:mm').parse('14:00').minute)/60)*1.6).toInt();

        // endTime: DateFormat('y.MM.dd H:mm').parse(json['date'] +' '+ json['endLesson']),
// List<DataItem> users2 = List<DataItem>.from(jsons.map<DataItem>((dynamic e) => DataItem.fromJson(e)));

    //   list = users2.map( (item) {
    //     return item
    //   },
    // ).toList();
 print(bb);
  }

