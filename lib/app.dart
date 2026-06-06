import 'package:flutter/material.dart';
import 'package:seguridad_flutter/features/auth/presentation/screens/login_screen.dart';
import 'package:seguridad_flutter/features/auth/presentation/viewmodels/inactivity_view_model.dart';
import 'package:seguridad_flutter/shared/screens/home_screen.dart';
import 'package:seguridad_flutter/shared/session/session_provider.dart';
import 'package:seguridad_flutter/shared/theme/theme.dart';
import 'package:seguridad_flutter/shared/theme/util.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> globalNavigatorKey =
    GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, "Roboto", "Poppins");
    MaterialTheme theme = MaterialTheme(textTheme);

    return ChangeNotifierProvider(
      lazy: false,
      create: (context) => InactivityViewModel(
        onSessionExpired: () async {
          if (globalNavigatorKey.currentContext == null) return;

          final sessionProvider = Provider.of<SessionProvider>(
            globalNavigatorKey.currentContext!, 
            listen: false
          );

          
          if (!sessionProvider.isAuthenticated) {
            return;
          }

          await sessionProvider.lockSession();
          
          Future.microtask(() {
            globalNavigatorKey.currentState?.pushNamedAndRemoveUntil('/login', (route) => false);
            
            ScaffoldMessenger.of(globalNavigatorKey.currentContext!).showSnackBar(
              const SnackBar(
                content: Text(
                  'Sesión expirada por inactividad. Por favor, ingresa de nuevo.',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                backgroundColor: Colors.redAccent,
                duration: Duration(seconds: 4),
                behavior: SnackBarBehavior.floating,
              ),
            );
          });
        },
      ),
      child: MaterialApp(
        navigatorKey: globalNavigatorKey, 
        title: 'Flutter Demo',
        theme: theme.light(),
        darkTheme: theme.dark(),
        themeMode: ThemeMode.system,
        initialRoute: '/login',
        routes: {
          '/login': (context) => const LoginScreen(),
          '/home': (context) => const HomeScreen(),
        },
        builder: (context, child) {
          return Listener(
            behavior: HitTestBehavior.translucent,
            onPointerDown: (_) {
              context.read<InactivityViewModel>().resetTimer();
            },
            child: child!,
          );
        },
      ),
    );
  }
}