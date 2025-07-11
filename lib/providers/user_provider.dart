import 'package:flutter/material.dart';
import '../data/models/user_model.dart';
import '../data/services/api_service.dart';

class UserProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<User> _users = [];
  int _page = 1;
  bool _isLoading = false;
  bool _hasMore = true;

  List<User> get users => _users;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  Future<void> fetchUsers() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    notifyListeners();

    try {
      final newUsers = await _apiService.fetchUsers(page: _page);
      if (newUsers.isNotEmpty) {
        _users.addAll(newUsers);
        _page++;
      } else {
        _hasMore = false;
      }
    } catch (e) {
      print(e.toString());
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> refresh() async {
    _users = [];
    _page = 1;
    _hasMore = true;
    _isLoading = false;
    await fetchUsers();
  }
}
