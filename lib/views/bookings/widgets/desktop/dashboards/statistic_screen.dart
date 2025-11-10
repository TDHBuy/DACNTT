import 'package:booking/commons/extensions/spacing.dart';
import 'package:booking/models/bookings_model.dart';
import 'package:booking/views/bookings/widgets/controllers/booking_table_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatisticScreen extends GetView<BookingTableController> {
  const StatisticScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: _buildStatusStatistic(),
    );
  }

  Widget _buildStatusStatistic() {
    return Obx(() {
      final statusCount = controller.statusCounts;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: BookingStatus.values.map((status) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: _buildStatusCard(
                    status: status,
                    count: statusCount[status] ?? 0,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      );
    });
  }

  Widget _buildStatusCard({required BookingStatus status, required int count}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: status.backgroundColor.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: status.backgroundColor.withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
      child: Row(
        // mainAxisSize: MainAxisSize.min,
        children: [
          // Icon
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: status.color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(status.icon, size: 15, color: Colors.white),
          ),
          12.widthBox,

          // Status Name
          Expanded(
            child: Text(
              status.displayName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF64748B),
              ),
            ),
          ),
          8.widthBox,
          // Count
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: status.color.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }
}
