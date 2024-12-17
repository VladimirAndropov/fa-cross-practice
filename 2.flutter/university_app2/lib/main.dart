import 'package:flutter/material.dart'; // импорт библиотек для флаттер
import 'package:dio/dio.dart'; // импорт для работы с апи

void main() {
  runApp(MyApp()); // запуск приложения
}

class MyApp extends StatelessWidget { // главны класс приложения
  @override
  Widget build(BuildContext context) { // построение виджетов
    return MaterialApp( // использование материал дизайна
      title: 'Расписание занятий', // заголовок приложения
      theme: ThemeData( // тема приложения
        primarySwatch: Colors.blue, // основной цвет темы
      ),
      home: SchedulePage(), // главная страница расписания
    );
  }
}

class SchedulePage extends StatefulWidget { // страница расписания
  @override
  _SchedulePageState createState() => _SchedulePageState(); // создание состояния
}

class _SchedulePageState extends State<SchedulePage> { // состояние страницы расписания
  final Dio dio = Dio(); // инициализация Dio для апи запросов
  List<dynamic> searchResults = []; // список результатов поиска
  String errorMessage = ''; // сообщение об ошибке
  bool isLoading = false; // флаг загрузки

  String searchType = 'group'; // выбор тип поиска группа или персн

  // поиск групп или преподователей
  Future<void> search(String term) async { // функция поиска
    setState(() { // обновление состояния
      isLoading = true; // показываем загрузку
      errorMessage = ''; // очищаем ошибки
      searchResults = []; // очищаем результаты
    });

    try {
      final response = await dio.get( // делаем гет запрос
          'https://ruz.fa.ru/api/search',
          queryParameters: { // параметры запроса
            'term': term, // поисковый термин
            'type': searchType // тип поиска
          });

      if (response.statusCode == 200 && response.data is List) { // проверка ответа
        setState(() { // обновление состояния
          searchResults = response.data; // сохраняем результаты
        });
      } else {
        setState(() { // если ничего не нашли
          errorMessage = 'ничего не найдено!'; // выводим ошибку
        });
      }
    } catch (e) { // ловим ошибки
      setState(() { // обновляем состояние
        errorMessage = 'ошибка при поиске: $e'; // показываем ошибку
      });
    } finally {
      setState(() { // окончание загрузки
        isLoading = false; // скрываем индикатор
      });
    }
  }

  // формат даты для запроса
  String _formatDatePart(int value) { // функция форматирования даты
    return value < 10 ? '0$value' : value.toString(); // добавляем 0 если меньше 10
  }

  // обработка нажатия на элемент списка
  void onItemTap(Map<String, dynamic> item) { // функция при нажатии
    String id = item['id']; // получаем айди
    String type; // тип элемента

    if (searchType == 'group') { // если группа
      type = 'group'; // тип группа
    } else if (item['type'] == 'lecturer' || item['type'] == 'person') { // если препод
      type = 'person'; // тип персн
    } else { // другой тип
      setState(() { // обновляем состояние
        errorMessage = 'неизвестный тип элемента.'; // ошибка
      });
      return; // выходим из функции
    }

    Navigator.push( // переходим на другую страницу
      context,
      MaterialPageRoute(
        builder: (context) => ScheduleDetailPage( // страница деталей расписания
          id: id, // передаем айди
          type: type, // передаем тип
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) { // построение виджетов
    return Scaffold( // структура страницы
      appBar: AppBar( // верхняя панель
        title: Text('расписание занятий'), // заголовок
      ),
      body: Padding( // отступы вокруг
        padding: const EdgeInsets.all(8.0), // все стороны 8
        child: Column( // колонка для расположения элементов
          children: [
            // выбор типа поиска
            Row( // строка для выбора
              mainAxisAlignment: MainAxisAlignment.center, // центрируем
              children: [
                Text('искать: '), // текст перед выпадающим списком
                DropdownButton<String>( // выпадающий список
                  value: searchType, // текущее значение
                  items: [
                    DropdownMenuItem(value: 'group', child: Text('группа')), // группа
                    DropdownMenuItem(value: 'person', child: Text('преподаватель')), // препод
                  ],
                  onChanged: (value) { // при изменении
                    setState(() { // обновляем состояние
                      searchType = value!; // устанавливаем новый тип
                      searchResults = []; // очищаем результаты
                      errorMessage = ''; // очищаем ошибки
                    });
                  },
                ),
              ],
            ),
            // поле ввода для поиска
            Padding( // отступы
              padding: const EdgeInsets.symmetric(vertical: 8.0), // вертикальные 8
              child: TextField( // текстовое поле
                decoration: InputDecoration( // декорации поля
                  border: OutlineInputBorder(), // обводка
                  hintText: searchType == 'group' // подсказка
                      ? 'введите название группы' // если группа
                      : 'введите имя препода', // если препод
                ),
                onSubmitted: search, // при отправке вызываем поиск
              ),
            ),
            if (isLoading) CircularProgressIndicator(), // показываем индикатор если загружаем
            if (errorMessage.isNotEmpty) // если есть ошибка
              Padding( // отступы
                padding: const EdgeInsets.all(8.0), // все стороны 8
                child: Text(errorMessage, style: TextStyle(color: Colors.red)), // показываем ошибку красным
              ),
            // результаты поиска
            Expanded( // заполняем оставшееся место
              child: searchResults.isEmpty // если нет результатов
                  ? Center(child: Text('введите запрос для поиска')) // показываем текст
                  : ListView.builder( // список результатов
                itemCount: searchResults.length, // количество элементов
                itemBuilder: (context, index) { // построение элемента
                  final item = searchResults[index]; // текущий элемент
                  String displayLabel = item['label'] ?? 'без имени'; // метка
                  String displayDescription = item['description'] ?? ''; // описание
                  return ListTile( // строка списка
                    title: Text(displayLabel), // заголовок
                    subtitle: Text(displayDescription), // подзаголовок
                    onTap: () { // при нажатии
                      onItemTap(item); // вызываем функцию
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScheduleDetailPage extends StatefulWidget { // страница деталей расписания
  final String id; // айди элемента
  final String type; // тип элемента

  ScheduleDetailPage({required this.id, required this.type}); // конструктор

  @override
  _ScheduleDetailPageState createState() => _ScheduleDetailPageState(); // создание состояния
}

class _ScheduleDetailPageState extends State<ScheduleDetailPage> { // состояние страницы расписания
  final Dio dio = Dio(); // инициализация Dio
  List<dynamic> schedule = []; // расписание
  String errorMessage = ''; // сообщение об ошибке
  bool isLoading = false; // флаг загрузки

  @override
  void initState() { // инициализация
    super.initState(); // вызываем родительский метод
    fetchSchedule(); // загружаем расписание
  }

  // загрузка расписания по id и типу
  Future<void> fetchSchedule() async { // функция загрузки расписания
    setState(() { // обновляем состояние
      isLoading = true; // показываем загрузку
      errorMessage = ''; // очищаем ошибки
      schedule = []; // очищаем расписание
    });

    final today = DateTime.now(); // текущая дата
    final nextWeek = today.add(Duration(days: 7)); // дата через неделю
    final startDate =
        "${today.year}.${_formatDatePart(today.month)}.${_formatDatePart(today.day)}"; // форматируем дату начала
    final endDate =
        "${nextWeek.year}.${_formatDatePart(nextWeek.month)}.${_formatDatePart(nextWeek.day)}"; // форматируем дату конца

    String endpoint; // эндпоинт запроса
    if (widget.type == 'group') { // если группа
      endpoint =
      'https://ruz.fa.ru/api/schedule/group/${widget.id}?start=$startDate&finish=$endDate'; // ссылка для группы
    } else if (widget.type == 'person') { // если препод
      endpoint =
      'https://ruz.fa.ru/api/schedule/person/${widget.id}?start=$startDate&finish=$endDate'; // ссылка для препода
    } else { // другой тип
      setState(() { // обновляем состояние
        errorMessage = 'неизвестный тип расписания.'; // ошибка
        isLoading = false; // скрываем индикатор
      });
      return; // выходим из функции
    }

    try {
      final response = await dio.get(endpoint); // делаем гет запрос

      if (response.statusCode == 200 && response.data is List) { // проверка ответа
        setState(() { // обновляем состояние
          schedule = response.data; // сохраняем расписание
        });
      } else {
        setState(() { // если ничего не нашли
          errorMessage = 'расписание не найдено!'; // показываем ошибку
        });
      }
    } catch (e) { // ловим ошибки
      setState(() { // обновляем состояние
        errorMessage = 'ошибка при загрузке расписания: $e'; // показываем ошибку
      });
    } finally {
      setState(() { // окончание загрузки
        isLoading = false; // скрываем индикатор
      });
    }
  }

  // формат даты
  String _formatDatePart(int value) { // функция форматирования даты
    return value < 10 ? '0$value' : value.toString(); // добавляем 0 если меньше 10
  }

  @override
  Widget build(BuildContext context) { // построение виджетов
    String title = widget.type == 'group' ? 'расписание группы' : 'расписание препода'; // заголовок страницы

    return Scaffold( // структура страницы
      appBar: AppBar( // верхняя панель
        title: Text(title), // заголовок
      ),
      body: Padding( // отступы вокруг
        padding: const EdgeInsets.all(8.0), // все стороны 8
        child: isLoading // если загружаем
            ? Center(child: CircularProgressIndicator()) // показываем индикатор
            : errorMessage.isNotEmpty // если есть ошибка
            ? Center(
          child: Text(
            errorMessage, // показываем ошибку
            style: TextStyle(color: Colors.red), // красным цветом
          ),
        )
            : schedule.isEmpty // если расписание пустое
            ? Center(child: Text('расписание отсутствует')) // показываем текст
            : ListView.builder( // список расписания
          itemCount: schedule.length, // количество элементов
          itemBuilder: (context, index) { // построение элемента
            final lesson = schedule[index]; // текущий урок
            String discipline = lesson['discipline'] ?? 'неизвестный предмет'; // название предмета
            String date = lesson['date'] ?? ''; // дата урока
            String time = '${lesson['beginLesson'] ?? ''} - ${lesson['endLesson'] ?? ''}'; // время урока
            String auditorium = lesson['auditorium'] ?? ''; // аудитория

            return Card( // карточка для урока
              child: ListTile( // строка списка
                title: Text(discipline), // название предмета
                subtitle: Text('$date, $time'), // дата и время
                trailing: Text(auditorium), // аудитория
              ),
            );
          },
        ),
      ),
    );
  }
}