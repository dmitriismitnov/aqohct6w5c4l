import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/main/main.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: const ColorScheme(
          primary: Color(0xFF2F54EB),
          primaryVariant: Color(0xFF2F54EB),
          secondary: Color(0xFF2F54EB),
          secondaryVariant: Color(0xFF2F54EB),
          surface: Color(0xFF050505),
          background: Color(0xFF050505),
          error: Colors.red,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.white,
          onBackground: Colors.white,
          onError: Colors.white,
          brightness: Brightness.dark,
        ),
        textTheme: TextTheme(
          headline1: GoogleFonts.roboto(
            color: Colors.white,
            fontSize: 20,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.15,
          ),
          subtitle1: GoogleFonts.roboto(
            color: Colors.white,
            fontSize: 14,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.15,
          ),
        ),
      ),
      home: const MainScreen(),
    );
  }
}
