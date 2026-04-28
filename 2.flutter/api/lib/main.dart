import 'dart:io';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'dart:convert'; // Добавляем этот импорт для работы с jsonEncode
import 'package:dio/dio.dart' as dio;

void main() async {
  final router = Router();
  final dioClient = dio.Dio(dio.BaseOptions(
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  // Маршрут для поиска
  router.get('/search/<term>', (shelf.Request request, String term) async {
    print("Получен запрос на поиск: $term");
    final apiUrl = 'https://ruz.fa.ru/api/search?term=$term';

    try {
      final response = await dioClient.get(apiUrl);

      // Преобразуем данные перед отправкой
      final data = response.data;

      if (data is List) {
        final cleanData = data.map((item) {
          return {
            "id": item['id'].toString(),  // Приводим 'id' к строке
            "label": item['label'] ?? "",
            "description": item['description'] ?? "",
            "type": item['type'] ?? ""
          };
        }).toList();

        return shelf.Response.ok(
          jsonEncode(cleanData), // Кодируем JSON в строку
          headers: {'Content-Type': 'application/json; charset=utf-8'},
        );
      } else {
        return shelf.Response.internalServerError(body: 'Некорректный формат данных');
      }
    } catch (e) {
      print("Ошибка при выполнении запроса: $e");
      return shelf.Response.internalServerError(body: 'Ошибка на сервере');
    }
  });


  // Маршрут для расписания преподавателя
  router.get('/schedule/teacher/<teacherId>', (shelf.Request req, String teacherId) async {
    final apiUrl = 'https://ruz.fa.ru/api/schedule?teacher_id=$teacherId';
    final response = await dioClient.get(apiUrl);
    return shelf.Response.ok(response.data, headers: {'Content-Type': 'application/json; charset=utf-8'});
  });

  // Маршрут для расписания группы
  router.get('/schedule/group/<groupId>', (shelf.Request req, String groupId) async {
    final apiUrl = 'https://ruz.fa.ru/api/schedule?group_id=$groupId';
    final response = await dioClient.get(apiUrl);
    return shelf.Response.ok(response.data, headers: {'Content-Type': 'application/json; charset=utf-8'});
  });

  // Обработчик запросов и запуск сервера
  final handler = const shelf.Pipeline()
      .addMiddleware(shelf.logRequests())
      .addHandler(router);

  final server = await io.serve(handler, InternetAddress.loopbackIPv4, 8080);
  print('Backend запущен на http://localhost:${server.port}');
}