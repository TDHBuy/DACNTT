import 'package:booking/models/bookings_model.dart';
import 'package:booking/views/bookings/widgets/controllers/booking_table_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MobileTableRow extends GetView<BookingTableController> {
  final BookingModel booking;
  const MobileTableRow({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final isHovered = ValueNotifier<bool>(false);
    return MouseRegion(
      onExit: (_) => isHovered.value = false,
      onEnter: (_) => isHovered.value = true,
      child: GestureDetector(
        onTap: () => controller.selectBooking(booking),
        child: ValueListenableBuilder(
          valueListenable: isHovered,
          builder: (context, hovered, _) => _buildRow(hovered),
        ),
      ),
    );
  }

  Widget _buildRow(bool isHovered) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: controller.selectedBooking.value == booking
              ? Colors.blue.shade100
              : isHovered
              ? Colors.grey.shade200
              : Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            if (controller.selectedBooking.value == booking || isHovered)
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.3),
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: _buildCell(booking.customerName.toString())),
            Expanded(child: _buildCell(booking.phoneNumber)),
            Expanded(child: _buildDateCell(booking)),
            Expanded(child: _buildStatusCell(booking.status)),
          ],
        ),
      ),
    );
  }

  Widget _buildCell(String label) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Colors.grey[800],
          height: 1.4,
        ),
      ),
    );
  }

  Widget _buildDateCell(BookingModel booking) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.access_time, size: 14, color: Colors.grey[600]),
            const SizedBox(width: 4),
            Text(
              booking.bookingTime,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
            ),
          ],
        ),
        Text(
          booking.formattedDate,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildStatusCell(BookingStatus status) {
    return Text(
      status.displayName,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500, // Bolder text
        color: status.color,
      ),
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
    );
  }
}
