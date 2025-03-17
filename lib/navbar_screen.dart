import 'package:flutter/material.dart';

class NavbarScreen extends StatefulWidget {
  final Widget child;

  const NavbarScreen({Key? key, required this.child}) : super(key: key);

  @override
  State<NavbarScreen> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 🔹 HEADER
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello! Good Evening,',
                        style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Abimana.',
                        style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/news_banner.png'),
                  ),
                ],
              ),
            ),

            // 🔹 CONTENT
            Expanded(child: widget.child),
          ],
        ),
      ),

      // 🔹 FOOTER (BOTTOM NAVBAR)
      bottomNavigationBar: Container(
        height: 70,
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
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavItem(0, Icons.home, 'Home Page'),
              const SizedBox(width: 80), // Spacer untuk tombol tengah
              _buildNavItem(2, Icons.person, 'Profil'),
            ],
          ),
        ),
      ),

      // 🔹 Tombol Tengah Floating
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildCreditProgressItem(),
    );
  }

  // 🔹 WIDGET NAVIGATION ITEM (Home & Profil)
  Widget _buildNavItem(int index, IconData icon, String label) {
    final bool isSelected = _selectedIndex == index;

    return InkWell(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isSelected ? Colors.blue : Colors.black, size: 28),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? Colors.blue : Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

 // 🔹 WIDGET TOMBOL TENGAH (CREDIT PROGRESS)
Widget _buildCreditProgressItem() {
  final bool isSelected = _selectedIndex == 1;

  return SizedBox(
    width: 90, // Ukuran circle diperbesar
    height: 80,
    child: FloatingActionButton(
      onPressed: () => _onItemTapped(1),
      backgroundColor: Colors.white,
      elevation: 5,
      shape: const CircleBorder(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.cloud_upload, color: isSelected ? Colors.blue : Colors.black, size: 28),
          const SizedBox(height: 2), // Sedikit jarak
          SizedBox(
            width: 50, // Lebar teks dibatasi agar tetap di dalam circle
            child: const FittedBox(
              fit: BoxFit.scaleDown, // Supaya teks menyesuaikan ukuran lingkaran
              child: Text(
                'Credit\nProgress', // Teks dibuat vertikal
                style: TextStyle(fontSize: 10, color: Colors.black, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
                maxLines: 2, // Biar nggak keluar dari lingkaran
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
  }
