import 'dart:convert';

class HoaDon {
  final double tongTien;
  final String ngayMua;
  final String danhMucGoiY;
  final String ghiChu;

  HoaDon({
    required this.tongTien,
    required this.ngayMua,
    required this.danhMucGoiY,
    required this.ghiChu,
  });

  // Chuyển từ JSON (Map) sang Object HoaDon
  factory HoaDon.fromJson(Map<String, dynamic> json) {
    return HoaDon(
      // Ép kiểu num để xử lý cả số nguyên và số thực từ API
      tongTien: (json['tong_tien'] as num).toDouble(),
      ngayMua: json['ngay_mua'] ?? '',
      danhMucGoiY: json['danh_muc_goi_y'] ?? '',
      ghiChu: json['ghi_chu'] ?? '',
    );
  }

  // Chuyển từ Object HoaDon ngược lại JSON (nếu cần gửi POST request)
  Map<String, dynamic> toJson() {
    return {
      'tong_tien': tongTien,
      'ngay_mua': ngayMua,
      'danh_muc_goi_y': danhMucGoiY,
      'ghi_chu': ghiChu,
    };
  }
}