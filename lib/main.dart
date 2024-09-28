import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app_flutter/screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
  // Making the navigation bar and status bar transparent
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(systemNavigationBarColor: Colors.transparent));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xff97FEED), brightness: Brightness.dark),
        fontFamily: 'Poppins',
      ),
      home: const WelcomeScreen(),
    );
  }
}
