import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/features/forecast/forecast_screen.dart';
import 'package:weather/models/session.dart';
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
          canvasColor: const Color(0xFFb2ebf2),
          cardTheme: Theme.of(context).cardTheme.copyWith(
            color: const Color(0xFF0097a7),
            elevation: 8,
          ),
          textTheme: const TextTheme(
            headline4: TextStyle(color: Colors.white),
            headline6: TextStyle(color: Colors.white),
            subtitle2: TextStyle(color: Colors.white),
          ),
          useMaterial3: true,

          appBarTheme: Theme.of(context).appBarTheme.copyWith(
            color: const Color(0xFF0097a7),
          ),
          // primaryColor: const Color(0xFF222727),
          // cardColor: Colors.black12,
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
