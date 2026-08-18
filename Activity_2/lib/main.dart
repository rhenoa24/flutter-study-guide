// ## 🎯 Activity 2

// Recreate the widget layout.
// Guidelines:

// - Think of Lego building blocks. Create small, medium, large size widgets to strategically implement this.
//   Utilize this for reusability
// - Clue: its a combination of Scaffold, SingleChildScrollView, SafeArea, Row, Column, Text, Bottom Navigation Bar, etc.
// - Make it scrollable.
// - You can use alternate text and icons.
// - **No need to be functional.**

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Activity 2',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF007236),
          brightness: Brightness.dark,
          dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
        ),
        fontFamily: 'Roboto',
      ),
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              _HeaderRow(),
              const SizedBox(height: 20),
              _TabRow(),
              const SizedBox(height: 20),
              _BalanceCard(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// SMALL WIDGETS
// ============================================================

// Top Row Header: Avatar + Greeting + Mail Icons
class _HeaderRow extends StatelessWidget {
  const _HeaderRow();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: colorScheme.primaryContainer,
          child: Icon(Icons.person, color: colorScheme.onSurface, size: 28),
        ),
        const SizedBox(width: 12),
        Text(
          'Good Evening!',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        Icon(Icons.mail_outline, size: 26, color: colorScheme.primaryContainer),
      ],
    );
  }
}

// Single Tab Label
class _TabItem extends StatelessWidget {
  final String label;
  final bool isSelected;

  const _TabItem({required this.label, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: isSelected
                ? colorScheme.onSurface
                : colorScheme.secondaryContainer,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          height: 2,
          width: 46,
          color: isSelected ? colorScheme.primaryContainer : Colors.transparent,
        ),
      ],
    );
  }
}

// Tab Row
class _TabRow extends StatelessWidget {
  const _TabRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _TabItem(label: 'Home', isSelected: true),
        const SizedBox(width: 24),
        _TabItem(label: 'Cards'),
        const SizedBox(width: 24),
        _TabItem(label: 'Savings'),
        const SizedBox(width: 24),
        _TabItem(label: 'Loans'),
      ],
    );
  }
}

// White Pill buttons
class _PillButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const _PillButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: colorScheme.onSurface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18, color: colorScheme.surface),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}

// Balance Card
class _BalanceCard extends StatelessWidget {
  const _BalanceCard();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Available Balance',
            style: TextStyle(color: colorScheme.primary),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                'Php 10,000.00',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              Icon(Icons.visibility_outlined, size: 20),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text('1,200 Points'),
              const SizedBox(width: 8),
              Icon(Icons.chevron_right, size: 20),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _PillButton(
                  icon: Icons.download_outlined,
                  label: 'Cash In',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _PillButton(
                  icon: Icons.upload_outlined,
                  label: 'Cash Out',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
