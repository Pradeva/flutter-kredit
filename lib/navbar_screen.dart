import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'profile_screen.dart';

class NavbarScreen extends StatefulWidget {
  final Widget child;

  const NavbarScreen({super.key, required this.child});

  @override
  State<NavbarScreen> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen> {
  int _selectedIndex = 0;
  String? userName;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('user_id');

    if (userId != null) {
      await _fetchUserName(userId);
    }
  }

  Future<void> _fetchUserName(String userId) async {
    final String userApiUrl = "https://41c0-210-210-144-170.ngrok-free.app/users/$userId";

    try {
      final response = await http.get(Uri.parse(userApiUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          userName = data['name'] ?? "User";
        });
      }
    } catch (e) {
      print("Error mengambil nama user: $e");
    }
  }

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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hello! Good Evening,',
                        style: TextStyle(fontSize: 23,  fontFamily: 'Montserrat',  fontWeight: FontWeight.bold),
                      ),
                      Text(
                        userName ?? 'Loading...',
                        style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/profile_pic.png'),
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
          padding: const EdgeInsets.symmetric(horizontal: 45.0), // **Kurangi jarak antar item**
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavItem(0, 'assets/home.png', 'Home Page'),
              _buildNavItem(2, 'assets/profile.png', 'Profil'),
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
  Widget _buildNavItem(int index, String imagePath, String label) {
    final bool isSelected = _selectedIndex == index;

    return InkWell(
    onTap: () {
      if (index == 2) {
        // Jika tombol "Profil" ditekan, navigasikan ke ProfileScreen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
      } else {
        // Jika tombol lain, ubah index untuk perubahan warna
        setState(() {
          _selectedIndex = index;
        });
      }
    },
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

  // 🔹 WIDGET TOMBOL TENGAH (CREDIT PROGRESS) **DENGAN TEKS DI DALAM CIRCLE**
  Widget _buildCreditProgressItem() {
    return SizedBox(
      width: 85, // **Lebarkan circle agar seimbang**
      height: 85,
      child: FloatingActionButton(
        onPressed: () => _onItemTapped(1),
        backgroundColor: Colors.white,
        elevation: 5,
        shape: const CircleBorder(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/credit.png',
              width: 30,
              height: 30,
            ),
            const SizedBox(height: 2),
            const Text(
              'Credit\nProgress',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
