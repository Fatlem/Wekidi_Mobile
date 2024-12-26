import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay selama 5 detik sebelum navigasi ke halaman login
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF2A65A), // Light orange for the top (bun color)
              Color(0xFFD76D2E), // Deeper orange for the middle (cheese color)
              Color(0xFF7B3E19), // Brown for the bottom (burger patty color)
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Mengganti Icon dengan Image
              Image.asset(
                'assets/images/Wekidi.png', // Gambar dari assets
                width: 350, // Sesuaikan ukuran gambar
                height: 350,
              ),
              SizedBox(height: 20),
              Text(
                'Welcome to Wekidi くん',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'DynaPuff', // Changed to DynaPuff font
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Mau Makan Yang Udah Pasti Enak Dan Terjangkau? Cuma Ada Di Wekidiくん Tempatnya.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  fontFamily: 'DynaPuff', // Changed to DynaPuff font
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
