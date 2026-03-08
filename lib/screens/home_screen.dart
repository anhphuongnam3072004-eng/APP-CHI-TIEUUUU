import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/hoa_don.dart';
import '../services/api_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? _image; // Biến chứa ảnh đã chọn
  HoaDon? _hoaDon; // Biến chứa dữ liệu hóa đơn trả về
  bool _isLoading = false; // Biến để hiện vòng tròn xoay xoay

  final picker = ImagePicker();
  final apiService = ApiService();

  // Hàm chọn ảnh từ Gallery hoặc Camera
  Future _pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _hoaDon = null; // Reset kết quả cũ
      });
      // Chọn ảnh xong thì tự động gửi lên Server luôn
      _uploadAndScan();
    }
  }

  // Hàm gọi API
  Future _uploadAndScan() async {
    if (_image == null) return;

    setState(() {
      _isLoading = true; // Bắt đầu xoay vòng tròn
    });

    // Gọi cái xe vận chuyển (Service) hoạt động
    final result = await apiService.uploadHoaDon(_image!.path);

    setState(() {
      _hoaDon = result; // Lưu kết quả vào biến
      _isLoading = false; // Tắt vòng tròn
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quét Hóa Đơn AI")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Khu vực hiển thị ảnh
              Container(
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: _image == null
                    ? Center(child: Text("Chưa có ảnh nào"))
                    : Image.file(_image!, fit: BoxFit.cover),
              ),
              SizedBox(height: 20),

              // 2. Hai nút bấm
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _pickImage(ImageSource.camera),
                    icon: Icon(Icons.camera_alt),
                    label: Text("Chụp ảnh"),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => _pickImage(ImageSource.gallery),
                    icon: Icon(Icons.photo),
                    label: Text("Chọn thư viện"),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // 3. Vòng tròn chờ (Loading)
              if (_isLoading)
                Center(child: CircularProgressIndicator())
              
              // 4. Khu vực hiển thị kết quả (Nếu đã có data)
              else if (_hoaDon != null)
                Card(
                  color: Colors.green.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("KẾT QUẢ TỪ AI:", 
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        Divider(),
                        Text("💰 Tổng tiền: ${_hoaDon!.tongTien} VNĐ", 
                            style: TextStyle(fontSize: 16, color: Colors.red)),
                        SizedBox(height: 8),
                        Text("📅 Ngày mua: ${_hoaDon!.ngayMua}", 
                            style: TextStyle(fontSize: 16)),
                        SizedBox(height: 8),
                        Text("📂 Danh mục: ${_hoaDon!.danhMucGoiY}", 
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        Text("📝 Ghi chú: ${_hoaDon!.ghiChu}"),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}