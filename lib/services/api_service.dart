import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart'; // <--- Thêm dòng này
import '../models/hoa_don.dart'; // Import cái model bạn vừa làm

class ApiService {
  // LƯU Ý QUAN TRỌNG:
  // Nếu chạy trên máy ảo Android (Emulator) thì phải dùng IP 10.0.2.2
  // Nếu chạy trên điện thoại thật thì phải dùng IP LAN của máy tính (VD: 192.168.1.x)
  static const String baseUrl = 'http://10.0.2.2:8000';

  Future<HoaDon?> uploadHoaDon(String imagePath) async {
    // --- HÀM MỚI: GỬI DỮ LIỆU ĐÃ DUYỆT ĐỂ LƯU VÀO DATABASE ---
  Future<bool> luuChiTieu(HoaDon hoaDon) async {
    try {
      var uri = Uri.parse('$baseUrl/them-chi-tieu');
      
      // Đóng gói dữ liệu thành chuẩn JSON để gửi cho Python
      var response = await http.post(
        uri,
        headers: {"Content-Type": "application/json; charset=UTF-8"},
        body: jsonEncode({
          "tong_tien": hoaDon.tongTien,
          "ngay_mua": hoaDon.ngayMua,
          "danh_muc": hoaDon.danhMucGoiY,
          "ghi_chu": hoaDon.ghiChu,
        }),
      );

      if (response.statusCode == 200) {
        print("--> Đã lưu vào DB thành công: ${response.body}");
        return true; // Trả về true nếu thành công
      } else {
        print("--> Lỗi khi lưu: ${response.statusCode} - ${response.body}");
        return false;
      }
    } catch (e) {
      print("--> Lỗi mạng kết nối: $e");
      return false;
    }
  }
    try {
      var uri = Uri.parse('$baseUrl/doc-hoa-don');
      var request = http.MultipartRequest('POST', uri);
      
      // Đính kèm file ảnh (nhớ import thư viện http_parser)
      request.files.add(await http.MultipartFile.fromPath(
        'file',
        imagePath,
        contentType: MediaType('image', 'jpeg'),
      ));

      print("--> Đang gửi ảnh lên Server...");
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        print("--> Server trả về gốc: ${response.body}");
        
        // BƯỚC 1: Giải mã lớp vỏ ngoài cùng
        // Server trả về: {"ket_qua_ai": "{...}"}
        var outerData = jsonDecode(utf8.decode(response.bodyBytes));
        
        // BƯỚC 2: Kiểm tra xem có lớp vỏ "ket_qua_ai" không
        if (outerData is Map && outerData.containsKey('ket_qua_ai')) {
          print("--> Đang bóc tách dữ liệu...");
          String innerJsonString = outerData['ket_qua_ai'];
          
          // BƯỚC 3: Giải mã cái ruột bên trong
          var realData = jsonDecode(innerJsonString);
          print("--> Dữ liệu thật: $realData");
          
          // QUAN TRỌNG NHẤT: Trả về kết quả NGAY TẠI ĐÂY
          return HoaDon.fromJson(realData);
        } 
        
        // Trường hợp Server không đóng gói 2 lớp (dự phòng)
        return HoaDon.fromJson(outerData);

      } else {
        print("Lỗi Server: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Lỗi kết nối: $e");
      return null;
    }
  }
  }
  
