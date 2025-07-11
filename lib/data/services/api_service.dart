// lib/data/services/api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class ApiService {
  final String _baseUrl = "https://reqres.in/api";

  Future<List<User>> fetchUsers({int page = 1, int perPage = 10}) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/users?page=$page&per_page=$perPage'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = json.decode(response.body);
        final List<dynamic> data = body['data'];
        List<User> users =
            data.map((dynamic item) => User.fromJson(item)).toList();
        return users;
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }
}
