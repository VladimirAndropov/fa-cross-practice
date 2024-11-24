# Расписание

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

- Список преподавателей - 
2.flutter/searchable_list/searcheable_list/lib/examples/loadmore_listview.dart
- календарь - 2.flutter/searchable_list/searcheable_list/lib/examples/sheduling_calendar.dart

Обратите внимание, что между виджетами происходит переключение за счет переменной 

```
prepodid !=''
            ? ShedulingCalendar(id: prepodid)
            : ChangeNotifierProvider(
```

Параметры из одного виджета в другой передаются за счет провайдера


```

MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Counts()),
      ],
      child: MyApp(),
```

