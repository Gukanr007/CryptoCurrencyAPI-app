import 'package:cryptoinfo/screens/HomeScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CryptoApp());
}

class CryptoApp extends StatelessWidget {
  const CryptoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Crypto App",
      debugShowCheckedModeBanner: false,
      home: Homescreen(),
    );
  }
}
