import 'package:booking/views/bookings/widgets/controllers/booking_table_controller.dart';
import 'package:booking/views/bookings/widgets/desktop/booking_table_rows.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingTable extends GetView<BookingTableController> {
  const BookingTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Column(
        children: [
          _buildTableHeader(),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value == true) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.bookings.isEmpty) {
                return _buildEmptyState();
              }

              return ListView.builder(
                itemCount: controller.bookings.length,
                itemBuilder: (context, index) {
                  final booking = controller.bookings[index];
                  return BookingTableRow(
                    booking: booking,
                    onTap: () => controller.selectBooking(booking),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      height: 48,
      decoration: const BoxDecoration(
        color: Color(0xFF5697C6),
        border: Border(bottom: BorderSide(color: Color(0xFF334155), width: 2)),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _buildHeaderCell('Code', 80),
          16.widthBox,
          _buildHeaderCell('Customer', 160),
          16.widthBox,
          _buildHeaderCell('Contact', 140),
          16.widthBox,
          _buildHeaderCell('Date', 140),
          16.widthBox,
          _buildHeaderCell('Size', 80),
          16.widthBox,
          // _buildHeaderCell('Table', 80),
          // 16.widthBox,
          const Expanded(
            child: Text(
              'Note',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xF0FFFFFF),
              ),
            ),
          ),
          16.widthBox,
          _buildHeaderCell('Status', 140),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(String title, double width) {
    return SizedBox(
      width: width,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xF0FFFFFF),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox_outlined, size: 64, color: Colors.grey[400]),
          16.heightBox,
          Text(
            'No booking',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          24.heightBox,
          ElevatedButton.icon(
            onPressed: () => Get.toNamed('/add-booking'),
            icon: const Icon(Icons.add),
            label: const Text('Add Booking'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            ),
          ),
        ],
      ),
    );
  }
}

extension SizedBoxExtension on int {
  Widget get heightBox => SizedBox(height: toDouble());
  Widget get widthBox => SizedBox(width: toDouble());
}
