import 'package:flutter/material.dart';

class FooterScreen extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const FooterScreen({super.key, required this.selectedIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 75,
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildNavItem(0, 'assets/home.png', 'Home Page'),
                  const SizedBox(width: 85), // Spacer untuk posisi tengah
                  _buildNavItem(2, 'assets/profile.png', 'Profil'),
                ],
              ),
            ),
          ),
          Positioned(
            top: -40, // Naikkan tombol tengah di atas footer
            left: MediaQuery.of(context).size.width / 2 - 42.5, // Pusatkan tombol tengah
            child: _buildCreditProgressItem(),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, String imagePath, String label) {
    final bool isSelected = selectedIndex == index;

    return InkWell(
      onTap: () => onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            imagePath,
            width: 30,
            height: 30,
            color: isSelected ? Colors.blue : Colors.black,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: isSelected ? Colors.blue : Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreditProgressItem() {
    return SizedBox(
      width: 85,
      height: 85,
      child: FloatingActionButton(
        onPressed: () => onItemTapped(1),
        backgroundColor: Colors.white,
        elevation: 5,
        shape: const CircleBorder(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/credit.png', width: 30, height: 30),
            const SizedBox(height: 2),
            const Text(
              'Credit\nProgress',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
