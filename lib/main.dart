import 'package:flutter/material.dart';
import 'package:literasea_mobile/authentication/screens/welcome_page.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class UserInfo {
  static bool loggedIn = false;
  static Map<String, dynamic> data = {};

  static void login(Map<String, dynamic> data) {
    loggedIn = true;
    UserInfo.data = data;
  }

  static void logout() {
    loggedIn = false;
    data = {};
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) {
        CookieRequest request = CookieRequest();
        return request;
      },
      child: MaterialApp(
          theme: ThemeData(scaffoldBackgroundColor: Colors.white),
          debugShowCheckedModeBanner: false,
          home: const WelcomePage()),
    );
  }
}
