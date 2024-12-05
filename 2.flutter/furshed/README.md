# Расписание

- запускаться на эмуляторе android или linux (под windows через прокси)
- Приложение должно выводить на экран список преподавателей или групп (список)
- По ссылке на преподавателя или группу открывать расписание занятий (календарь)
- Формировать расписание из нескольких преподавателей
- Данные загружать по api с ruz.fa.ru

## Roadmap

Чтобы приступить к этому уроку, нужно предварительно изучить по очереди:



- 2.flutter/statefull/statefull
- 2.flutter/flutter_calendar_view
- 2.flutter/provider
- 2.flutter/news_list
- 2.flutter/netbloc/netbloc
- 2.flutter/time_scheduler_table
- 2.flutter/flbloc/flbloc
- 2.flutter/go_router_example


# Методичка
В данном примере используется два виджета

Код запускался, поэтому сделайте 

  flutter clean

чтобы очистить сборочные файлы


 Список преподавателей
- lib/examples/prepods_list.dart
- календарь - lib/examples/sheduling_calendar.dart

Список групп
- lib/examples/group_list.dart
- lib/examples/group_list_body.dart

Обратите внимание, что вместо навигации используется роут

Потренируйтесь с роутами - 2.flutter/go_router_example

Удачи!