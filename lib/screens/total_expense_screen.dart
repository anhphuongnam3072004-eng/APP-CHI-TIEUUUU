import 'package:flutter/material.dart';

class TotalExpenseScreen extends StatefulWidget {
  @override
  _TotalExpenseScreenState createState() => _TotalExpenseScreenState();
}

class _TotalExpenseScreenState extends State<TotalExpenseScreen> {
  // Biến để theo dõi Tab nào đang được chọn
  int _selectedTab = 0; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context), // Nút quay lại
        ),
        title: Text("Tổng chi tiêu", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            
            // 1. THANH CHỌN THÁNG (February - 2026)
           // 1. THANH CHỌN THÁNG VÀ LỊCH
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              decoration: BoxDecoration(color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  // Đây là cái bóng xanh tỏa ra xung quanh (Glow)
                  BoxShadow(
                    color: Colors.blueAccent.withOpacity(0.15), // Màu xanh trong suốt nhẹ
                    blurRadius: 20, // Tăng độ mờ cho bóng tỏa rộng ra
                    spreadRadius: 2, // Làm cho bóng to hơn cái khung một chút
                    offset: Offset(0, 0), // Căn giữa để bóng tỏa đều ra 4 phía y hệt ý bạn
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Hàng trên: Tháng và Mũi tên
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.chevron_left, color: Colors.grey),
                      Text("February - 2026", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Icon(Icons.chevron_right, color: Colors.grey),
                    ],
                  ),
                  SizedBox(height: 20), // Khoảng cách giữa chữ Tháng và số Ngày
                  
                  // Hàng dưới: Lịch các ngày trong tuần
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildDateItem("Mo", "29", isSelected: false, isFaded: true),
                      _buildDateItem("Tu", "30", isSelected: false, isFaded: true),
                      _buildDateItem("We", "1", isSelected: false, isFaded: false),
                      _buildDateItem("Th", "2", isSelected: false, isFaded: false),
                      _buildDateItem("Fri", "3", isSelected: true, isFaded: false), // Nổi bật ngày hiện tại
                      _buildDateItem("Sa", "4", isSelected: false, isFaded: false),
                      _buildDateItem("Su", "5", isSelected: false, isFaded: false),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),

            // 2. BIỂU ĐỒ TRÒN TO (Dùng Container cắt tròn tạo hiệu ứng gradient)
            Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Colors.blue.shade300, Colors.blue.shade700],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(color: Colors.blue.withOpacity(0.3), blurRadius: 20, spreadRadius: 5, offset: Offset(0, 10))
                ],
              ),
              child: Center(
                child: Text(
                  "0\n.00đ", // Chữ 0đ như bạn muốn
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 25),

            // Dòng text nhắc nhở
            Text(
              "Bạn chưa chi tiêu gì\ntrong tháng này",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: Colors.grey.shade700, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 30),

            // 3. HAI NÚT TAB (Chi tiết / Danh mục)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedTab = 0),
                      child: Column(
                        children: [
                          Text("Chi tiết chi tiêu", style: TextStyle(fontWeight: FontWeight.bold, color: _selectedTab == 0 ? Colors.black : Colors.grey)),
                          SizedBox(height: 8),
                          Container(height: 3, color: _selectedTab == 0 ? Colors.blueAccent : Colors.transparent)
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedTab = 1),
                      child: Column(
                        children: [
                          Text("Danh mục chi tiêu", style: TextStyle(fontWeight: FontWeight.bold, color: _selectedTab == 1 ? Colors.black : Colors.grey)),
                          SizedBox(height: 8),
                          Container(height: 3, color: _selectedTab == 1 ? Colors.blueAccent : Colors.transparent)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // 4. DANH SÁCH DỮ LIỆU 0Đ 
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  _buildCategoryItem(Icons.fastfood, "Ăn uống", "0đ"),
                  _buildCategoryItem(Icons.movie_creation, "Giải trí", "0đ"),
                  _buildCategoryItem(Icons.shopping_bag, "Mua sắm", "0đ"),
                  _buildCategoryItem(Icons.directions_car, "Đi lại", "0đ"),
                  _buildCategoryItem(Icons.receipt_long, "Hóa đơn", "0đ"),
                  SizedBox(height: 50), // Cách đáy một chút
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // Hàm tạo từng dòng danh mục (Có sẵn icon của Flutter)
  Widget _buildCategoryItem(IconData icon, String title, String amount) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(15)
            ),
            child: Icon(icon, color: Colors.black87), // <-- Dùng icon tích hợp sẵn đây nè
          ),
          SizedBox(width: 15),
          Expanded(
            child: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
          Text(amount, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blueAccent)),
        ],
      ),
    );
  }
}
// --- HÀM TẠO TỪNG Ô LỊCH NHỎ ---
  Widget _buildDateItem(String day, String date, {required bool isSelected, required bool isFaded}) {
    return Column(
      children: [
        Text(day, style: TextStyle(color: Colors.black87, fontSize: 13, fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            color: isSelected ? Colors.blueAccent : Colors.transparent,
            borderRadius: BorderRadius.circular(10), // Bo tròn y hệt thẻ màu xanh số 3
          ),
          child: Center(
            child: Text(
              date,
              style: TextStyle(
                color: isSelected 
                    ? Colors.white 
                    : (isFaded ? Colors.grey.shade400 : Colors.black87), // Nếu là ngày tháng trước (29, 30) thì làm mờ đi
                fontWeight: FontWeight.bold,
                fontSize: 15
              ),
            ),
          ),
        )
      ],
    );
  }
