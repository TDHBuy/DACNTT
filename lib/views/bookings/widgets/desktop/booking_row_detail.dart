import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../models/bookings_model.dart';

class BookingRowDetail extends StatelessWidget {
  const BookingRowDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final BookingModel booking = Get.arguments as BookingModel;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Light gray background
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF1E293B), // Dark blue slate
        title: Text(
          'Booking Detail - ${booking.id}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Main information card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow('Code', booking.id, canCopy: true),
                    _buildDivider(),
                    _buildDetailRow('Customer', booking.customerName),
                    _buildDivider(),
                    _buildDetailRow(
                      'Contact',
                      booking.phoneNumber,
                      canCopy: true,
                    ),
                    _buildDivider(),
                    _buildDetailRow('Date', booking.formattedDate.toString()),
                    _buildDivider(),
                    _buildDetailRow(
                      'Party Size',
                      booking.numberOfGuests.toString(),
                    ),
                    _buildDivider(),
                    _buildDetailRow(
                      'Table',
                      booking.tableId ?? 'Not yet arranged',
                    ),
                    _buildDivider(),
                    _buildDetailRow(
                      'Status',
                      booking.status.displayName,
                      isStatus: true,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Notes card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Notes:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F9FA),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Text(
                        booking.note ?? 'No notes',
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.5,
                          color: booking.note != null
                              ? const Color(0xFF475569)
                              : const Color(0xFF94A3B8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build a detail row with label and value
  ///
  /// Parameters:
  /// - [label]: The field label (e.g., "Code", "Customer")
  /// - [value]: The field value
  /// - [canCopy]: Whether to show copy button (default: false)
  /// - [isStatus]: Whether this is a status field with colored chip (default: false)
  Widget _buildDetailRow(
    String label,
    String value, {
    bool canCopy = false,
    bool isStatus = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0), // Increased padding
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label section
          SizedBox(
            width: 100, // Reduced from 120 to 100
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Color(0xFF64748B), // Medium gray
              ),
            ),
          ),

          // Value section
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: isStatus
                      ? _buildStatusChip(value)
                      : Text(
                          value,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF1E293B), // Dark text
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                ),

                // Copy button - closer to text
                if (canCopy) ...[
                  const SizedBox(width: 8), // Reduced from 12 to 8
                  InkWell(
                    onTap: () {
                      // Copy to clipboard
                      Clipboard.setData(ClipboardData(text: value));

                      // Show success snackbar
                      Get.snackbar(
                        'Copied',
                        '$label copied to clipboard',
                        snackPosition: SnackPosition.BOTTOM,
                        duration: const Duration(seconds: 2),
                        backgroundColor: const Color(0xFF10B981), // Green
                        colorText: Colors.white,
                        margin: const EdgeInsets.all(16),
                        borderRadius: 8,
                        icon: const Icon(
                          Icons.check_circle,
                          color: Colors.white,
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                      padding: const EdgeInsets.all(6), // Reduced padding
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: const Icon(
                        Icons.copy,
                        size: 16, // Reduced size
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build a colored status chip based on booking status
  ///
  /// Status colors:
  /// - Confirmed: Green
  /// - Pending: Yellow/Orange
  /// - Cancelled: Red
  /// - Completed: Blue
  /// - Default: Gray
  Widget _buildStatusChip(String status) {
    Color backgroundColor;
    Color textColor;

    // Determine colors based on status
    switch (status.toLowerCase()) {
      case 'confirmed':
        backgroundColor = const Color(0xFFDCFCE7); // Light green
        textColor = const Color(0xFF166534); // Dark green
        break;
      case 'pending':
        backgroundColor = const Color(0xFFFEF3C7); // Light yellow
        textColor = const Color(0xFF92400E); // Dark yellow
        break;
      case 'cancelled':
        backgroundColor = const Color(0xFFFEE2E2); // Light red
        textColor = const Color(0xFF991B1B); // Dark red
        break;
      case 'completed':
        backgroundColor = const Color(0xFFDDEAFE); // Light blue
        textColor = const Color(0xFF1E40AF); // Dark blue
        break;
      default:
        backgroundColor = const Color(0xFFF1F5F9); // Light gray
        textColor = const Color(0xFF475569); // Dark gray
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }

  /// Build a divider line between detail rows
  Widget _buildDivider() {
    return const Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9));
  }
}
