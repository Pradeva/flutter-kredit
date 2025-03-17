import 'package:flutter/material.dart';
import 'navbar_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NavbarScreen(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Status Kredit Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
                  colors: [
                    Color(0xFF2E68FF), // Biru lebih tua
                    Color(0xFF85A9FF), // Biru lebih muda
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Status :", style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold)),
                      Text("Due Date", style: TextStyle(color: Color.fromRGBO(240, 243, 33, 1))),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text("In Progress", style: TextStyle(color: Color.fromARGB(255, 255, 255, 44), fontSize: 16)),
                  const Text("Honda Brio", style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 14, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text(
                    "Rp. 320.000.000",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                  const Align(
                    alignment: Alignment.bottomRight,
                    child: Text("20-01-2026", style: TextStyle(color: Color.fromARGB(255, 255, 255, 255),fontSize: 14)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 🔹 Menu Cepat dengan Gambar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildQuickMenu("assets/calculate_credit.png", "Calculate Credit"),
                _buildQuickMenu("assets/history_credit.png", "History Credit"),
              ],
            ),
            const SizedBox(height: 16),

            // 🔹 News Section
            const Text("News", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  image: AssetImage("assets/news_banner.png"), // Ganti dengan gambar lokal
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Widget Menu Cepat (Pakai Gambar)
  Widget _buildQuickMenu(String imagePath, String title) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Image.asset(
              imagePath,
              width: 120, // Ukuran gambar diperbesar
              height: 120, // Ukuran gambar diperbesar
              fit: BoxFit.contain, // Agar gambar tidak terpotong
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
