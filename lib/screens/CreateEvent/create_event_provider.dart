import 'package:bookevent/core/navigation_service.dart';
import 'package:bookevent/screens/CreateEvent/create_event_repo.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateEventProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  final formKey = GlobalKey<FormState>();
  final title = TextEditingController();
  final description = TextEditingController();
  final startTime = TextEditingController();
  final endTime = TextEditingController();
  final location = TextEditingController();
  final capacity = TextEditingController();

  final CreateEventRepo _repo = CreateEventRepo();

  Future<bool> createEvent() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!formKey.currentState!.validate()) {
      return false;
    }
    _setLoading(true);
    var data = {
      "title": title.text,
      "description": description.text,
      "start_time": startTime.text,
      "end_time": endTime.text,
      "location": location.text,
      "capacity": capacity.text
    };
    final result = await _repo.createEvent(data);
    _setLoading(false);
    if (result['success']) {
      notifyListeners();
      NavigationService.pop();

      return true;
    } else {
      _setError(result['message'] ?? 'Login failed');
      return false;
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  @override
  void dispose() {
    description.dispose();
    title.dispose();
    startTime.dispose();
    endTime.dispose();
    location.dispose();
    capacity.dispose();
    super.dispose();
  }
}
