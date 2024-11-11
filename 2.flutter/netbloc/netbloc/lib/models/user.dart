import 'dart:convert';

class User {
 

User._({required this.auditorium, required this.beginLesson, required this.building, required this.date, required this.lecturer_title,});

  final String auditorium;
  final DateTime beginLesson;
  final String building;
  final DateTime date;
  final String lecturer_title;

factory User.fromJson(Map<String, dynamic> data) {
  late DateTime beginLesson;
  DateTime now = DateTime.now();
  if (data['beginLesson'] > now) {
    beginLesson = data['beginLesson'];
    }
    else {
     beginLesson = now;
     }
   return User._(
     auditorium: data['auditorium'],
      beginLesson: beginLesson,
       building: data['building'],
        date: data['date'],
         lecturer_title: data['lecturer_title'],
   );
}

void whoAmI() {
    print('I am $auditorium ($beginLesson) and I am $building years old. My color is $lecturer_title.');
  }
}

const String myJson = '{"id": 5, "name": "Herbert", "age": 7}';
 final User decodedUser = User.fromJson(jsonDecode(myJson));

decodedUser.whoAmI();
// final User decodedCat = User.fromJson(jsonDecode(myJson));