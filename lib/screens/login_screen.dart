import 'package:flutter/material.dart';
import 'main_layout.dart'; // Gọi bộ khung mới

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Biến dùng để ẩn/hiện mật khẩu (con mắt)
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              
              // Logo
              Image.asset('assets/images/logo_final.png', height: 80),
              SizedBox(height: 40),
              
              // Ô nhập Tên người dùng
              TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person_outline, color: Colors.grey),
                  labelText: 'Tên người dùng',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                  ),
                ),
              ),
              SizedBox(height: 20),
              
              // Ô nhập Mật khẩu
              TextField(
                obscureText: _obscureText,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock_outline, color: Colors.grey),
                  suffixIcon: IconButton(
                    icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility, color: Colors.grey),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                  labelText: 'Mật khẩu',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                  ),
                ),
              ),
              SizedBox(height: 30),
              
              // Nút Đăng nhập
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Bo tròn giống Figma
                    ),
                  ),
                  onPressed: () {
                    // 1. Hiện một cái thông báo nhỏ cho giống app thật
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("🚀 Đăng nhập thành công! Đang vào Sổ Chi Tiêu..."), 
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 1),
                      ),
                    );

                    // 2. Lệnh chuyển thẳng sang màn hình HomeScreen (Quét AI)
                    Future.delayed(Duration(milliseconds: 500), () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MainLayout()),
                      );
                    });
                  },
                  child: Text('ĐĂNG NHẬP', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
              
              // Nút Quên mật khẩu
              TextButton(
                onPressed: () {},
                child: Text('QUÊN MẬT KHẨU', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
              ),
              
              SizedBox(height: 10),
              
              // Đường kẻ "Hoặc"
              Row(
                children: [
                  Expanded(child: Divider(thickness: 1)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10), 
                    child: Text("Hoặc", style: TextStyle(color: Colors.grey))
                  ),
                  Expanded(child: Divider(thickness: 1)),
                ],
              ),
              SizedBox(height: 20),
              
              // Nút Đăng nhập bằng Google
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  side: BorderSide(color: Colors.grey.shade300),
                ),
                icon: Icon(Icons.g_mobiledata, color: Colors.red, size: 36),
                label: Text('TIẾP TỤC GOOGLE', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
                onPressed: () {},
              ),
              SizedBox(height: 15),
              
              // Nút Đăng nhập bằng Apple
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  side: BorderSide(color: Colors.grey.shade300),
                ),
                icon: Icon(Icons.apple, color: Colors.black, size: 28),
                label: Text('TIẾP TỤC APPLE', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
                onPressed: () {},
              ),
              
              SizedBox(height: 40),
              
              // Đoạn Đăng ký
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Bạn chưa có tài khoản? ", style: TextStyle(color: Colors.grey.shade700)),
                  GestureDetector(
                    onTap: () {},
                    child: Text("Đăng ký tại đây", style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}