
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:netbloc/models/user.dart';

class UserApiProvider {

Future<List<User>> getUsers() async {
  // This example uses the Google Books API to search for books about http.
  // https://ruz.fa.ru/api/schedule/group/137269?start=2024.10.10&finish=2024.11.11
  var url =
      Uri.https('ruz.fa.ru', '/api/schedule/group/137269?start=2024.10.10&finish=2024.11.11', {'q': '{http}'});

  // Await the http get response, then decode the json-formatted response.
  var response = await http.get(url);
  if (response.statusCode == 200) {
    final List<dynamic> jsonResponse = json.decode(response.body);
    
    return jsonResponse.map((json) => User.fromJson(json)).toList();
    
    
  } else {
    throw Exception('Request failed with status: ${response.statusCode}.');
  }
}
}

