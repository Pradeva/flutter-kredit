import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  bool isPasswordVisible = false;
  bool isEmailValid = false;
  bool isPasswordValid = false;

  void validateInputs() {
    setState(() {
      isEmailValid = RegExp(r"^[\w\.-]+@[\w\.-]+\.\w+$")
          .hasMatch(emailController.text.trim());
      isPasswordValid = passwordController.text.trim().length >= 6;
    });
  }

  Future<void> register() async {
    setState(() {
      isLoading = true;
    });

    final apiUrl = "https://41c0-210-210-144-170.ngrok-free.app/users/register";

    try {
      String rawPhone = phoneController.text.trim();

      // 🔧 Format phone jadi 081xxx (remove +62/62)
      String formattedPhone;
      if (rawPhone.startsWith('+62')) {
        formattedPhone = rawPhone.replaceFirst('+62', '0');
      } else if (rawPhone.startsWith('62')) {
        formattedPhone = rawPhone.replaceFirst('62', '0');
      } else {
        formattedPhone = rawPhone; // Sudah 08xxx
      }

      final requestBody = {
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
        "name": nameController.text.trim(),
        "phone": formattedPhone,  // ✅ Dikirim sebagai 081xxx
        "role": 2,
      };

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );

      setState(() {
        isLoading = false;
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Registrasi Berhasil! Silakan login.")),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } else {
        final errorData = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Gagal: ${errorData['message']}")),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error koneksi: $e")),
      );
    }
  }

  InputDecoration customInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.black87, fontSize: 16),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFF2F80ED), width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    IconButton(
                      icon: const Icon(Icons.arrow_back, size: 28),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Create Account",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      controller: nameController,
                      decoration: customInputDecoration("Name"),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: emailController,
                      onChanged: (_) => validateInputs(),
                      decoration: customInputDecoration("Email"),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    if (!isEmailValid && emailController.text.isNotEmpty)
                      const Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Text(
                          "Your email address is invalid",
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: customInputDecoration("Phone Number"),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: passwordController,
                      obscureText: !isPasswordVisible,
                      onChanged: (_) => validateInputs(),
                      decoration: customInputDecoration("Password").copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.black54,
                          ),
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: (isEmailValid && isPasswordValid && !isLoading)
                            ? register
                            : null,
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (states) {
                              if (states.contains(MaterialState.disabled)) {
                                return const Color(0xFFB2D4FF);
                              }
                              return const Color(0xFF2F80ED);
                            },
                          ),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text("Register", style: TextStyle(fontSize: 16)),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
