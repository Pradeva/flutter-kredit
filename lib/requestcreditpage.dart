import 'package:flutter/material.dart';

class RequestCreditPage extends StatelessWidget {
  const RequestCreditPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Data Dummy sesuai desain
    final dummyData = {
      "result": "Toyota Innova Zwnix Q",
      "initialPrice": "320.000.000",
      "period": "5 Years",
      "interestRate": "2.46%",
      "totalInterest": "2.276.117",
      "deposit": "98.000.000",
      "loanAmount": "120.000.000",
      "monthlyPayment": "13.560.000"
    };

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Card Box
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: "Result : ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: dummyData["result"],
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildRow("Initial Price", dummyData["initialPrice"]!),
                    _buildRow("Period", dummyData["period"]!),
                    _buildRow("Interest Rate", dummyData["interestRate"]!),
                    _buildRow("Total Interest", dummyData["totalInterest"]!),
                    _buildRow("Deposit", dummyData["deposit"]!),
                    const Divider(height: 24, thickness: 1),
                    _buildRow("Loan Amount", dummyData["loanAmount"]!),
                    const SizedBox(height: 8),
                    _buildRow(
                      "Monthly Payment",
                      dummyData["monthlyPayment"]!,
                      isBold: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Request Credit Button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    showSuccessDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2F80ED),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Request Credit",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk baris teks
  Widget _buildRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  // Dialog sukses
  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          contentPadding: const EdgeInsets.all(20),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle_outline,
                  color: Color(0xFF27AE60), size: 60),
              const SizedBox(height: 16),
              const Text(
                "The Credit\nApplication Has\nBeen Submitted",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context); // Tutup dialog
                        Navigator.pop(context); // Kembali ke home
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.black),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text("Back to Home",
                          style: TextStyle(color: Colors.black)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // TODO: Navigate ke progress
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Go to Progress Page")),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFDFF2E4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "See Progress",
                        style: TextStyle(
                          color: Color(0xFF27AE60),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
