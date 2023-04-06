import 'package:flutter/material.dart';
import 'package:toyidea_smartphone_app/presentation/home/home_page.dart';
import 'package:toyidea_smartphone_app/presentation/login/login_page.dart';
import 'package:toyidea_smartphone_app/presentation/signup/signup_page.dart';
import 'package:toyidea_smartphone_app/presentation/simple_input/simple_input_page.dart';
import 'package:toyidea_smartphone_app/presentation/simple_list/simple_list_page.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      onGenerateRoute: _createRoute,
    );
  }

  Route<dynamic> _createRoute(RouteSettings settings) {
    return MaterialPageRoute<void>(
        settings: settings,
        builder: (BuildContext context) {
          switch (settings.name) {
            case "/":
              return HomePage();
            case "/signup":
              return SignupPage();
            case "/login":
              return LoginPage();
            case "/simple_input":
              return SimpleInputPage();
            case "/simple_list":
              return SimpleListPage();
            default:
              return HomePage();
          }
        });
  }
}
