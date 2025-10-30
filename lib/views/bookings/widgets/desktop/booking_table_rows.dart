import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../models/bookings_model.dart';

class BookingTableRow extends StatefulWidget {
  final BookingModel booking;
  final VoidCallback onTap;

  const BookingTableRow({
    super.key,
    required this.booking,
    required this.onTap,
  });

  @override
  State<BookingTableRow> createState() => _BookingTableRowState();
}

class _BookingTableRowState extends State<BookingTableRow> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(onTap: widget.onTap, child: _buildRow()),
    );
  }

  Widget _buildRow() {
    return Container(
      height: 72,
      decoration: BoxDecoration(
        color: isHovered
            ? const Color(0xFFF8F9FA) // Light gray on hover
            : Colors.white,
        border: const Border(
          bottom: BorderSide(
            color: Color(0xFFE2E8F0),
            width: 1,
          ), // Lighter border
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          _buildCell(80, widget.booking.id),
          const SizedBox(width: 16),
          _buildCell(160, widget.booking.customerName),
          const SizedBox(width: 16),
          _buildContactCell(140),
          const SizedBox(width: 16),
          _buildDateTimeCell(),
          const SizedBox(width: 16),
          _buildGuestsCell(),
          const SizedBox(width: 16),
          // _buildTableCell(80),
          // const SizedBox(width: 16),
          _buildNoteCell(),
          const SizedBox(width: 16),
          _buildStatusCell(),
        ],
      ),
    );
  }

  /// Build a standard cell with text
  Widget _buildCell(double width, String text, {bool centered = true}) {
    return SizedBox(
      width: width,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Color(0xFF1E293B), // Dark slate for better contrast
          height: 1.4,
        ),
        textAlign: centered ? TextAlign.center : TextAlign.start,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  /// Build contact cell with phone number and copy button
  Widget _buildContactCell(double width) {
    return SizedBox(
      width: width,
      child: Row(
        children: [
          Expanded(
            child: Text(
              widget.booking.phoneNumber,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF334155), // Medium dark for readability
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 6), // Reduced from default to bring icon closer
          Tooltip(
            message: 'Copy phone number',
            child: InkWell(
              onTap: () => _copyPhoneNumber(),
              borderRadius: BorderRadius.circular(6),
              child: Container(
                padding: const EdgeInsets.all(6), // Compact padding
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF), // Light blue background
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: const Color(0xFFBFDBFE), // Blue border
                    width: 1,
                  ),
                ),
                child: const Icon(
                  Icons.phone,
                  size: 14, // Slightly smaller icon
                  color: Color(0xFF2563EB), // Vibrant blue
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Copy phone number to clipboard
  void _copyPhoneNumber() {
    Clipboard.setData(ClipboardData(text: widget.booking.phoneNumber));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Text('Phone number copied: ${widget.booking.phoneNumber}'),
          ],
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF10B981), // Green for success
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  /// Build table cell with icon
  Widget _buildTableCell(double width) {
    return SizedBox(
      width: width,
      child: widget.booking.tableId != null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.table_restaurant,
                  size: 16,
                  color: Color(0xFF2563EB), // Blue
                ),
                const SizedBox(width: 4),
                Text(
                  widget.booking.tableId!,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2563EB),
                  ),
                ),
              ],
            )
          : const Text(
              '—',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF94A3B8),
              ), // Light gray
              textAlign: TextAlign.center,
            ),
    );
  }

  /// Build date and time cell with icons
  Widget _buildDateTimeCell() {
    return SizedBox(
      width: 140,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Date row
          Row(
            children: [
              const Icon(
                Icons.calendar_today,
                size: 14,
                color: Color(0xFF64748B), // Medium gray
              ),
              const SizedBox(width: 6),
              Text(
                widget.booking.formattedDate,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF475569), // Dark gray
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          // Time row
          Row(
            children: [
              const Icon(Icons.access_time, size: 14, color: Color(0xFF64748B)),
              const SizedBox(width: 6),
              Text(
                widget.booking.bookingTime,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E293B), // Darker for emphasis
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Build guests cell with icon and highlight for large groups
  Widget _buildGuestsCell() {
    final isLargeGroup = widget.booking.numberOfGuests >= 8;

    return SizedBox(
      width: 80,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isLargeGroup
              ? const Color(0xFFFEF3C7) // Light yellow for large groups
              : const Color(0xFFF1F5F9), // Light gray for normal
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isLargeGroup
                ? const Color(0xFFFBBF24) // Yellow border
                : const Color(0xFFE2E8F0), // Gray border
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.people,
              size: 16,
              color: isLargeGroup
                  ? const Color(0xFFD97706) // Orange for large groups
                  : const Color(0xFF64748B), // Gray for normal
            ),
            const SizedBox(width: 4),
            Text(
              widget.booking.numberOfGuests.toString(),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isLargeGroup
                    ? const Color(0xFFD97706)
                    : const Color(0xFF334155),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build note cell with tooltip for full text
  Widget _buildNoteCell() {
    return Expanded(
      child: widget.booking.note != null && widget.booking.note!.isNotEmpty
          ? Tooltip(
              message: widget.booking.note!,
              preferBelow: false,
              waitDuration: const Duration(milliseconds: 300),
              showDuration: const Duration(seconds: 5),
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B), // Dark slate
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              textStyle: const TextStyle(
                fontSize: 13,
                color: Colors.white,
                height: 1.5,
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF3C7), // Light yellow background
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xFFFBBF24), // Yellow border
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.note,
                      size: 14,
                      color: Color(0xFFD97706), // Orange
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        widget.booking.truncatedNote,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF92400E), // Dark orange
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : const Text(
              '—',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFFCBD5E1),
              ), // Light gray
            ),
    );
  }

  /// Build status cell with colored badge
  Widget _buildStatusCell({double width = 140}) {
    return SizedBox(
      width: width,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: widget.booking.status.backgroundColor,
          border: Border.all(
            color: widget.booking.status.color.withOpacity(0.3),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(16), // More rounded
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              widget.booking.status.icon,
              size: 14,
              color: widget.booking.status.color,
            ),
            const SizedBox(width: 6), // Slightly more space
            Flexible(
              child: Text(
                widget.booking.status.displayName,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600, // Bolder text
                  color: widget.booking.status.color,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
