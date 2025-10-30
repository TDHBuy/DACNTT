import 'package:booking/models/bookings_model.dart' show BookingModel, BookingStatus, BookingSource;

class MockBookings {
  static List<BookingModel> getBookings() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    return [
      // 1. Booking có note quan trọng - Dị ứng
      BookingModel(
        id: 'BK001',
        customerName: 'Nguyễn Văn A',
        phoneNumber: '0901234567',
        bookingDate: today,
        bookingTime: '19:00',
        numberOfGuests: 4,
        tableId: 'T05',
        note: 'Dị ứng hải sản, cần bàn yên tĩnh gần cửa sổ',
        status: BookingStatus.pending,
        source: BookingSource.web,
        createdAt: now.subtract(const Duration(hours: 2)),
      ),

      // 2. Booking thường - Đã xác nhận
      BookingModel(
        id: 'BK002',
        customerName: 'Trần Thị B',
        phoneNumber: '0912345678',
        bookingDate: today,
        bookingTime: '20:00',
        numberOfGuests: 2,
        tableId: 'T12',
        note: null,
        status: BookingStatus.confirmed,
        source: BookingSource.app,
        createdAt: now.subtract(const Duration(hours: 5)),
      ),

      // 3. Booking có note quan trọng - Sinh nhật
      BookingModel(
        id: 'BK003',
        customerName: 'Lê Văn C',
        phoneNumber: '0923456789',
        bookingDate: today,
        bookingTime: '18:30',
        numberOfGuests: 8,
        tableId: null, // Chưa assign bàn
        note: 'Sinh nhật, cần trang trí bàn và bánh kem, có trẻ em',
        status: BookingStatus.pending,
        source: BookingSource.web,
        createdAt: now.subtract(const Duration(hours: 8)),
      ),

      // 4. Booking thường - Hoàn thành
      BookingModel(
        id: 'BK004',
        customerName: 'Phạm Thị D',
        phoneNumber: '0934567890',
        bookingDate: today.subtract(const Duration(days: 1)),
        bookingTime: '19:30',
        numberOfGuests: 3,
        tableId: 'T08',
        note: 'Gần nhà vệ sinh',
        status: BookingStatus.completed,
        source: BookingSource.app,
        createdAt: now.subtract(const Duration(days: 1, hours: 10)),
      ),

      // 5. Booking có note quan trọng - Wheelchair
      BookingModel(
        id: 'BK005',
        customerName: 'Hoàng Văn E',
        phoneNumber: '0945678901',
        bookingDate: today.add(const Duration(days: 1)),
        bookingTime: '12:00',
        numberOfGuests: 4,
        tableId: 'T01',
        note: 'Có người khuyết tật, cần wheelchair access và bàn rộng',
        status: BookingStatus.confirmed,
        source: BookingSource.app,
        createdAt: now.subtract(const Duration(hours: 12)),
      ),

      // 6. Booking đã hủy
      BookingModel(
        id: 'BK006',
        customerName: 'Vũ Thị F',
        phoneNumber: '0956789012',
        bookingDate: today,
        bookingTime: '19:00',
        numberOfGuests: 2,
        tableId: null,
        note: 'Cần bàn riêng tư',
        adminNote: 'Khách gọi hủy vì bận việc đột xuất',
        status: BookingStatus.cancelled,
        source: BookingSource.web,
        createdAt: now.subtract(const Duration(hours: 15)),
      ),

      // 7. Booking VIP
      BookingModel(
        id: 'BK007',
        customerName: 'Đặng Văn G',
        phoneNumber: '0967890123',
        bookingDate: today,
        bookingTime: '20:30',
        numberOfGuests: 6,
        tableId: 'T15',
        note: 'VIP - Khách quen, thích bàn góc, rượu vang đỏ',
        status: BookingStatus.confirmed,
        source: BookingSource.app,
        createdAt: now.subtract(const Duration(hours: 20)),
      ),

      // 8. Booking no-show
      BookingModel(
        id: 'BK008',
        customerName: 'Bùi Thị H',
        phoneNumber: '0978901234',
        bookingDate: today.subtract(const Duration(days: 1)),
        bookingTime: '18:00',
        numberOfGuests: 4,
        tableId: 'T10',
        note: null,
        adminNote: 'Không đến, không báo trước',
        status: BookingStatus.noShow,
        source: BookingSource.web,
        createdAt: now.subtract(const Duration(days: 1, hours: 15)),
      ),

      // 9. Booking nhóm lớn
      BookingModel(
        id: 'BK009',
        customerName: 'Ngô Văn I',
        phoneNumber: '0989012345',
        bookingDate: today.add(const Duration(days: 2)),
        bookingTime: '19:00',
        numberOfGuests: 12,
        tableId: null,
        note: 'Tiệc công ty, cần ghép bàn lớn',
        status: BookingStatus.pending,
        source: BookingSource.app,
        createdAt: now.subtract(const Duration(hours: 3)),
      ),

      // 10. Booking có baby
      BookingModel(
        id: 'BK010',
        customerName: 'Lý Thị K',
        phoneNumber: '0990123456',
        bookingDate: today,
        bookingTime: '17:30',
        numberOfGuests: 3,
        tableId: 'T03',
        note: 'Có em bé 1 tuổi, cần ghế em bé',
        status: BookingStatus.confirmed,
        source: BookingSource.app,
        createdAt: now.subtract(const Duration(hours: 6)),
      ),

      // 11-20: Thêm bookings khác
      BookingModel(
        id: 'BK011',
        customerName: 'Trương Văn L',
        phoneNumber: '0901234568',
        bookingDate: today,
        bookingTime: '21:00',
        numberOfGuests: 2,
        tableId: 'T07',
        note: null,
        status: BookingStatus.pending,
        source: BookingSource.web,
        createdAt: now.subtract(const Duration(hours: 1)),
      ),

      BookingModel(
        id: 'BK012',
        customerName: 'Cao Thị M',
        phoneNumber: '0912345679',
        bookingDate: today.add(const Duration(days: 1)),
        bookingTime: '19:30',
        numberOfGuests: 5,
        tableId: 'T14',
        note: 'Kỷ niệm ngày cưới, cần không gian lãng mạn',
        status: BookingStatus.confirmed,
        source: BookingSource.app,
        createdAt: now.subtract(const Duration(hours: 18)),
      ),

      BookingModel(
        id: 'BK013',
        customerName: 'Phan Văn N',
        phoneNumber: '0923456780',
        bookingDate: today,
        bookingTime: '18:00',
        numberOfGuests: 4,
        tableId: 'T09',
        note: 'Ăn chay, không hành tỏi',
        status: BookingStatus.confirmed,
        source: BookingSource.web,
        createdAt: now.subtract(const Duration(hours: 10)),
      ),

      BookingModel(
        id: 'BK014',
        customerName: 'Võ Thị O',
        phoneNumber: '0934567891',
        bookingDate: today,
        bookingTime: '20:00',
        numberOfGuests: 2,
        tableId: null,
        note: null,
        status: BookingStatus.pending,
        source: BookingSource.app,
        createdAt: now.subtract(const Duration(minutes: 30)),
      ),

      BookingModel(
        id: 'BK015',
        customerName: 'Đinh Văn P',
        phoneNumber: '0945678902',
        bookingDate: today.add(const Duration(days: 3)),
        bookingTime: '19:00',
        numberOfGuests: 10,
        tableId: null,
        note: 'Họp mặt gia đình, cần bàn tròn',
        status: BookingStatus.pending,
        source: BookingSource.app,
        createdAt: now.subtract(const Duration(hours: 4)),
      ),

      BookingModel(
        id: 'BK016',
        customerName: 'Dương Thị Q',
        phoneNumber: '0956789013',
        bookingDate: today.subtract(const Duration(days: 2)),
        bookingTime: '19:30',
        numberOfGuests: 4,
        tableId: 'T11',
        note: null,
        status: BookingStatus.completed,
        source: BookingSource.app,
        createdAt: now.subtract(const Duration(days: 2, hours: 8)),
      ),

      BookingModel(
        id: 'BK017',
        customerName: 'Lâm Văn R',
        phoneNumber: '0967890124',
        bookingDate: today,
        bookingTime: '19:00',
        numberOfGuests: 3,
        tableId: 'T06',
        note: 'Gần cửa, thoáng mát',
        status: BookingStatus.confirmed,
        source: BookingSource.web,
        createdAt: now.subtract(const Duration(hours: 14)),
      ),

      BookingModel(
        id: 'BK018',
        customerName: 'Mai Thị S',
        phoneNumber: '0978901235',
        bookingDate: today.add(const Duration(days: 1)),
        bookingTime: '18:30',
        numberOfGuests: 2,
        tableId: 'T04',
        note: null,
        status: BookingStatus.confirmed,
        source: BookingSource.app,
        createdAt: now.subtract(const Duration(hours: 7)),
      ),

      BookingModel(
        id: 'BK019',
        customerName: 'Hồ Văn T',
        phoneNumber: '0989012346',
        bookingDate: today,
        bookingTime: '21:30',
        numberOfGuests: 4,
        tableId: null,
        note: 'Đến muộn được không?',
        status: BookingStatus.pending,
        source: BookingSource.web,
        createdAt: now.subtract(const Duration(minutes: 45)),
      ),

      BookingModel(
        id: 'BK020',
        customerName: 'Tô Thị U',
        phoneNumber: '0990123457',
        bookingDate: today.add(const Duration(days: 1)),
        bookingTime: '20:30',
        numberOfGuests: 6,
        tableId: 'T13',
        note: 'Có người nước ngoài, cần menu tiếng Anh',
        status: BookingStatus.confirmed,
        source: BookingSource.app,
        createdAt: now.subtract(const Duration(hours: 9)),
      ),
    ];
  }
}
