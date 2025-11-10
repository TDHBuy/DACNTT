import 'package:booking/commons/extensions/spacing.dart';
import 'package:booking/views/bookings/widgets/controllers/booking_table_controller.dart';
import 'package:booking/views/bookings/widgets/mobile/table/rows/mobile_table_row.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../desktop/booking_table_rows.dart';

class MobileTable extends GetView<BookingTableController> {
  const MobileTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Column(children: [_buildTableHeader(), _buildTable()]),
    );
  }

  Widget _buildTable() {
    return Expanded(
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
            return MobileTableRow(key: ValueKey(booking.id), booking: booking);
          },
        );
      }),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      height: 40,
      decoration: const BoxDecoration(
        color: Color(0xFF5697C6),
        border: Border(bottom: BorderSide(color: Color(0xFF334155), width: 1)),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Row(
        children: [
          Expanded(child: _buildHeaderCell('Customer')),
          Expanded(child: _buildHeaderCell('Contact')),
          Expanded(child: _buildSortHeaderCell('Date')),
          Expanded(child: _buildHeaderCell('Status')),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(String title) {
    return Center(
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Color(0xF0FFFFFF),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildSortHeaderCell(String title) {
    return Center(
      child: InkWell(
        onTap: () => controller.toggleDateSort(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          child: Obx(() {
            return Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xF0FFFFFF),
                  ),
                ),
                7.widthBox,
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
