import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:http/http.dart' as http;

void main() async {
  final handler = (Request request) async {
    if (request.method == 'OPTIONS') {
      return Response.ok('', headers: {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': 'GET, OPTIONS',
        'Access-Control-Allow-Headers': '*',
      });
    }

    // берём путь и query от клиента
    final path = request.url.path; // search
    final query = request.url.query; // type=person&term=...

    final targetUrl = 'https://ruz.fa.ru/api/$path?$query';

    final response = await http.get(Uri.parse(targetUrl));

    return Response.ok(
      response.body,
      headers: {
        'Access-Control-Allow-Origin': '*',
      },
    );
  };

  print('Server running on http://localhost:3000');

  await io.serve(handler, 'localhost', 3000);
}
