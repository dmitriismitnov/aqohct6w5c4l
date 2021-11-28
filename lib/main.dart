import 'dart:math' as math;

import 'package:aqohct6w5c4l/providers/providers.dart';
import 'package:flutter/material.dart' show Brightness, ColorScheme, Colors, MaterialApp, TextTheme, ThemeData;
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'screens/main/main.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AppProviders(
      child: AppContent(),
    );
  }
}

class AppProviders extends StatelessWidget {
  final Widget child;

  const AppProviders({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<ProductsProvider>(
      create: (context) {
        return ProductsProvider(
          maxLimit: _generateRandomProductsLength(),
        );
      },
      child: child,
    );
  }

  int _generateRandomProductsLength() {
    return math.Random().nextInt(2) == 1 ? 100000 : 1000000;
  }
}

class AppContent extends StatelessWidget {
  const AppContent({Key? key}) : super(key: key);

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
