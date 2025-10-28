import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'screens/sender_screen.dart';
import 'screens/landing_screen.dart';

void main() {
  runApp(const TShareApp());
}

class TShareApp extends StatelessWidget {
  const TShareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'T-Share - تبادل الملفات عبر P2P',
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar'), // اللغة الافتراضية العربية
      supportedLocales: const [
        Locale('ar'),
        Locale('en'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        primaryColor: const Color(0xFF0b74ff),
        scaffoldBackgroundColor: const Color(0xFFf7f8fb),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF111111)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0b74ff),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            shadowColor: Colors.black.withOpacity(0.2),
            elevation: 5,
          ),
        ),
        cardTheme: CardTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
          shadowColor: Colors.black.withOpacity(0.1),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: const Color(0xFF0b74ff),
        scaffoldBackgroundColor: const Color(0xFF1a1a1a),
      ),
      themeMode: ThemeMode.system, // Dark Mode تلقائي حسب النظام
      initialRoute: '/sender',
      routes: {
        '/sender': (context) => const SenderScreen(),
        '/landing': (context) => const LandingScreen(),
      },
    );
  }
}