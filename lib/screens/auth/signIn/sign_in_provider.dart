import 'package:bookevent/core/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'sign_in_repo.dart';

class SignInProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final SignInRepo _repo = SignInRepo();

  Future<bool> signIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!formKey.currentState!.validate()) {
      return false;
    }
    _setLoading(true);
    final result = await _repo.login(
      usernameController.text.trim(),
      passwordController.text.trim(),
    );
    _setLoading(false);
    if (result['success']) {
      await prefs.setString('isLogin', 'true');
      await prefs.setString('access_token', result['data']['token']);
      NavigationService.pushNamed('/MainHome');
      usernameController.clear();
      passwordController.clear();
      _errorMessage = null;
      notifyListeners();
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
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
