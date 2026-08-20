import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: 80,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: 80,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: colorScheme.onPrimary, width: 2),
              ),
            ),
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
            top: -16,
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
