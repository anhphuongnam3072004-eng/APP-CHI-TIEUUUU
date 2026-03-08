import 'package:flutter/material.dart';
import 'overview_screen.dart';

class MainLayout extends StatefulWidget {
  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  // Tạm thời các trang con là màn hình trống có chữ, chúng ta sẽ đắp UI thật vào sau
  final List<Widget> _pages = [
  OverviewScreen(), // <--- Ốp màn hình vừa code vào đây
  Center(child: Text('Trang Tích lũy/Lịch sử', style: TextStyle(fontSize: 20))),
  Center(child: Text('Trang Thông báo', style: TextStyle(fontSize: 20))),
  Center(child: Text('Trang Cài đặt', style: TextStyle(fontSize: 20))),
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100, // Nền xám nhẹ làm nổi bật các Card trắng
      
      // Hiển thị phần thân tương ứng với nút bấm ở đáy
      body: _pages[_currentIndex], 

      // 1. NÚT (+) TO ĐÙNG Ở GIỮA
      floatingActionButton: Container(
        height: 65,
        width: 65,
        child: FloatingActionButton(
          backgroundColor: Colors.blueAccent, // Màu xanh của bạn
          shape: CircleBorder(), // Nút hình tròn
          elevation: 5,
          onPressed: () {
            // TODO: Gắn tính năng gọi AI Quét Hóa Đơn vào đây
            print("Đã bấm nút Cộng!");
          },
          child: Icon(Icons.add, size: 35, color: Colors.white),
        ),
      ),
      
      // Để nút nổi lọt thỏm vào giữa thanh điều hướng
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // 2. THANH ĐIỀU HƯỚNG ĐÁY (Bottom Nav)
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(), // Khoét một lỗ tròn ở giữa cho Nút (+)
        notchMargin: 8.0,
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: 65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Cụm 2 nút bên TRÁI
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () => setState(() => _currentIndex = 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.home_filled, color: _currentIndex == 0 ? Colors.blueAccent : Colors.grey),
                        Text('Trang chủ', style: TextStyle(color: _currentIndex == 0 ? Colors.blueAccent : Colors.grey, fontSize: 10)),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () => setState(() => _currentIndex = 1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.receipt_long, color: _currentIndex == 1 ? Colors.blueAccent : Colors.grey),
                        Text('Lịch sử', style: TextStyle(color: _currentIndex == 1 ? Colors.blueAccent : Colors.grey, fontSize: 10)),
                      ],
                    ),
                  ),
                ],
              ),
              
              // Cụm 2 nút bên PHẢI
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () => setState(() => _currentIndex = 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.notifications, color: _currentIndex == 2 ? Colors.blueAccent : Colors.grey),
                        Text('Thông báo', style: TextStyle(color: _currentIndex == 2 ? Colors.blueAccent : Colors.grey, fontSize: 10)),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () => setState(() => _currentIndex = 3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.settings, color: _currentIndex == 3 ? Colors.blueAccent : Colors.grey),
                        Text('Cài đặt', style: TextStyle(color: _currentIndex == 3 ? Colors.blueAccent : Colors.grey, fontSize: 10)),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}