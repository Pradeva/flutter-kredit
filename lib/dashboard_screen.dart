import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'navbar_screen.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Map<String, dynamic>? latestTransaction;
  bool isLoading = true;
  String? userId;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

String formatRupiah(String price) {
  double value = double.tryParse(price) ?? 0;
  final formatCurrency = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);
  return formatCurrency.format(value);
}

  Future<void> _loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    String? storedUserId = prefs.getString('user_id');

    if (storedUserId != null) {
      setState(() {
        userId = storedUserId;
      });
      _loadTransactions(storedUserId);
    } else {
      setState(() {
        isLoading = false;
      });
      print("User ID tidak ditemukan di SharedPreferences.");
    }
  }

  Future<void> _loadTransactions(String userId) async {
  final String apiUrl =
      "https://41c0-210-210-144-170.ngrok-free.app/credit-transaction/user/$userId";

  try {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);

      if (data.isNotEmpty) {
        // 🔹 Pastikan data adalah List<Map<String, dynamic>>
        List<Map<String, dynamic>> transactions =
            List<Map<String, dynamic>>.from(data);

        // 🔹 Urutkan berdasarkan ID terbesar
        transactions.sort((a, b) => b['id'].compareTo(a['id']));

        // 🔹 Ambil transaksi dengan ID terbesar (terbaru)
        int highestId = transactions.first['id'];
        print("ID transaksi terbesar: $highestId"); // 🔥 Console log

        setState(() {
          latestTransaction = transactions.first;
          isLoading = false;
        });
      } else {
        print("Tidak ada transaksi kredit.");
        setState(() {
          latestTransaction = null;
          isLoading = false;
        });
      }
    } else {
      throw Exception("Gagal mengambil data transaksi kredit");
    }
  } catch (e) {
    print("Error: $e");
    setState(() {
      isLoading = false;
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return NavbarScreen(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Status Kredit", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),

            // 🔹 Menampilkan Status Kredit Terbaru
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : latestTransaction == null
                    ? const Center(child: Text("Tidak ada transaksi kredit"))
                    : _buildCreditStatusCard(latestTransaction!),

            const SizedBox(height: 16),

            // 🔹 Menu Cepat
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
                  image: AssetImage("assets/news_banner.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Widget untuk menampilkan status kredit
  Widget _buildCreditStatusCard(Map<String, dynamic> transaction) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [Color(0xFF2E68FF), Color(0xFF85A9FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Status dan Due Date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Status: ${transaction['StatusCreditTransaction']['name']}",
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const Text("Due Date", style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromRGBO(240, 243, 33, 1))),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            "${transaction['Car']['brand']} ${transaction['Car']['model']}",
            style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            formatRupiah(latestTransaction?['Car']['price'] ?? '0'),
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const Align(
            alignment: Alignment.bottomRight,
            child: Text("20-01-2026", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 14)),
          ),
        ],
      ),
    );
  }

  // 🔹 Widget Menu Cepat
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
              width: 120,
              height: 120,
              fit: BoxFit.contain,
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
