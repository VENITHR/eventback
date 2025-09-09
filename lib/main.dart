import 'package:bookevent/screens/BookingList/booking_List_provider.dart';
import 'package:bookevent/screens/CreateEvent/create_event_provider.dart';
import 'package:bookevent/screens/CreateEvent/create_event_view.dart';
import 'package:bookevent/screens/Dashboard/dashboard_provider.dart';
import 'package:bookevent/screens/Dashboard/dashboard_view.dart';
import 'package:bookevent/screens/FavoriteList/favorite_list_provider.dart';
import 'package:bookevent/screens/Profile/profile_provider.dart';
import 'package:bookevent/screens/auth/signIn/sign_in.dart';
import 'package:bookevent/screens/auth/signIn/sign_in_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_theme.dart';
import 'core/navigation_service.dart';
import 'main_home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignInProvider()),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteListProvider()),
        ChangeNotifierProvider(create: (_) => BookingListProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => CreateEventProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<String> _getInitialRoute() async {
    final prefs = await SharedPreferences.getInstance();
    final isLogin = prefs.getString('isLogin');
    return isLogin == 'true' ? '/MainHome' : '/signin';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: NavigationService.navigatorKey,
      theme: AppTheme.lightTheme,
      routes: {
        '/signin': (context) => const SignIn(),
        '/dashboardView': (context) => const DashboardView(),
        '/CreateEventView': (context) => const CreateEventView(),
        '/MainHome': (context) => const MainHome(),
      },
      home: FutureBuilder<String>(
        future: _getInitialRoute(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasError) {
            return const Scaffold(
              body: Center(child: Text('Something went wrong')),
            );
          } else {
            final route = snapshot.data!;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              NavigationService.pushReplacementNamed(route);
            });
            return const SizedBox();
          }
        },
      ),
    );
  }
}
