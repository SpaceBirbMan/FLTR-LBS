import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> getNasaData(String rover, String sol, String key) async {
  String baseUri = 'https://api.nasa.gov/mars-photos/api/v1/rovers';

  Uri url = Uri.parse('$baseUri/$rover/photos?sol=$sol&api_key=$key');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Unable to decode JSON: ${response.reasonPhrase}');
  }
}