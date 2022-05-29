import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meetups/models/device.dart';
import 'package:meetups/models/event.dart';

const String baseUrl = 'http://192.168.15.13:8080/api';

Future<List<Event>> getAllEvents() async {
  final response = await http.get(Uri.parse('$baseUrl/events'));

  if (response.statusCode == 200) {
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson.map((dynamic json) => Event.fromJson(json)).toList();
  } else {
    throw Exception('Falha ao carregar os eventos');
  }
}

Future<http.Response> sendDevice(Device device) async {
  final response = await http.post(
    Uri.parse('$baseUrl/devices'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',

    },
    body:  jsonEncode({
      'token': device.token??'',
      'modelo': device.model??'',
      'marca': device.brand??''
    })
  );
  return response;
}
