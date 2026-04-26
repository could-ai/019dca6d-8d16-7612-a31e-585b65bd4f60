import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const CertificateMakerApp());
}

class CertificateMakerApp extends StatelessWidget {
  const CertificateMakerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Certificate Maker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
