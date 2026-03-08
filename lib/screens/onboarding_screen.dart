import 'package:flutter/material.dart';
import 'login_screen.dart';
// TODO: Tí nữa nhớ import màn hình Login vào đây để chuyển trang nhé

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  // Dữ liệu 3 màn hình của bạn
  final List<Map<String, String>> onboardingData = [
    {
      "image": "assets/images/ob1.png",
      "title": "Ghi chép lại các khoản chi phí",
      "desc": "Ghi chép chi tiêu hàng ngày để giúp quản lý tiền bạc."
    },
    {
      "image": "assets/images/ob2.png",
      "title": "Quản lý tiền bạc đơn giản",
      "desc": "Nhận thông báo hoặc cảnh báo khi bạn chi tiêu vượt quá mức cho phép."
    },
    {
      "image": "assets/images/ob3.png",
      "title": "Dễ dàng theo dõi và phân tích",
      "desc": "Theo dõi chi tiêu giúp bạn đảm bảo không tiêu xài quá mức."
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20),
            // Logo ở trên cùng
            Image.asset('assets/images/logo.png', height: 80, errorBuilder: (context, error, stackTrace) => Text("IntelFin AI", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
            
            // Khu vực vuốt (PageView)
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (value) {
                  setState(() {
                    _currentPage = value;
                  });
                },
                itemCount: onboardingData.length,
                itemBuilder: (context, index) => OnboardingContent(
                  image: onboardingData[index]["image"]!,
                  title: onboardingData[index]["title"]!,
                  description: onboardingData[index]["desc"]!,
                ),
              ),
            ),

            // Các dấu chấm (Dots Indicator)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onboardingData.length,
                (index) => buildDot(index: index),
              ),
            ),
            SizedBox(height: 30),

            // Nút Bấm "TIẾP THEO"
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent, // Tông màu xanh của bạn
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Nút bo tròn
                    ),
                  ),
                  onPressed: () {
                    if (_currentPage == onboardingData.length - 1) {
                      // Nếu là trang cuối -> Chuyển sang màn hình Đăng Nhập
                      print("Chuyển sang màn hình Auth");
                      Navigator.pushReplacement(
                        context, 
                        MaterialPageRoute(builder: (context) => LoginScreen())
                      );
                    } else {
                      // Bấm tiếp theo -> Chuyển sang trang sau
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    }
                  },
                  child: Text(
                    _currentPage == onboardingData.length - 1 ? "BẮT ĐẦU" : "TIẾP THEO",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // Hàm vẽ dấu chấm
  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: _currentPage == index ? 20 : 6, // Chấm hiện tại sẽ dài ra
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.blueAccent : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

// Giao diện của từng trang
class OnboardingContent extends StatelessWidget {
  final String image, title, description;

  const OnboardingContent({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spacer(),
        Image.asset(
          image,
          height: 250, // Cỡ ảnh minh họa
          // Nếu quên chưa bỏ ảnh vào thì nó hiện cục gạch xám để báo lỗi
          errorBuilder: (context, error, stackTrace) => Container(height: 250, width: 250, color: Colors.grey),
        ),
        Spacer(),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              height: 1.5,
            ),
          ),
        ),
        Spacer(),
      ],
    );
  }
}