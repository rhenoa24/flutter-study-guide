import 'package:activity_7/screens/card_search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_ui/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Activity 5',
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const CardSearchScreen(),
    );
  }
}
