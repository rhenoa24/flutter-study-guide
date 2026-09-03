// ## 🎯 Activity 2

// Recreate the widget layout.
// Guidelines:

// - Think of Lego building blocks. Create small, medium, large size widgets to strategically implement this.
//   Utilize this for reusability
// - Clue: its a combination of Scaffold, SingleChildScrollView, SafeArea, Row, Column, Text, Bottom Navigation Bar, etc.
// - Make it scrollable.
// - You can use alternate text and icons.
// - **No need to be functional.**

import 'package:activity_2/widgets/balance_card.dart';
import 'package:activity_2/widgets/home_tabs.dart';
import 'package:activity_2/widgets/quick_actions.dart';
import 'package:activity_2/widgets/services.dart';
import 'package:flutter/material.dart';
import 'package:shared_core/shared_core.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Activity 2',
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

// ============================================================
// MAIN SCREEN
// ============================================================
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [HeaderRow(), SizedBox(height: 20), TabRow()],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: const [
                    BalanceCard(),
                    SizedBox(height: 28),
                    //
                    SectionTitle(title: 'Quick Actions'),
                    SizedBox(height: 12),
                    QuickActionsRow(),
                    SizedBox(height: 28),
                    //
                    SectionTitle(title: 'Services'),
                    SizedBox(height: 12),
                    ServicesGrid(),
                    SizedBox(height: 28),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigation(),
    );
  }
}
