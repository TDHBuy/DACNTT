import 'package:booking/views/bookings/widgets/controllers/booking_table_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchFilters extends GetView<BookingTableController> {
  const SearchFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildSearch();
  }

  Widget _buildSearch() {
    return TextField(
      focusNode: controller.searchFocusNode,
      controller: controller.searchController,
      decoration: InputDecoration(
        hintText: 'Search by name, phone, ID,...',
        hintStyle: TextStyle(color: Colors.grey[400], fontSize: 12),
        prefixIcon: const Icon(
          Icons.search,
          color: Color(0xFF64748B),
          size: 15,
        ),
        filled: true,
        fillColor: const Color(0xFFF8F9FA),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF5697C6), width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        isDense: true,
      ),
      style: const TextStyle(fontSize: 12, color: Color(0xFF1E293B)),
    );
  }
}
