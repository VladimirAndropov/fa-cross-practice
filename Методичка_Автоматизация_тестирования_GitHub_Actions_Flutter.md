# Методичка. Автоматизация модульного и регрессионного тестирования с помощью GitHub Actions

> **Дисциплина:** Тестирование программного обеспечения  
> **Направление:** 09.03.04 Программная инженерия  
> **Практическое занятие:** Автоматизация модульного и регрессионного тестирования с помощью GitHub Actions  
> **Технологии:** Flutter, Dart, Git, GitHub, GitHub Actions  
> **Учебный проект:** `fa-cross-practice / 2.flutter/furshed`

---

## 1. Дорожная карта занятия

На практическом занятии необходимо научиться включать автоматические тесты Flutter-приложения в процесс разработки с помощью **GitHub Actions**.

Главная идея занятия:

```text
Изменение исходного кода
        ↓
       Git
        ↓
      GitHub
        ↓
 GitHub Actions
        ↓
 flutter test
        ↓
 ┌───────────────┐
 │ тесты пройдены│
 │ или обнаружена │
 │     ошибка     │
 └───────────────┘
```

В результате вы сможете понимать не только синтаксис YAML-файла, но и саму инженерную идею:

> **после изменения программного продукта автоматизированная система должна самостоятельно проверить, не нарушена ли уже существующая функциональность.**

Именно поэтому в данном занятии GitHub Actions рассматривается не как отдельный инструмент DevOps, а как **средство автоматизации тестирования и регрессионного контроля качества ПО**.

---

# 2. Приложение расписания

Для работы используется репозиторий:

**fa-cross-practice**

`https://github.com/VladimirAndropov/fa-cross-practice`

Репозиторий содержит материалы по кроссплатформенной разработке, в том числе Flutter-проект.

Внутри репозитория находится приложение:

```text
2.flutter/
└── furshed/
    ├── android/
    ├── ios/
    ├── lib/
    ├── test/
    ├── web/
    ├── windows/
    ├── pubspec.yaml
    └── ...
```

Сам проект описан как Flutter-приложение, работающее с API `ruz.fa.ru`.

Основные функциональные элементы проекта связаны со списками преподавателей/групп и расписанием.

---

# 3 Actions проекта

Workflow проекта находится здесь:

```text
.github/workflows/main.yml
```

Его можно открыть непосредственно в GitHub:

`https://github.com/VladimirAndropov/fa-cross-practice/blob/main/.github/workflows/main.yml`

Страница выполнения workflow:

`https://github.com/VladimirAndropov/fa-cross-practice/actions`

---


Исходный workflow называется:

```yaml
name: Fluter Furshed
```

Он запускается при `push` в ветку `main`, а также имеет настройку запуска для Pull Request.

В workflow уже выполняются:

1. получение исходного кода;
2. установка Java;
3. установка Flutter;
4. установка зависимостей;
5. создание keystore;
6. сборка APK;
7. загрузка APK как artifact;
8. создание GitHub Release.

Однако две строки, которые непосредственно относятся к нашей теме, сейчас **закомментированы**:

```yaml
# - name: Run tests
#   run: flutter test
```

Также закомментирован статический анализ:

```yaml
# - name: Analyze project source
#   run: flutter analyze
```

Таким образом, исходное состояние проекта удобно использовать как учебную ситуацию:

> **сборка приложения уже автоматизирована, а автоматический запуск тестов пока отключён.**


---

# 4. Почему для занятия лучше создать отдельный workflow тестирования

В исходном `main.yml` тестирование находится рядом со сборкой release APK.

Если запускать весь `main.yml`, GitHub Actions должен:

- устанавливать Java;
- устанавливать Flutter;
- получать зависимости;
- работать с keystore;
- использовать GitHub Secrets;
- собирать release APK;
- загружать artifact;
- создавать Release.

Но для модульного тестирования всё это не требуется.

Нам необходимо только:

```text
checkout
   ↓
Flutter
   ↓
flutter pub get
   ↓
flutter test
```

Поэтому создадим отдельный workflow:

```text
.github/workflows/tests.yml
```

Его задача будет предельно простой:

> **при изменении проекта автоматически запускать тесты Flutter.**

Это также позволяет не связывать учебное тестирование с секретами Android-подписи.

---

# 5. Что такое workflow

Workflow — это сценарий автоматических действий, который GitHub выполняет на виртуальной машине.

Упрощённо:

```text
GitHub
  │
  ├── получил commit
  │
  └── запустил workflow
          │
          ├── скачал код
          ├── установил Flutter
          ├── установил зависимости
          └── запустил тесты
```

Workflow описывается YAML-файлом.

Например:

```yaml
name: Flutter tests

on:
  push:
    branches: [ "main" ]

jobs:
  test:
    runs-on: ubuntu-24.04

    steps:
      - uses: actions/checkout@v4

      - uses: subosito/flutter-action@v2
        with:
          flutter-version: "3.24.5"
          channel: "stable"

      - name: Get dependencies
        working-directory: ./2.flutter/furshed
        run: flutter pub get

      - name: Run tests
        working-directory: ./2.flutter/furshed
        run: flutter test
```

---

# 9. Разбираем YAML по частям

## 9.1. Название workflow

```yaml
name: Flutter tests
```

Это название, которое видно в разделе **Actions**.

Название должно объяснять назначение процесса.

Например:

```yaml
name: Flutter tests
```

лучше, чем:

```yaml
name: test1
```

---

# 10. Когда запускать workflow

```yaml
on:
  push:
    branches: [ "main" ]
```

Это означает:

> запускать workflow после `push` в ветку `main`.

Например:

```text
Студент изменил код
       ↓
git add .
       ↓
git commit
       ↓
git push
       ↓
GitHub
       ↓
workflow
       ↓
flutter test
```

---

# 11. Запуск при Pull Request

Для контроля изменений полезно также использовать:

```yaml
on:
  push:
    branches: [ "main" ]

  pull_request:
    branches: [ "main" ]
```

Теперь тесты запускаются в двух важных ситуациях:

### Push

Когда изменения уже отправлены в `main`.

### Pull Request

Когда разработчик предлагает включить изменения в `main`.

Получается:

```text
                изменение
                    ↓
             Pull Request
                    ↓
             автоматические
                тесты
                    ↓
             ┌──────┴──────┐
             ↓             ↓
           PASS           FAIL
             ↓             ↓
          Merge       исправление
```

---

# 12. Job

Следующий уровень:

```yaml
jobs:
  test:
```

`test` — идентификатор задачи.

Внутри job находятся действия, которые необходимо выполнить.

Например:

```yaml
jobs:
  test:
    runs-on: ubuntu-24.04
    steps:
      ...
```

---

# 13. Где выполняется тест

```yaml
runs-on: ubuntu-24.04
```

GitHub создаёт виртуальную машину с указанной операционной системой.

Для нашего сценария Android-сборка не нужна, поэтому достаточно Linux-окружения.

Важно понимать:

> GitHub Actions не запускает тест на компьютере преподавателя или студента.

Он создаёт отдельное временное окружение.

---

# 14. Первый шаг — получение исходного кода

```yaml
- uses: actions/checkout@v4
```

GitHub runner должен получить содержимое репозитория.

До этого шага виртуальная машина не содержит нашего проекта.

После:

```yaml
actions/checkout
```

на runner появляется:

```text
fa-cross-practice/
├── 1.React/
├── 2.flutter/
├── ...
└── .github/
```

---

# 15. Установка Flutter

Используем:

```yaml
- uses: subosito/flutter-action@v2
  with:
    flutter-version: "3.24.5"
    channel: "stable"
```

После этого runner получает Flutter SDK.

Почему это важно?

На компьютере разработчика Flutter уже установлен.

На GitHub runner его заранее может не быть в нужной версии.

Поэтому workflow должен описывать окружение.

Получаем:

```text
Runner
   ↓
Flutter 3.24.5
   ↓
Flutter project
```

---

# 16. Установка зависимостей

Наш Flutter-проект находится не в корне репозитория.

Он находится здесь:

```text
2.flutter/furshed
```

Поэтому используем:

```yaml
- name: Get dependencies
  working-directory: ./2.flutter/furshed
  run: flutter pub get
```

### `working-directory`

Определяет каталог, из которого выполняется команда.

Фактически GitHub Actions выполняет:

```bash
cd 2.flutter/furshed
flutter pub get
```

---

# 17. Запуск тестов

Главный шаг занятия:

```yaml
- name: Run tests
  working-directory: ./2.flutter/furshed
  run: flutter test
```

Именно эта команда запускает тестовый набор Flutter.

Локально разработчик мог бы выполнить:

```bash
cd 2.flutter/furshed
flutter test
```

GitHub Actions выполняет ту же операцию автоматически.

Это ключевая идея:

> **GitHub Actions не заменяет тесты. Он автоматизирует их запуск.**

---

# 18. Что такое `flutter test`

Flutter предоставляет собственную инфраструктуру тестирования.

В проекте уже существует каталог:

```text
test/
```

В текущем репозитории в нём находится:

```text
test/widget_test.dart
```

То есть структура проекта уже содержит место для автоматических тестов.

---

# 19. Важный момент: текущий тест проекта

В исходном репозитории `widget_test.dart` содержит стандартный Flutter smoke test, проверяющий счётчик:

```dart
testWidgets('Counter increments smoke test',
    (WidgetTester tester) async {
  await tester.pumpWidget(MyApp());

  expect(find.text('0'), findsOneWidget);
  expect(find.text('1'), findsNothing);

  await tester.tap(find.byIcon(Icons.add));
  await tester.pump();

  expect(find.text('0'), findsNothing);
  expect(find.text('1'), findsOneWidget);
});
```

Для текущего приложения этот тест является проблемным с методической точки зрения: приложение `MyApp` уже представляет другое приложение, с маршрутизацией и нижней навигацией, а не стандартный Flutter Counter App.

Поэтому **не стоит просто включать `flutter test` и считать задачу выполненной**.

Нужно сначала привести тест к реальному функционалу приложения.

---

# 20. Проверяем приложение перед написанием теста

Открываем:

```text
2.flutter/furshed/lib/main.dart
```

В `MyApp` используется `GoRouter`.

Начальный маршрут:

```dart
initialLocation: '/PrepodsList',
```

Также определён маршрут:

```dart
path: '/PrepodsList',
name: 'PrepodsList',
```

и маршрут:

```dart
path: '/SchedulePage',
name: 'SchedulePage',
```

Кроме того, приложение содержит `BottomNavigationBar`.

В нём определены два пункта:

```dart
BottomNavigationBarItem(
  icon: Icon(Icons.table_rows_rounded),
  label: 'Прода',
),

BottomNavigationBarItem(
  icon: Icon(Icons.calendar_month_outlined),
  label: 'Тест',
),
```


---

# 21. Создаём первый реальный widget test

Открываем:

```text
2.flutter/furshed/test/widget_test.dart
```

Заменяем содержимое на:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:furshed/main.dart';

void main() {
  testWidgets('Приложение запускается и содержит нижнюю навигацию',
      (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.byType(BottomNavigationBar), findsOneWidget);

    expect(find.text('Прода'), findsOneWidget);
    expect(find.text('Тест'), findsOneWidget);
  });
}
```

---

# 22. Что делает этот тест

Тест запускает:

```dart
MyApp()
```

Затем ищет:

```dart
BottomNavigationBar
```

и проверяет:

```dart
findsOneWidget
```

То есть ожидается ровно один такой виджет.

После этого проверяются подписи:

```dart
'Прода'
'Тест'
```

---

# 23. Почему это уже тестирование

Мы сформулировали проверяемое требование:

> При запуске приложения должна существовать нижняя навигация с двумя пунктами.

Формально:

```text
Требование
    ↓
Приложение содержит BottomNavigationBar
    ↓
BottomNavigationBar содержит два элемента
    ↓
Проверка автоматически
```

Это уже значительно ближе к реальному тестированию программного обеспечения, чем стандартный пример Counter.

---

# 24. Запускаем тест локально

Перед GitHub Actions необходимо проверить тест на компьютере.

Открываем терминал:

```bash
cd 2.flutter/furshed
```

Получаем зависимости:

```bash
flutter pub get
```

Запускаем тесты:

```bash
flutter test
```

Если тест проходит:

```text
00:...
+1: Приложение запускается и содержит нижнюю навигацию
...
All tests passed!
```

можно переходить к GitHub Actions.

---

# 25. Создаём отдельный workflow

В репозитории:

```text
.github/workflows/
```

создаём:

```text
tests.yml
```

Полный вариант:

```yaml
name: Flutter tests

on:
  push:
    branches: [ "main" ]

  pull_request:
    branches: [ "main" ]

jobs:
  test:
    runs-on: ubuntu-24.04

    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: "3.24.5"
          channel: "stable"

      - name: Get dependencies
        working-directory: ./2.flutter/furshed
        run: flutter pub get

      - name: Run tests
        working-directory: ./2.flutter/furshed
        run: flutter test
```

---

# 26. Почему в этом workflow нет Java

В исходном `main.yml` есть:

```yaml
actions/setup-java
```

Это связано с Android-сборкой.

Наш учебный workflow не собирает APK.

Он выполняет:

```text
Flutter
 ↓
dependencies
 ↓
tests
```

Поэтому Java для данной задачи не нужна.

---

# 27. Почему здесь нет keystore

Исходный workflow содержит:

```yaml
ANDROID_KEYSTORE_BASE64
STORE_PASSWORD
KEY_PASSWORD
KEY_ALIAS
```

Они используются для подписи Android APK.

Для `flutter test` подпись APK не нужна.

Поэтому учебный workflow специально не работает с секретами.

Это важно и с точки зрения безопасности:

> тестирование исходного кода не должно требовать доступа к секретам подписи приложения.

---

# 28. Первый запуск GitHub Actions

После добавления:

```text
.github/workflows/tests.yml
```

делаем:

```bash
git add .github/workflows/tests.yml
git commit -m "Add Flutter tests workflow"
git push
```

После `push` открываем:

`https://github.com/VladimirAndropov/fa-cross-practice/actions`

Появится workflow:

```text
Flutter tests
```

---

# 29. Из чего состоит результат запуска

В GitHub Actions можно увидеть:

```text
Flutter tests
└── test
    ├── Checkout repository
    ├── Setup Flutter
    ├── Get dependencies
    └── Run tests
```

Каждый пункт можно раскрыть.

Это очень важный момент для обучения.

вы сможете научиться читать не только:

```text
✓ Success
```

но и **журнал выполнения каждого шага**.

---

# 30. Что делать, если workflow завершился красным цветом

Красный результат не означает автоматически:

> «GitHub Actions не работает».

Необходимо определить, **какой именно шаг завершился ошибкой**.

Например:

```text
Checkout repository       ✓
Setup Flutter             ✓
Get dependencies          ✓
Run tests                 ✗
```

В этом случае проблема относится к тестам.

Другой вариант:

```text
Checkout repository       ✓
Setup Flutter             ✓
Get dependencies          ✗
Run tests                 —
```

Значит, тесты даже не были запущены.

---

# 31. Типовая схема диагностики

При ошибке:

```text
workflow FAILED
```

идём сверху вниз:

```text
1. Checkout
       ↓
2. Flutter
       ↓
3. pub get
       ↓
4. flutter test
```

Нужно определить:

> на каком этапе возникла проблема?

Это важный навык инженера по тестированию.

---

# 32. Регрессионное тестирование

Теперь начинается главная часть занятия.

До этого мы проверили:

```text
Текущая версия приложения
        ↓
      тесты
        ↓
      PASS
```

Но главная ценность автоматических тестов появляется после изменения программы.

Предположим, разработчик изменил:

```text
lib/main.dart
```

или другой файл приложения.

Возникает вопрос:

> Не сломалось ли то, что раньше работало?

Это и есть идея регрессионного тестирования.

---

# 33. Что такое регрессия

Регрессия — ситуация, когда после внесения изменений ранее работавшая функциональность перестаёт работать.

Например:

```text
Версия 1
    ↓
Навигация работает
    ↓
Тест PASS

Внесли изменение
    ↓
Версия 2
    ↓
Навигация сломалась
    ↓
Тест FAIL
```

Без автоматического теста ошибка может остаться незамеченной.

---

# 34. Эксперимент: намеренно ломаем приложение

Теперь преподаватель предлагает студентам изменить код.

Например, временно удалить один из пунктов `BottomNavigationBar`:

```dart
BottomNavigationBarItem(
  icon: Icon(Icons.calendar_month_outlined),
  label: 'Тест',
),
```

После изменения:

```bash
git add .
git commit -m "Break navigation"
git push
```

GitHub Actions снова запускает:

```text
Flutter tests
```

Тест должен обнаружить:

```text
Expected: findsOneWidget
Actual: findsNothing
```

Workflow станет:

```text
❌ FAILED
```

---

# 35. Что произошло

Важно проговорить  цепочку:

```text
Разработчик изменил код
        ↓
Git commit
        ↓
git push
        ↓
GitHub Actions
        ↓
flutter test
        ↓
тест обнаружил нарушение требования
        ↓
FAIL
```

Это и есть автоматизированный регрессионный контроль.

---

# 36. Исправляем ошибку

Возвращаем удалённый элемент:

```dart
BottomNavigationBarItem(
  icon: Icon(Icons.calendar_month_outlined),
  label: 'Тест',
),
```

Затем:

```bash
git add .
git commit -m "Fix navigation"
git push
```

GitHub Actions запускается повторно.

Теперь:

```text
Checkout              ✓
Setup Flutter         ✓
Get dependencies      ✓
Run tests             ✓
```

И весь workflow:

```text
✓ SUCCESS
```

---

# 37. Главное наблюдение занятия

Теперь можно сформулировать:

> Мы не просто один раз запустили тест.

Мы создали механизм:

```text
каждое изменение
      ↓
автоматическая проверка
      ↓
обнаружение регрессии
```

Именно поэтому автоматические тесты становятся частью процесса разработки.

---

# 38. Почему тест называется регрессионным

Допустим, тест был написан для уже существующего поведения:

```text
BottomNavigationBar
```

Изначально:

```text
тест PASS
```

После изменения:

```text
тест FAIL
```

Тест защищает уже существующую функциональность.

Поэтому такой тест может участвовать в регрессионном наборе.

Важно:

> **регрессионное тестирование — это не отдельный вид теста в смысле конкретной техники проверки. Это повторное выполнение тестов после изменений для обнаружения нарушений ранее работавшей функциональности.**

---

# 39. Добавляем второй тест

После первого успешного теста вы сможете добавить ещё одну проверку.

Например:

```dart
testWidgets('Приложение запускается',
    (WidgetTester tester) async {
  await tester.pumpWidget(MyApp());

  expect(find.byType(MaterialApp), findsOneWidget);
});
```

Теперь тестовый набор состоит из нескольких тестов:

```text
Test 1
Приложение запускается
       ↓
      PASS

Test 2
Есть нижняя навигация
       ↓
      PASS
```

---

# 40. Почему несколько тестов лучше одного

Предположим:

```text
10 тестов
```

После изменения:

```text
9 PASS
1 FAIL
```

Получаем более точную информацию:

```text
9 функций не затронуты
1 функциональность нарушена
```

Это гораздо полезнее, чем просто:

```text
Application failed
```

---

# 41. Регрессионный набор

Постепенно каталог:

```text
test/
```

становится регрессионным набором:

```text
test/
├── navigation_test.dart
├── widgets_test.dart
├── routing_test.dart
└── ...
```

Каждый новый тест может защищать определённое требование.

Получается:

```text
Требования
    ↓
Тесты
    ↓
Регрессионный набор
    ↓
GitHub Actions
```

---

# 42. Связь теста с требованием

Для каждого теста полезно задавать вопрос:

> Какое требование он проверяет?

Например:

| Требование | Тест |
|---|---|
| Приложение запускается | `Приложение запускается` |
| Нижняя навигация существует | `Есть нижняя навигация` |
| Есть переход к расписанию | тест маршрутизации |
| Список преподавателей отображается | widget test |
| Ошибки не нарушают интерфейс | отдельный тест |

Так мы переходим от случайного написания тестов к **покрытию требований**.

---

# 43. Что такое CI в нашем примере

Наш workflow является элементом CI — Continuous Integration.

Упрощённая модель:

```text
Developer
    ↓
Code
    ↓
Commit
    ↓
GitHub
    ↓
CI
    ↓
Tests
    ↓
Feedback
```

CI отвечает на вопрос:

> Можно ли безопасно интегрировать это изменение с точки зрения автоматических проверок?

---

# 44. CI не означает «тестировать вместо программиста»

Важно объяснить:

```text
GitHub Actions ≠ тестировщик
```

GitHub Actions выполняет заранее заданный сценарий.

Если тест плохой:

```text
плохой тест
    ↓
PASS
```

это не означает:

```text
программа хорошая
```

Автоматизация выполняет **то, что мы ей запрограммировали**.

Поэтому качество зависит от:

1. требований;
2. тестовых сценариев;
3. тест-кейсов;
4. тестов;
5. инфраструктуры автоматизации.

---

# 45. Почему нельзя ограничиваться `flutter build apk`

В исходном workflow основной результат — сборка APK.

Но:

```text
APK успешно собрался
```

не означает:

```text
Приложение корректно работает
```

Сборка отвечает на вопрос:

> Можно ли собрать приложение?

Тест отвечает на вопрос:

> Выполняет ли программа ожидаемое поведение?

Поэтому:

```text
Build
```

и

```text
Test
```

— разные операции.

---

# 46. Разделяем Build и Test

Хорошая архитектура CI:

```text
                 Git Push
                    │
           ┌────────┴────────┐
           ↓                 ↓
       Automated          Build
         Tests             APK
           │                 │
           ↓                 ↓
         PASS              SUCCESS
```

И только после успешных проверок можно переходить к дальнейшим этапам:

```text
Tests
  ↓
Build
  ↓
Artifact
  ↓
Release
```

---

# 47. Что происходит в исходном `main.yml`

В исходном workflow уже реализована цепочка:

```text
Checkout
    ↓
Java
    ↓
Flutter
    ↓
pub get
    ↓
keystore
    ↓
flutter build apk
    ↓
artifact
    ↓
GitHub Release
```

Но:

```yaml
# - name: Run tests
#   run: flutter test
```

закомментирован.

В рамках занятия вы сможете понять, что автоматизированное тестирование должно быть **частью этого процесса**, а не отдельным ручным действием разработчика.

---

# 48. Почему мы сначала используем отдельный `tests.yml`

Учебная архитектура:

```text
.github/workflows/
├── main.yml       ← сборка и release
└── tests.yml      ← автоматические тесты
```

Преимущество:

- тесты можно запускать быстро;
- тесты не требуют Android keystore;
- тесты не создают release;
- ошибка теста не смешивается с ошибкой подписи APK;
- студент видит назначение CI максимально ясно.

---

# 49. Дополнительное задание: добавить статический анализ

После того как `flutter test` работает, можно добавить:

```yaml
- name: Analyze project
  working-directory: ./2.flutter/furshed
  run: flutter analyze
```

Получится:

```text
Checkout
   ↓
Flutter
   ↓
pub get
   ↓
flutter analyze
   ↓
flutter test
```

Теперь workflow проверяет не только тесты, но и статический анализ исходного кода.

Это соответствует ещё одному пункту практических занятий РПД — **статическому анализу с помощью инструментальных средств**.

---

# 50. Полный учебный workflow с анализом

```yaml
name: Flutter quality checks

on:
  push:
    branches: [ "main" ]

  pull_request:
    branches: [ "main" ]

jobs:
  test:
    runs-on: ubuntu-24.04

    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: "3.24.5"
          channel: "stable"

      - name: Get dependencies
        working-directory: ./2.flutter/furshed
        run: flutter pub get

      - name: Analyze project
        working-directory: ./2.flutter/furshed
        run: flutter analyze

      - name: Run tests
        working-directory: ./2.flutter/furshed
        run: flutter test
```

---

# 51. Важное ограничение текущего репозитория

В `pubspec.yaml` проекта сейчас указано:

```yaml
environment:
  sdk: '>=2.19.6 <3.0.0'
```

При этом исходный workflow устанавливает Flutter:

```yaml
flutter-version: "3.24.5"
```

Поэтому при переносе проекта в современное CI-окружение студент может столкнуться с ошибкой совместимости SDK.

Это **не следует автоматически считать ошибкой GitHub Actions**.

Диагностика должна начинаться с определения места ошибки:

```text
flutter pub get
```

или:

```text
flutter test
```

Если проблема возникает при разрешении зависимостей, необходимо сначала проверить:

```text
Flutter version
Dart version
pubspec.yaml
dependencies
```

---

# 52. Важное отличие: ошибка теста и ошибка окружения

Рассмотрим два случая.

### Случай 1

```text
Get dependencies       ✓
Run tests               ✗
```

Вероятна проблема в тесте или приложении.

### Случай 2

```text
Get dependencies       ✗
Run tests               —
```

Тест вообще не запускался.

Следовательно:

> **Нельзя говорить «тесты не работают», пока не определено, на каком шаге workflow произошёл сбой.**

---

# 53. Практическое задание студенту

## Часть 1. Подготовка

1. Открыть репозиторий:

```text
https://github.com/VladimirAndropov/fa-cross-practice
```

2. Перейти:

```text
2.flutter/furshed
```

3. Найти:

```text
test/widget_test.dart
```

4. Проанализировать существующий тест.

---

## Часть 2. Исправление теста

Удалить устаревший Counter test.

Создать тест, соответствующий текущему приложению.

Минимальное требование:

```text
Проверить наличие BottomNavigationBar.
```

Дополнительно:

```text
Проверить наличие элементов навигации.
```

---

## Часть 3. Локальная проверка

Выполнить:

```bash
cd 2.flutter/furshed
```

затем:

```bash
flutter pub get
```

и:

```bash
flutter test
```

---

## Часть 4. Создание CI

Создать:

```text
.github/workflows/tests.yml
```

Добавить:

```text
checkout
↓
Flutter
↓
pub get
↓
flutter test
```

---

## Часть 5. Первый запуск

Сделать:

```bash
git add .
git commit -m "Add automated Flutter tests"
git push
```

Открыть:

```text
https://github.com/VladimirAndropov/fa-cross-practice/actions
```

Найти:

```text
Flutter tests
```

и проанализировать результат.

---

# 54. Практическое задание: моделирование дефекта

После успешного запуска необходимо **намеренно создать дефект**.

Например:

1. удалить один элемент `BottomNavigationBar`;
2. сохранить изменения;
3. выполнить commit;
4. выполнить push;
5. открыть Actions;
6. найти неуспешный workflow;
7. открыть `Run tests`;
8. определить, какой assertion завершился ошибкой.

Затем:

1. восстановить правильный код;
2. сделать commit;
3. выполнить push;
4. убедиться, что workflow снова завершился успешно.

---

# 55. Что вы сможете зафиксировать

В отчёте необходимо показать:

### 1. Исходный тест

Кратко описать, что он проверял.

### 2. Исправленный тест

Привести код.

### 3. Workflow

Привести `tests.yml`.

### 4. Успешный запуск

Скриншот:

```text
Flutter tests
✓ Success
```

### 5. Неуспешный запуск

Скриншот после намеренного дефекта:

```text
❌ Failure
```

### 6. Исправленный запуск

Скриншот:

```text
✓ Success
```

### 7. Вывод

Объяснить:

> каким образом GitHub Actions обеспечивает автоматический регрессионный контроль после изменения исходного кода.

---

# 56. Контрольные вопросы

1. Что такое GitHub Actions?
2. Что такое workflow?
3. Что такое job?
4. Что такое step?
5. Что делает `actions/checkout`?
6. Зачем workflow устанавливает Flutter?
7. Для чего используется `working-directory`?
8. Что делает команда `flutter pub get`?
9. Что делает `flutter test`?
10. Где находятся тесты Flutter-проекта?
11. Чем автоматический тест отличается от ручного?
12. Что такое модульное тестирование?
13. Что такое регрессионное тестирование?
14. Почему один и тот же тест может использоваться многократно?
15. Почему сборка APK не является тестированием функциональности?
16. Что произойдёт после `git push`, если workflow настроен на `push`?
17. Что произойдёт при ошибке теста?
18. Как определить, на каком этапе workflow произошла ошибка?
19. Зачем запускать тесты при Pull Request?
20. Почему автоматизация тестирования не гарантирует отсутствие дефектов?
21. Что такое CI?
22. Чем тестирование отличается от статического анализа?
23. Зачем разделять workflow сборки APK и workflow тестирования?
24. Для чего в CI нужны тестовые сценарии?
25. Что такое регрессия программного обеспечения?

---

# 57. Задание повышенной сложности

Добавить в workflow статический анализ:

```yaml
- name: Analyze project
  working-directory: ./2.flutter/furshed
  run: flutter analyze
```

Получить:

```text
Checkout
    ↓
Setup Flutter
    ↓
pub get
    ↓
flutter analyze
    ↓
flutter test
```

После этого ответить:

> Что произойдёт, если `flutter analyze` завершится с ошибкой?

И:

> Будет ли запущен следующий шаг `flutter test`?

---

# 58. Задание повышенной сложности №2 — Pull Request

Создать отдельную ветку:

```bash
git checkout -b feature/test-navigation
```

Внести изменение.

Отправить ветку:

```bash
git push -u origin feature/test-navigation
```

Создать Pull Request.

Проверить, запускается ли workflow:

```text
pull_request
```

После этого сделать вывод:

> Почему запуск тестов до объединения ветки `feature` с `main` является полезным механизмом контроля качества?

---

# 59. Итоговая схема занятия

```text
                    ПРОЕКТ
                       │
                       ▼
                 Flutter app
                       │
                       ▼
                Требования
                       │
                       ▼
                     Тест
                       │
                       ▼
                flutter test
                       │
                       ▼
                 GitHub Actions
                       │
              ┌────────┴────────┐
              │                 │
             PASS              FAIL
              │                 │
              ▼                 ▼
       изменение принято   поиск дефекта
              │                 │
              │                 ▼
              │             исправление
              │                 │
              └───────┬─────────┘
                      ▼
                 повторный тест
                      │
                      ▼
                    PASS
```

---

# 60. Главный вывод

В начале занятия тестирование выполнялось вручную:

```bash
flutter test
```

Разработчик должен был помнить:

> «После каждого изменения нужно запустить тесты».

После создания GitHub Actions процесс становится автоматическим:

```text
Изменение кода
      ↓
    commit
      ↓
     push
      ↓
GitHub Actions
      ↓
flutter test
      ↓
результат
```

Таким образом, тестирование становится частью жизненного цикла разработки.

**Главный результат занятия — не написание YAML-файла.**

Главный результат:

> студент понимает, как автоматизированный набор тестов становится механизмом постоянного контроля качества программного продукта после внесения изменений.

---

# 61. Минимальный результат, который должен получить студент

В конце работы в проекте должны существовать:

```text
.github/
└── workflows/
    ├── main.yml
    └── tests.yml

2.flutter/
└── furshed/
    ├── lib/
    ├── test/
    │   └── widget_test.dart
    └── pubspec.yaml
```

А в GitHub Actions должен существовать успешно выполняющийся workflow:

```text
Flutter tests
      ↓
Checkout repository       ✓
Setup Flutter             ✓
Get dependencies          ✓
Run tests                 ✓
```

После намеренного изменения приложения вы сможете уметь получить:

```text
Run tests                 ❌
```

найти причину ошибки, исправить её и получить:

```text
Run tests                 ✓
```

Именно эта последовательность демонстрирует **автоматизацию модульного и регрессионного тестирования программного обеспечения**.
