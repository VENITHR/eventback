import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static String get appEnv => dotenv.env['APP_ENV'] ?? 'production';

  static String get baseUrl {
    switch (appEnv) {
      case 'dev':
        return dotenv.env['DEV_BASE_URL'] ?? '';
      case 'prod':
        return dotenv.env['PROD_BASE_URL'] ?? '';
      default:
        return dotenv.env['PROD_BASE_URL'] ?? '';
    }
  }
}
