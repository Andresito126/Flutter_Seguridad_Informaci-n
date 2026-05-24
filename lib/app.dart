import 'package:flutter/material.dart';
import 'package:seguridad_flutter/shared/theme/theme.dart';
import 'package:seguridad_flutter/shared/theme/util.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    TextTheme textTheme = createTextTheme(context, "Roboto", "Poppins");
    MaterialTheme theme = MaterialTheme(textTheme);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme.light(),
      darkTheme: theme.dark(),
      themeMode:  ThemeMode.system,

    
    );
  }
}
  