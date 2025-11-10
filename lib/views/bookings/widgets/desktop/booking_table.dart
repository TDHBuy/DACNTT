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
                    controller: controller,
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
          Expanded(child: _buildHeaderCell('Code')),
          16.widthBox,
          Expanded(child: _buildHeaderCell('Customer')),
          16.widthBox,
          Expanded(child: _buildHeaderCell('Contact')),
          16.widthBox,
          Expanded(child: _buildSortHeaderCell('Date')),
          16.widthBox,
          Expanded(child: _buildHeaderCell('Size', center: true)),
          16.widthBox,
          // _buildHeaderCell('Table', 80),
          // 16.widthBox,
          Expanded(child: _buildHeaderCell('Note', center: true)),
          16.widthBox,
          Expanded(child: _buildHeaderCell('Status', center: true)),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(String title, {bool center = false}) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Color(0xF0FFFFFF),
      ),
      textAlign: center ? TextAlign.center : TextAlign.start,
    );
  }

  Widget _buildSortHeaderCell(String title) {
    return InkWell(
      onTap: () => controller.toggleDateSort(),
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Obx(() {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xF0FFFFFF),
                ),
              ),
              4.widthBox,
              Icon(
                controller.dateAscending.value
                    ? Icons.arrow_drop_up
                    : Icons.arrow_drop_down,
                size: 16,
                color: const Color(0xF0FFFFFF),
              ),
            ],
          );
        }),
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
