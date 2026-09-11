```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:furshed/main.dart';
import 'package:furshed/examples/prepods_list.dart';

void main() {
  group('API тесты', () {
    test('API РУЗ возвращает список преподавателей или групп', () async {
      // Выполняем реальный запрос к API приложения.
      //
      // false означает поиск группы.
      // Для запроса используется непустая строка.
      final results = await Prepods.search('ПИ', false);

      // API должен вернуть коллекцию результатов.
      expect(results, isNotNull);

      // Проверяем, что API действительно вернул данные.
      expect(results, isNotEmpty);

      // Проверяем структуру первого полученного элемента.
      final first = results.first;

      expect(first.id, isNotEmpty);
      expect(first.label, isNotEmpty);
    });
  });

  group('Widget-тесты приложения', () {
    testWidgets(
      'Приложение запускается и отображает экран Расписание',
      (WidgetTester tester) async {
        await tester.pumpWidget(MyApp());

        // Даём приложению время построить интерфейс.
        await tester.pumpAndSettle();

        // Проверяем наличие заголовка приложения.
        expect(find.text('Расписание'), findsOneWidget);

        // Проверяем наличие строки поиска.
        expect(find.byType(SearchBar), findsOneWidget);

        // Проверяем нижнюю навигацию.
        expect(find.byType(BottomNavigationBar), findsOneWidget);
      },
    );

    testWidgets(
      'Поиск получает данные из API и выводит список результатов',
      (WidgetTester tester) async {
        await tester.pumpWidget(MyApp());

        await tester.pumpAndSettle();

        // Находим поисковую строку приложения.
        final searchBar = find.byType(SearchBar);

        expect(searchBar, findsOneWidget);

        // Открываем окно поиска.
        await tester.tap(searchBar);

        await tester.pumpAndSettle();

        // Вводим запрос.
        //
        // Это тот же механизм, который используется пользователем
        // для поиска группы.
        await tester.enterText(
          find.byType(SearchBar),
          'ПИ',
        );

        // Даём SearchAnchor возможность выполнить
        // асинхронный suggestionsBuilder.
        await tester.pump();

        // Ждём завершения HTTP-запроса и построения результатов.
        await tester.pump(
          const Duration(seconds: 3),
        );

        // API должен вернуть хотя бы один результат.
        //
        // Результаты в приложении выводятся как ListTile.
        expect(find.byType(ListTile), findsWidgets);
      },
    );

    testWidgets(
      'Можно выбрать найденную группу',
      (WidgetTester tester) async {
        await tester.pumpWidget(MyApp());

        await tester.pumpAndSettle();

        // Открываем поиск.
        await tester.tap(find.byType(SearchBar));

        await tester.pumpAndSettle();

        // Выполняем поиск.
        await tester.enterText(
          find.byType(SearchBar),
          'ПИ',
        );

        await tester.pump();
        await tester.pump(
          const Duration(seconds: 3),
        );

        // Проверяем, что результаты действительно появились.
        final results = find.byType(ListTile);

        expect(results, findsWidgets);

        // Выбираем первый результат.
        await tester.tap(results.first);

        // Даём приложению обработать выбор.
        await tester.pumpAndSettle();

        // После выбора SearchAnchor должен закрыться.
        //
        // Главное здесь — приложение не должно завершиться
        // с исключением после выбора элемента.
        expect(find.byType(BottomNavigationBar), findsOneWidget);
      },
    );
  });
}
```
