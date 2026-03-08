import 'package:flutter/material.dart';
import 'total_expense_screen.dart';

class OverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. HEADER: Tiêu đề và Avatar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tổng quan tài chính gia đình",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.blue.shade100,
                  child: Icon(Icons.person, color: Colors.blueAccent), // Thay bằng ảnh thật sau
                ),
              ],
            ),
            SizedBox(height: 25),

            // 2. KHU VỰC THẺ (Scroll ngang)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.none,
              child: Row(
                children: [
                  _buildCard(context: context,title: "Tổng thu nhập", amount: "45.000.000", isBlue: false),
                  SizedBox(width: 15),
                  _buildCard(context: context,title: "Tổng chi tiêu", amount: "12.800.000", isBlue: true), // Thẻ màu xanh nổi bật
                  SizedBox(width: 15),
                  _buildCard(context: context,title: "Ngân sách", amount: "60.000.000", isBlue: false),
                ],
              ),
            ),
            SizedBox(height: 25),

           // 3. CÁC NÚT TIỆN ÍCH TÍCH LŨY, NHẮC NHỞ...
            SingleChildScrollView(
              scrollDirection: Axis.horizontal, // Phép thuật nằm ở dòng này: cho phép cuộn ngang
              clipBehavior: Clip.none,
              child: Row(
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      elevation: 0,
                    ),
                    onPressed: () {},
                    icon: Icon(Icons.add, size: 18),
                    label: Text("Tích lũy"),
                  ),
                  SizedBox(width: 10),
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      side: BorderSide(color: Colors.grey.shade300),
                    ),
                    onPressed: () {},
                    icon: Icon(Icons.notifications_outlined, size: 18, color: Colors.black87),
                    label: Text("Nhắc nhở", style: TextStyle(color: Colors.black87)),
                  ),
                  SizedBox(width: 10),
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      side: BorderSide(color: Colors.grey.shade300),
                    ),
                    onPressed: () {},
                    icon: Icon(Icons.account_balance_wallet_outlined, size: 18, color: Colors.black87),
                    label: Text("Ngân sách", style: TextStyle(color: Colors.black87)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            // 4. LỊCH SỬ GIAO DỊCH GẦN ĐÂY
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Giao dịch gần đây", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                IconButton(
                  icon: Icon(Icons.more_horiz, color: Colors.grey),
                  onPressed: () {},
                )
              ],
            ),
            SizedBox(height: 10),

            // Danh sách các giao dịch (Tạm thời là dữ liệu tĩnh giống Figma)
            _buildTransactionItem(
              icon: Icons.fastfood,
              title: "Ăn uống",
              desc: "Nội dung: Siêu thị WinMart\n06/03/2026",
              amount: "1.255.000đ",
              method: "MoMo (OCR)",
            ),
            _buildTransactionItem(
              icon: Icons.directions_bike,
              title: "Di chuyển",
              desc: "Nội dung: Chuyến xe Xanh SM\n05/03/2026",
              amount: "85.000đ",
              method: "Cash",
            ),
            _buildTransactionItem(
              icon: Icons.shopping_bag,
              title: "Shopping",
              desc: "Nội dung: Mua sắm Shopee\n01/03/2026",
              amount: "450.000đ",
              method: "ShopeePay",
            ),
            
            SizedBox(height: 80), // Chừa một khoảng trống ở đáy để không bị thanh Điều hướng che mất
          ],
        ),
      ),
    );
  }

  // --- HÀM TẠO THẺ TIỀN ---
  Widget _buildCard({required BuildContext context, required String title, required String amount, required bool isBlue}) {
    return GestureDetector(
      onTap: () {
        // Nếu là thẻ màu xanh (Tổng chi tiêu) thì cho phép chuyển trang
        if (isBlue) {
           Navigator.push(
             context, 
             MaterialPageRoute(builder: (context) => TotalExpenseScreen())
           );
        }
      },
      child: Container(
        width: 150,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: isBlue ? LinearGradient(colors: [Colors.blue.shade400, Colors.blue.shade700]) : null,
          color: isBlue ? null : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.grey.shade200, blurRadius: 10, offset: Offset(0, 5)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.account_balance_wallet, color: isBlue ? Colors.white : Colors.black87),
            SizedBox(height: 10),
            Text(title, style: TextStyle(color: isBlue ? Colors.white70 : Colors.grey, fontSize: 13)),
            SizedBox(height: 5),
            Text("$amount\nVND", style: TextStyle(color: isBlue ? Colors.white : Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
  // --- HÀM TẠO DÒNG LỊCH SỬ GIAO DỊCH ---
  Widget _buildTransactionItem({required IconData icon, required String title, required String desc, required String amount, required String method}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Căn lên trên cùng vì text mô tả hơi dài
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(15)),
            child: Icon(icon, color: Colors.black87),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                SizedBox(height: 4),
                Text(desc, style: TextStyle(color: Colors.grey.shade600, fontSize: 13, height: 1.4)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(amount, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              SizedBox(height: 4),
              Text(method, style: TextStyle(color: Colors.grey.shade500, fontSize: 13)),
            ],
          ),
        ],
      ),
    );
  }
}