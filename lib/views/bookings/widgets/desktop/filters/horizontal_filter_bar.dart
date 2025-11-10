import 'package:booking/commons/extensions/spacing.dart';
import 'package:booking/models/bookings_model.dart';
import 'package:booking/models/bookings_timeslot.dart';
import 'package:booking/views/bookings/widgets/controllers/booking_table_controller.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HorizontalFilterBar extends GetView<BookingTableController> {
  const HorizontalFilterBar({super.key});
  static final RxBool isExpanded = false.obs;
  static final DateTime _minDate = DateTime(DateTime.now().year - 3);
  static final DateTime _maxDate = DateTime(DateTime.now().year + 3);
  static final ThemeData _datePickerTheme = ThemeData.light().copyWith(
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF5697C6),
      onPrimary: Colors.white,
      surface: Colors.white,
      onSurface: Color(0xFF1E293B),
    ),
    datePickerTheme: DatePickerThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      headerBackgroundColor: const Color(0xFF5697C6),
      headerForegroundColor: Colors.white,
      dayStyle: const TextStyle(fontSize: 14),
      yearStyle: const TextStyle(fontSize: 16),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Row1: Search + Quick filters
          Row(
            children: [
              Expanded(flex: 3, child: _buildSearch()),
              16.widthBox,

              /// Today
              Expanded(
                child: _buildQuickFilter(
                  'Today',
                  Icons.today,
                  () => controller.filteredToday(),
                  QuickAccessFilter.today,
                ),
              ),
              8.widthBox,

              /// Up coming
              Expanded(
                child: _buildQuickFilter(
                  'Up coming',
                  Icons.trending_up,
                  () => controller.filterUpcoming(),
                  QuickAccessFilter.upComing,
                ),
              ),
              8.widthBox,

              /// This week
              Expanded(
                child: _buildQuickFilter(
                  'This week',
                  Icons.date_range,
                  () => controller.filteredThisWeek(),
                  QuickAccessFilter.thisWeek,
                ),
              ),
              16.widthBox,

              /// Toggle filters
              _buildToggleFilters(isExpanded),
            ],
          ),
          Obx(() => isExpanded.value ? 10.heightBox : const SizedBox.shrink()),
          // Row2: Details filters
          Obx(
            () => AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: isExpanded.value
                  ? Row(
                      children: [
                        /// Status
                        Expanded(child: _buildStatusFilter()),
                        8.widthBox,

                        /// Time slots
                        Expanded(child: _buildTimeSlotFilter()),
                        8.widthBox,

                        /// Guests
                        Expanded(child: _buildPartySizeFilter()),
                        8.widthBox,

                        /// Date range
                        Expanded(child: _buildDateRange(context)),
                        12.widthBox,
                        // Reset
                        _buildResetBtn(),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearch() {
    return TextField(
      controller: controller.searchController,
      decoration: InputDecoration(
        hintText: 'Search by name, phone, ID,...',
        hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
        prefixIcon: const Icon(
          Icons.search,
          color: Color(0xFF64748B),
          size: 20,
        ),
        filled: true,
        fillColor: const Color(0xFFF8F9FA),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF5697C6), width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
    );
  }

  // ========== QUICK FILTER ===========
  Widget _buildQuickFilter(
    String label,
    IconData icon,
    VoidCallback onTap,
    QuickAccessFilter quickAccess,
  ) {
    return Obx(() {
      final isActive = controller.quickAccess.value == quickAccess;
      return InkWell(
        onTap: isActive ? () => controller.resetQuickAccess() : onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
          decoration: BoxDecoration(
            gradient: isActive
                ? const LinearGradient(
                    colors: [Color(0xFFF1F5F9), Color(0xFF4A7FA3)],
                  )
                : const LinearGradient(
                    colors: [Color(0xFFF1F5F9), Color(0xFFE2E8F0)],
                  ),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isActive
                  ? const Color(0xFF4A7FA3)
                  : const Color(0xFFCBD5E1),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16,
                color: isActive ? Colors.white : const Color(0xFF5697C6),
              ),
              6.widthBox,
              Flexible(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF475569),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildToggleFilters(RxBool isExpanded) {
    return Obx(() {
      return Tooltip(
        message: isExpanded.value ? 'Hide filters' : 'Show filters',
        child: InkWell(
          onTap: () => isExpanded.toggle(),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: isExpanded.value
                  ? const Color(0xFF5697C6)
                  : const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isExpanded.value
                    ? const Color(0xFF4A7FA3)
                    : const Color(0xFFCBD5E1),
              ),
            ),
            child: Icon(
              isExpanded.value ? Icons.expand_less : Icons.expand_more,
              size: 20,
              color: isExpanded.value ? Colors.white : const Color(0xFF5697C6),
            ),
          ),
        ),
      );
    });
  }
  // ========== -------- ===========

  // ========== FILTERS ============
  Widget _buildStatusFilter() {
    return Obx(() {
      return _buildDropDown<BookingStatus?>(
        label: 'Status',
        value: controller.selectedStatus.value,
        onChanged: (value) => controller.applyStatus(value),
        icon: Icons.flag_outlined,
        items: [
          DropdownMenuItem(
            value: null,
            child: Row(
              children: [
                Icon(Icons.flag_outlined, size: 16),
                8.widthBox,
                Expanded(
                  child: Text(
                    'All status',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          ...BookingStatus.values.map((s) {
            final count = controller.statusCounts[s] ?? 0;
            return DropdownMenuItem(
              value: s,
              child: Row(
                children: [
                  Icon(s.icon, size: 16, color: s.color),
                  8.widthBox,
                  Text(s.displayName),
                  // const Spacer(),
                  // Container(
                  //   padding: const EdgeInsets.symmetric(
                  //     horizontal: 8,
                  //     vertical: 2,
                  //   ),
                  //   decoration: BoxDecoration(
                  //     color: s.backgroundColor,
                  //     borderRadius: BorderRadius.circular(10),
                  //   ),
                  //   child: Text(
                  //     count.toString(),
                  //     style: TextStyle(
                  //       fontSize: 11,
                  //       fontWeight: FontWeight.w600,
                  //       color: s.color,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            );
          }),
        ],
      );
    });
  }

  Widget _buildTimeSlotFilter() {
    return Obx(() {
      return _buildDropDown<BookingsTimeslot>(
        label: "TimeSlot",
        value: controller.selectedTimeSlot.value,
        onChanged: (value) => controller.applyTimeSlot(value!),
        icon: Icons.access_time,
        items: BookingsTimeslot.values.map((timeslot) {
          return DropdownMenuItem(
            value: timeslot,
            child: Row(
              children: [
                Icon(
                  Icons.schedule,
                  size: 16,
                  color: timeslot == BookingsTimeslot.all
                      ? const Color(0xFF64748B)
                      : const Color(0xFF5697C6),
                ),
                8.widthBox,
                Text(
                  timeslot.label,
                  style: TextStyle(
                    fontWeight: timeslot == BookingsTimeslot.all
                        ? FontWeight.w600
                        : FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      );
    });
  }

  Widget _buildPartySizeFilter() {
    return Obx(() {
      return _buildDropDown<String?>(
        label: 'Party size',
        value: controller.selectedPartySize.value,
        onChanged: (value) => controller.applyPartySize(value),
        items: [
          DropdownMenuItem(
            value: null,
            child: Row(
              children: [
                Icon(Icons.people_outline, size: 16, color: Color(0xFF488FC3)),
                8.widthBox,
                Expanded(
                  child: Text(
                    'All sized',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          const DropdownMenuItem(value: '1-4', child: Text('1-4 guests')),
          const DropdownMenuItem(value: '5-7', child: Text('5-7 guests')),
          const DropdownMenuItem(value: '8+', child: Text('8+ guests')),
        ],
        icon: Icons.people_outline,
      );
    });
  }

  Widget _buildDropDown<T>({
    required String label,
    required T value,
    required Function(T?) onChanged,
    required IconData icon,
    required List<DropdownMenuItem<T>> items,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<T>(
          value: value,
          isExpanded: true,
          iconStyleData: const IconStyleData(
            icon: Icon(Icons.arrow_drop_down, color: Color(0xFF64748B)),
          ),
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1E293B),
          ),
          items: items,
          onChanged: onChanged,
          dropdownStyleData: DropdownStyleData(
            maxHeight: 300,
            offset: const Offset(0, -5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 48,
            padding: EdgeInsets.symmetric(horizontal: 16),
          ),
        ),
      ),
    );
  }

  Widget _buildDateRange(BuildContext context) {
    return Obx(() {
      final hasDateRange = controller.selectedDateRange.value != null;
      final dateText = hasDateRange
          ? controller.formattedDateRange
          : 'Selected date range';

      return InkWell(
        onTap: () => _showDateRangePicker(context),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            color: hasDateRange
                ? const Color(0xFFB4D7EF)
                : const Color(0xFFE2E8F0),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: hasDateRange
                  ? const Color(0xFFB9DAE8)
                  : const Color(0xFFE2E8F0),
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.calendar_today,
                size: 16,
                color: hasDateRange
                    ? const Color(0xFF488FC3)
                    : const Color(0xFF64748B),
              ),
              8.widthBox,
              Expanded(
                child: Text(
                  dateText,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: hasDateRange
                        ? FontWeight.w600
                        : FontWeight.w500,
                    color: hasDateRange
                        ? const Color(0xFF1E293B)
                        : const Color(0xFF94A3B8),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Future<void> _showDateRangePicker(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: _minDate,
      lastDate: _maxDate,
      initialDateRange: controller.selectedDateRange.value,
      builder: (context, child) {
        return Theme(data: _datePickerTheme, child: child!);
      },
    );
    if (picked != null) {
      controller.applyDateRange(picked);
    }
  }

  // ============== --------- ==============
  // ===== Reset =====
  Widget _buildResetBtn() {
    return Obx(() {
      final hasFilters = controller.hasActiveFiltered.value;
      return Tooltip(
        message: 'Reset',
        child: InkWell(
          onTap: hasFilters ? () => controller.resetFilter() : null,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: hasFilters
                  ? const Color(0xFFFEE2E2)
                  : const Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: hasFilters
                    ? const Color(0xFFEF4444)
                    : const Color(0xFFE2E8F0),
              ),
            ),
            child: Icon(
              Icons.filter_alt_off,
              size: 20,
              color: hasFilters
                  ? const Color(0xFFEF4444)
                  : const Color(0xFF94A3B8),
            ),
          ),
        ),
      );
    });
  }
}
