import 'package:flutter/animation.dart' show Color;
import 'package:flutter/material.dart' show Colors, Icons, IconData;

enum BookingStatus {
  pending('Chờ xác nhận', 'pending'),
  confirmed('Đã xác nhận', 'confirmed'),
  completed('Hoàn thành', 'completed'),
  cancelled('Đã hủy', 'cancelled'),
  noShow('Không đến', 'no_show');

  final String displayName;
  final String value;

  const BookingStatus(this.displayName, this.value);

  // Icon each states
  Color get color {
    switch (this) {
      case BookingStatus.pending:
        return Colors.orange;
      case BookingStatus.confirmed:
        return Colors.blue;
      case BookingStatus.completed:
        return Colors.green;
      case BookingStatus.cancelled:
        return Colors.red;
      case BookingStatus.noShow:
        return Colors.grey;
    }
  }

  Color get backgroundColor {
    switch (this) {
      case BookingStatus.pending:
        return const Color(0xFFFFF3E0); // Light Orange
      case BookingStatus.confirmed:
        return const Color(0xFFE3F2FD); // Light Blue
      case BookingStatus.completed:
        return const Color(0xFFE8F5E9); // Light Green
      case BookingStatus.cancelled:
        return const Color(0xFFFFEBEE); // Light Red
      case BookingStatus.noShow:
        return const Color(0xFFF5F5F5); // Light Grey
    }
  }

  // Icon each states
  IconData get icon {
    switch (this) {
      case BookingStatus.pending:
        return Icons.schedule;
      case BookingStatus.confirmed:
        return Icons.check_circle;
      case BookingStatus.completed:
        return Icons.done_all;
      case BookingStatus.cancelled:
        return Icons.cancel;
      case BookingStatus.noShow:
        return Icons.person_off;
    }
  }
}

enum BookingSource {
  web, // Website
  app; // Mobile App

  // Icon each states
  IconData get icon {
    switch (this) {
      case BookingSource.web:
        return Icons.language;
      case BookingSource.app:
        return Icons.smartphone;
    }
  }
}

class BookingModel {
  final String id;
  final String customerName;
  final String phoneNumber;
  final DateTime bookingDate;
  final String bookingTime; // Format: "19:00"
  final int numberOfGuests;
  final String? tableId; // null nếu chưa assign
  final String? note; // Ghi chú của khách
  final String? adminNote; // Ghi chú nội bộ (chỉ admin thấy)
  final BookingStatus status;
  final BookingSource source;
  final DateTime createdAt;

  BookingModel({
    required this.id,
    required this.customerName,
    required this.phoneNumber,
    required this.bookingDate,
    required this.bookingTime,
    required this.numberOfGuests,
    this.tableId,
    this.note,
    this.adminNote,
    required this.status,
    required this.source,
    required this.createdAt,
  });

  BookingModel copyWith({
    String? id,
    String? customerName,
    String? phoneNumber,
    DateTime? bookingDate,
    String? bookingTime,
    int? numberOfGuests,
    String? tableId,
    String? note,
    String? adminNote,
    BookingStatus? status,
    BookingSource? source,
    DateTime? createdAt,
  }) {
    return BookingModel(
      id: id ?? this.id,
      customerName: customerName ?? this.customerName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      bookingDate: bookingDate ?? this.bookingDate,
      bookingTime: bookingTime ?? this.bookingTime,
      numberOfGuests: numberOfGuests ?? this.numberOfGuests,
      tableId: tableId ?? this.tableId,
      note: note ?? this.note,
      adminNote: adminNote ?? this.adminNote,
      status: status ?? this.status,
      source: source ?? this.source,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  String get formattedDate {
    return '${bookingDate.day.toString().padLeft(2, '0')}/${bookingDate.month.toString().padLeft(2, '0')}/${bookingDate.year}';
  }

  String get truncatedNote {
    if (note == null || note!.isEmpty) return '—';
    if (note!.length <= 40) return note!;
    return '${note!.substring(0, 37)}...';
  }

  bool get isToday {
    final now = DateTime.now();
    return bookingDate.year == now.year &&
        bookingDate.month == now.month &&
        bookingDate.day == now.day;
  }
}
