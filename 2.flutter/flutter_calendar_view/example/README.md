# Календарь

## Roadmap

Чтобы приступить к этому уроку, нужно предварительно изучить по очереди:



- 2.flutter/statefull/statefull



## Методичка

Сейчас вы в библиотеке модуля
Не лезьте в lib! 

Откройте пример из папки example и работайте с ним. 
В папке example/lib вас ждет файл main.dart

Перезапустите Ide из папки example и добавьте
переменную jsonString

```dart
List jsonString = [{"auditorium":"В4\/ауд.3212(кк)","auditoriumAmount":27,"auditoriumGUID":"00000000-0000-0000-0000-000000000000","auditoriumOid":2915,"auditoriumfloor":0,"author":"FADOMAIN\\IPVladimirova","beginLesson":"14:00","building":"4-й Вешняковский проезд, 4","buildingGid":349,"buildingOid":51,"contentOfLoadOid":759322,"contentOfLoadUID":"Нагрузка.281474977106118","contentTableOfLessonsName":"4","contentTableOfLessonsOid":13,"createddate":"2024-10-21T18:20:24Z00:00","date":"2024.10.11","dateOfNest":"\/Date(1728594000000+0300)\/","dayOfWeek":5,"dayOfWeekString":"Пт","detailInfo":"","discipline":"Кроссплатформенная разработка","disciplineOid":36185,"disciplineinplan":null,"disciplinetypeload":0,"duration":2,"endLesson":"15:30","group":"ПИ21-5","groupGUID":"49f53db9-b4c4-4238-a97b-0668d55fc4a7","groupOid":137271,"groupUID":"26007.281474976715107","group_facultyname":"Факультет информационных технологий и анализа больших данных","group_facultyoid":6,"hideincapacity":0,"isBan":false,"kindOfWork":"Практические (семинарские) занятия","kindOfWorkComplexity":1,"kindOfWorkOid":143,"kindOfWorkUid":"26003.281474976710658","lecturer":"Андропов В.В.","lecturerCustomUID":"58a18388-9a69-11ee-86b1-005056bf5929","lecturerEmail":"VVAndropov@fa.ru","lecturerGUID":"086110d6-ac0c-4b44-af2d-7e032eb38395","lecturerOid":38635,"lecturerUID":"26115.281474976719767","lecturer_post_oid":2,"lecturer_rank":"Ассистент","lecturer_title":"Андропов Владимир Викторович","lessonNumberEnd":4,"lessonNumberStart":4,"lessonOid":1324753,"listGroups":[{"group":"ПИ21-5","groupGUID":"49f53db9-b4c4-4238-a97b-0668d55fc4a7","groupGid":0,"groupOid":137271,"groupUID":"26007.281474976715107","group_facultyname":"Факультет информационных технологий и анализа больших данных","group_facultyoid":6}],"listOfLecturers":[{"lecturer":"Андропов В.В.","lecturerCustomUID":"58a18388-9a69-11ee-86b1-005056bf5929","lecturerEmail":"VVAndropov@fa.ru","lecturerGUID":null,"lecturerOid":38635,"lecturerUID":"26115.281474976719767","lecturer_post_oid":2,"lecturer_rank":"Ассистент","lecturer_title":"Андропов Владимир Викторович"}],"modifieddate":"2024-10-21T18:20:24Z00:00","note":null,"note_description":"","openlesson":0,"parentSchedule_Status":0,"parentschedule":"ПИ21-1-6(7 семестр)","replaces":null,"specialization_name":null,"specialization_oid":0,"stream":null,"streamOid":0,"stream_facultyoid":0,"subGroup":null,"subGroupOid":0,"subgroup_facultyoid":0,"subgroup_groupOid":0,"tableofLessonsName":"Единая сетка расписания","tableofLessonsOid":2,"url1":"","url1_description":"","url2":"","url2_description":""}];
// String event = "{date: 2024-11-18 00:00:00.000, startTime: 2024-11-18 03:30:19.776050, endTime: 2024-11-18 21:49:33.901538, event: null, title: title, description: desc, endDate: 2024-11-18 00:00:00.000}";
```

Затем создайте функцию, которая загрузит данные из jsonstring в формате json в лист объектов _events 

```dart
    final res = json.encode(jsonString);
    List<dynamic> parsed = json.decode(res);
  List<CalendarEventData> _events =
      List<CalendarEventData>.from(parsed.map<CalendarEventData>((dynamic e) => CalendarEventData.fromJson(e)));
```

Как видите, наша билиотека   не поддерживает в класе оъекта метод fromjson
И только теперь залезьте в эту билиотеку и добавьте в неё метод

```dart

factory CalendarEventData.fromJson(Map<String, dynamic> json) {
    return CalendarEventData(
        title: (json['lecturer'] as String?) ?? '',
        description: (json['kindOfWork'] as String?) ?? '',
        date: DateFormat('y.MM.dd').parse(json['date'] as String),
        startTime:DateFormat('y.MM.dd H:mm').parse(json['date'] +' '+ json['beginLesson']),
        endTime: DateFormat('y.MM.dd H:mm').parse(json['date'] +' '+ json['endLesson']),
    );
  }
```

## Подсказка

класс объекта описывается в файле 2.flutter/flutter_calendar_view/lib/src/calendar_event_data.dart