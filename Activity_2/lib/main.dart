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
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: const [
              _HeaderRow(),
              SizedBox(height: 20),
              _TabRow(),
              SizedBox(height: 20),
              //
              _BalanceCard(),
              SizedBox(height: 28),
              //
              _SectionTitle(title: 'Quick Actions'),
              SizedBox(height: 12),
              _QuickActionsRow(),
              SizedBox(height: 28),
              //
              _SectionTitle(title: 'Services'),
              SizedBox(height: 12),
              _ServicesGrid(),
              SizedBox(height: 28),
            ],
          ),
        ),
      ),

      bottomNavigationBar: _BottomNavigation(),
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
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
            color: isSelected ? colorScheme.onSurface : colorScheme.outline,
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
                child: _PillButton(icon: Icons.download, label: 'Cash In'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _PillButton(icon: Icons.upload, label: 'Cash Out'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Section Header Text
class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }
}

// Reusable Action Tiles
class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ActionTile({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 26, color: colorScheme.primaryContainer),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// MEDIUM WIDGETS
// ============================================================

// Action Buttons - Quick Actions
class _QuickActionsRow extends StatelessWidget {
  const _QuickActionsRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: _ActionTile(icon: Icons.description, label: 'Pay Bills'),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _ActionTile(icon: Icons.person, label: 'Send Money'),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _ActionTile(
            icon: Icons.account_balance,
            label: 'Bank Transfer',
          ),
        ),
      ],
    );
  }
}

// Action Buttons - Services
class _ServicesGrid extends StatelessWidget {
  const _ServicesGrid();

  static const List<Map<String, dynamic>> _items = [
    {'icon': Icons.smartphone, 'label': 'Buy Load'},
    {'icon': Icons.account_balance, 'label': 'Loans'},
    {'icon': Icons.credit_card, 'label': 'Cards'},
    {'icon': Icons.savings, 'label': 'PalaSave'},
    {'icon': Icons.shield, 'label': 'ProtektODO'},
    {'icon': Icons.paid, 'label': 'Claim Remittance'},
    {'icon': Icons.public, 'label': 'Pera Padala Abroad'},
    {'icon': Icons.diamond, 'label': 'Buy Jewelry'},
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final item = _items[index];
        return _ActionTile(icon: item['icon'], label: item['label']);
      },
    );
  }
}

// ============================================================
// BOTTOM NAVIGATION
// ============================================================
class _BottomNavigation extends StatelessWidget {
  const _BottomNavigation();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: 80,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          SizedBox(
            height: 80,
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: 0,
              unselectedFontSize: 12,
              selectedItemColor: colorScheme.primaryContainer,
              selectedLabelStyle: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              showUnselectedLabels: true,
              onTap: (index) {},
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                  icon: Icon(Icons.card_giftcard),
                  label: 'Rewards',
                ),
                BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: 'QR'),
                BottomNavigationBarItem(
                  icon: Icon(Icons.receipt_long),
                  label: 'Transactions',
                ),
                BottomNavigationBarItem(icon: Icon(Icons.help), label: 'Help'),
              ],
            ),
          ),

          Positioned(
            top: -18,
            child: SizedBox(
              width: 60,
              height: 60,
              child: Material(
                color: colorScheme.primaryContainer,
                shape: CircleBorder(),
                elevation: 3,
                child: Icon(Icons.qr_code, size: 30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
