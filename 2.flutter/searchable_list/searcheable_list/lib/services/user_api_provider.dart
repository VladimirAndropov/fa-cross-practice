
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:time_scheduler_table/time_scheduler_table.dart';



class UserApiProvider {

Future<List<Event>> getUsers() async {

  // This example uses the Google Books API to search for books about http.
  // https://ruz.fa.ru/api/schedule/group/137269?start=2024.10.10&finish=2024.11.11
  var url =
      Uri.parse('https://ruz.fa.ru/api/schedule/person/8487e5d1-d82e-11e8-b636-005056bf5929?start=2024.11.18&finish=2024.11.24');

  // Await the http get response, then decode the json-formatted response.
  var response = await http.get(url);
  if (response.statusCode == 200) {
    final List<dynamic> jsonResponse = json.decode(response.body);
    
    // return jsonResponse.map((json) => User.fromJson(json)).toList();
    return List<Event>.from(jsonResponse.map<Event>((dynamic e) => Event.fromJson(e)));
    
    
  } else {
    throw Exception('Request failed with status: ${response.statusCode}.');
  }
}
}

