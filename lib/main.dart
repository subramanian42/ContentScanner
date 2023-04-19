import 'dart:io';

import 'package:flutter/material.dart';

import 'core/http_override.dart';
import 'landing_screen/screen/landing_screen.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Content Scanner',
      home: LandingScreen(),
    );
  }
}
