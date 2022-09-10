import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/features/forecast/forecast_screen.dart';
import 'package:weather/features/models/session.dart';
import 'features/login/login_screen.dart';

void main() {
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigationKey = GlobalKey();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Session(),
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.dark,
          appBarTheme: Theme.of(context).appBarTheme.copyWith(
            color: Colors.black12,
          ),
          primaryColor: const Color(0xFF222727),
          cardColor: Colors.black12,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const MainAppNavigator(),
        },
      ),
    );
  }
}

class MainAppNavigator extends StatelessWidget {
  const MainAppNavigator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Session>(
      builder: (context, session, _) {
        return Navigator(
          key: navigationKey,
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
              case '/login':
                return MaterialPageRoute(builder: (BuildContext context) {
                  return const LoginScreen();
                });
              case '/forecast':
                return MaterialPageRoute(builder: (BuildContext context) {
                  return const ForeCastScreen();
                });
              default:
                return MaterialPageRoute(builder: (BuildContext context) {
                  return session.isConnected
                      ? const ForeCastScreen()
                      : const LoginScreen();
                });
            }
          },
        );
      },
    );
  }
}
