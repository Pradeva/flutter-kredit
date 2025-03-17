import 'package:flutter/material.dart';
import 'auth_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _sparkleController;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    // Animasi efek sparkling (redup ke terang)
    _sparkleController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(reverse: true);

    _opacityAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _sparkleController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _sparkleController.dispose();
    super.dispose();
  }

  void _navigateToAuthScreen() {
    if (!mounted) return; // Cegah crash jika widget sudah tidak ada

    _sparkleController.stop(); // Hentikan animasi sebelum navigasi

    Future.microtask(() {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AuthScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _opacityAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: _opacityAnimation.value,
                  child: child,
                );
              },
              child: Text(
                "EasyFinance",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade800,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Welcome to EasyFinance!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                "Easily plan your loan and make informed financial decisions with EasyFinance.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _navigateToAuthScreen,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, 
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              ),
              child: Text("Continue", style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
