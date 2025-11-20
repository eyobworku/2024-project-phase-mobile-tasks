import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'core/theme.dart';

void main() {
  runApp(const ECommerceApp());
}

class ECommerceApp extends StatelessWidget {
  const ECommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shoe E-commerce',
      theme: AppTheme.lightTheme,
      home: const HomePage(),
    );
  }
}
