import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl;

  ApiClient({
    required this.baseUrl,
  });

  Future<dynamic> get(
      String endpoint, {
        Map<String, String>? headers,
      }) async {
    final response = await http.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
    );

    return _handleResponse(response);
  }

  Future<dynamic> post(
      String endpoint, {
        Map<String, String>? headers,
        dynamic body,
      }) async {
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        ...?headers,
      },
      body: jsonEncode(body),
    );

    return _handleResponse(response);
  }

  Future<dynamic> put(
      String endpoint, {
        Map<String, String>? headers,
        dynamic body
      }) async {
    final response = await http.put(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        ...?headers,
      },
      body: jsonEncode(body),
    );

    return _handleResponse(response);
  }

  Future<dynamic> delete(
      String endpoint, {
        Map<String, String>? headers,
      }) async {
    final response = await http.delete(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        ...?headers,
      }
    );

    return _handleResponse(response);
  }

  dynamic _handleResponse(http.Response response) {
    final decodedBody = jsonDecode(response.body);

    switch (response.statusCode) {
      case 200:
      case 201:
        return decodedBody;

      case 400:
        throw Exception('Bad Request');

      case 401:
        throw Exception('Unauthorized');

      case 404:
        throw Exception('Not Found');

      case 500:
        throw Exception('Server Error');

      default:
        throw Exception('Unexpected Error');
    }
  }
}