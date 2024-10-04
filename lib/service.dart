import 'dart:convert';
import 'package:http/http.dart' as http;

import 'model.dart';

Future<List<Company>> fetchCompanies() async {
  final response = await http.post(
    Uri.parse('https://crmapi.conscor.com/api/general/v1/mfind'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'x-api-key': 'PLLW0s5A6Rk1aZeAmWr1',
    },
    body: jsonEncode(<String, dynamic>{
      'dbName': 'customize-5',
      'collectionName': 'company_details',
      'query': {}, 
      'projection': {},
      'limit': 5,
      'skip': 0
    }),
  );

  print('Response body: ${response.body}');

  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    List data = jsonResponse['data'];  // Extract the data array
    return data.map((item) => Company.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load data');
  }
}
