import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'intro.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const HandsyApp());
}

class HandsyApp extends StatelessWidget {
  const HandsyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HANDSY',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Inter', // Add consistent font
        useMaterial3: true, // Modern material design
      ),
      home: const IntroScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
