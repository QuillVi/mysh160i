import 'package:mymotorcycle/features/mycar/domain/entities/my_car_info.dart';
import 'package:mymotorcycle/features/mycar/domain/repositories/my_car_repository.dart';

class MyCarRepositoryImpl implements MyCarRepository {
  @override
  MyCarInfo getMyCarInfo() {
    return const MyCarInfo(
      greeting: 'Hello, Shinn',
      kicker: 'MY GARAGE',
      modelName: 'SH 160i',
      statusText: 'Ready to drive',
      batteryPercent: 80,
      weather: 'Sunny',
      temperatureC: 28,
      sections: [
        MyCarSection(
          title: 'Tổng quan & phiên bản',
          subtitle: 'SH 160i 2026 — 4 phiên bản tại Việt Nam',
          stats: [
            MyCarStat(
              label: 'Dòng xe / năm',
              value: 'Honda SH 160i — phiên bản 2026 (VN)',
            ),
            MyCarStat(
              label: 'Phân hạng phiên bản',
              value:
                  'Tiêu chuẩn (CBS) • Cao cấp (ABS) • Đặc biệt • Thể thao',
            ),
            MyCarStat(
              label: 'Tiêu chuẩn khí thải',
              value: 'EURO 3 (công bố thị trường VN)',
            ),
          ],
        ),
        MyCarSection(
          title: 'Động cơ & nhiên liệu',
          subtitle: 'eSP+ 156,9 cc • 12,4 kW • tiêu hao 2,34 l/100 km',
          stats: [
            MyCarStat(
              label: 'Động cơ',
              value:
                  'eSP+ 4 van, 4 kỳ, 1 xy-lanh, PGM-FI, làm mát bằng dung dịch',
            ),
            MyCarStat(
              label: 'Dung tích xy-lanh',
              value: '156,9 cm³',
            ),
            MyCarStat(
              label: 'Đường kính × hành trình pít-tông',
              value: '60,0 × 55,5 mm',
            ),
            MyCarStat(
              label: 'Tỷ số nén',
              value: '12,0 : 1',
            ),
            MyCarStat(
              label: 'Công suất tối đa',
              value: '12,4 kW @ 8.500 vòng/phút',
            ),
            MyCarStat(
              label: 'Mô-men xoắn cực đại',
              value: '14,8 Nm @ 6.500 vòng/phút',
            ),
            MyCarStat(
              label: 'Hộp số / truyền động',
              value: 'Vô cấp, điều khiển tự động; khởi động điện',
            ),
            MyCarStat(
              label: 'Mức tiêu hao nhiên liệu (công bố)',
              value: '2,34 lít / 100 km (điều kiện chuẩn)',
            ),
            MyCarStat(
              label: 'Dung tích bình xăng',
              value: '7 lít',
            ),
            MyCarStat(
              label: 'Dung tích nhớt máy',
              value: '0,8 lít (thay nhớt) • ~0,9 lít (rã máy)',
            ),
          ],
        ),
        MyCarSection(
          title: 'Kích thước & trọng lượng',
          subtitle: '2.090 mm dài • yên 799 mm • cốp 28 lít',
          stats: [
            MyCarStat(
              label: 'Khối lượng bản thân',
              value: '133 kg (CBS) • 134 kg (ABS)',
            ),
            MyCarStat(
              label: 'Dài × Rộng × Cao',
              value: '2.090 × 739 × 1.129 mm',
            ),
            MyCarStat(
              label: 'Chiều cao yên',
              value: '799 mm',
            ),
            MyCarStat(
              label: 'Khoảng sáng gầm',
              value: '146 mm',
            ),
            MyCarStat(
              label: 'Cơ sở bánh xe',
              value: '1.353 mm',
            ),
            MyCarStat(
              label: 'Cốp dưới yên',
              value: '28 lít (+ hộc đồ phía trước tiện dụng)',
            ),
          ],
        ),
        MyCarSection(
          title: 'Phanh, treo & bánh xe',
          subtitle: 'ABS/CBS • HSTC • lốp 16 inch',
          stats: [
            MyCarStat(
              label: 'Lốp trước / sau',
              value: '100/80-16 • 120/80-16',
            ),
            MyCarStat(
              label: 'Phanh',
              value:
                  'Đĩa trước & sau; ABS (bản cao cấp trở lên) / CBS (tiêu chuẩn)',
            ),
            MyCarStat(
              label: 'HSTC (kiểm soát lực kéo)',
              value: 'Có trên các phiên bản trang bị ABS',
            ),
            MyCarStat(
              label: 'Phuộc trước / sau',
              value: 'Ống lồng thủy lực • Lò xo trụ giảm chấn thủy lực',
            ),
            MyCarStat(
              label: 'Khung sườn',
              value: 'eSAF (nhẹ, cứng)',
            ),
          ],
        ),
        MyCarSection(
          title: 'Trang bị & công nghệ',
          subtitle: 'TFT 4,2" • Smart Key • USB-C • My Honda+',
          stats: [
            MyCarStat(
              label: 'Hệ thống đèn',
              value: 'LED toàn phần; đèn định vị ban ngày (DRL)',
            ),
            MyCarStat(
              label: 'Đồng hồ & kết nối',
              value: 'TFT 4,2"; Bluetooth • ứng dụng My Honda+',
            ),
            MyCarStat(
              label: 'Tiện ích điện',
              value: 'Cổng sạc USB-C; Smart Key',
            ),
          ],
        ),
      ],
    );
  }
}
