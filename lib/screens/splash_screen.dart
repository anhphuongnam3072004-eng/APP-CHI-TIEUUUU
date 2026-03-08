import 'package:flutter/material.dart';
import 'dart:async'; // Dùng để đếm thời gian
import 'onboarding_screen.dart'; // Import màn hình Onboarding để chuyển tới

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Cài đặt đồng hồ đếm ngược 2.5 giây rồi tự động chuyển trang
    Timer(Duration(milliseconds: 2500), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        // CHỈNH SIZE LOGO TO Ở ĐÂY (width: 250)
        child: Image.asset(
          'assets/images/logo_final.png',
          width: 250, 
          errorBuilder: (context, error, stackTrace) => 
            Text("IntelFin AI", style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.blue)),
        ),
      ),
    );
  }
}