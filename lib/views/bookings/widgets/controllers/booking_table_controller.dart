import 'dart:async';

import 'package:booking/data/mock_bookings.dart';
import 'package:booking/models/bookings_timeslot.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/bookings_model.dart';
import '../mobile/filters/mobile_filters.dart';

/// Enum
enum QuickAccessFilter { today, upComing, thisWeek }

class BookingTableController extends GetxController {
  /// Rows
  final RxList<BookingModel> bookings =
      <BookingModel>[].obs; // display in booking table
  final RxBool isLoading = true.obs;
  final Rx<BookingModel?> selectedBooking = Rx<BookingModel?>(null);
  final RxBool dateAscending = false.obs;

  /// > Quick Access
  final RxList<BookingModel> _allBookings =
      <BookingModel>[].obs; // all data bookings

  final statusCounts = <BookingStatus?, int>{}.obs;

  final searchFocusNode = FocusNode();
  final RxBool isSearching = false.obs;
  final TextEditingController searchController = TextEditingController();
  final Rx<QuickAccessFilter?> quickAccess = Rx<QuickAccessFilter?>(null);
  final RxBool isFilterExpanded = false.obs;

  /// > Filters
  final RxBool hasActiveFiltered = false.obs;
  final Rx<BookingsTimeslot> selectedTimeSlot = Rx<BookingsTimeslot>(
    BookingsTimeslot.all,
  );
  final Rx<String?> selectedPartySize = Rx<String?>(null);
  final Rx<BookingStatus?> selectedStatus = Rx<BookingStatus?>(null);
  final Rx<DateTimeRange?> selectedDateRange = Rx<DateTimeRange?>(null);

  /// Debounce
  Timer? _debounceTimer;
  Map<BookingStatus?, int> countStatus() {
    final counts = <BookingStatus?, int>{null: _allBookings.length};
    for (var status in BookingStatus.values) {
      counts[status] = bookings.where((b) => b.status == status).length;
    }
    return counts;
  }

  /// ===== Fetching ======
  @override
  void onInit() {
    super.onInit();
    loadBookings();

    /// Search listener
    _initSearchListener();

    /// Focus searching
    _initFocusSearching();

    /// Focus listener
    _initFocusListener();
  }

  @override
  void onClose() {
    _debounceTimer?.cancel();
    searchController.dispose();
    searchFocusNode.dispose();
    super.onClose();
  }

  void _initSearchListener() {
    searchController.addListener(() {
      if (_debounceTimer?.isActive ?? false) {
        _debounceTimer!.cancel();
      }
      _debounceTimer = Timer(const Duration(milliseconds: 500), () {
        if (!isClosed) {
          applyFilter();
        }
      });
    });
  }

  void _initFocusSearching() {
    ever(isSearching, (searching) {
      if (searching) {
        Future.delayed(Duration(milliseconds: 100), () {
          if (!isClosed) {
            searchFocusNode.requestFocus();
          }
        });
      } else {
        searchFocusNode.unfocus();
        searchController.clear();
        _debounceTimer?.cancel();
        applyFilter();
      }
    });
  }

  void _initFocusListener() {
    searchFocusNode.addListener(() {
      if (isSearching.value &&
          !searchFocusNode.hasFocus &&
          searchController.text.isEmpty) {
        searchController.clear();
        _debounceTimer?.cancel();
      }
    });
  }

  Future<void> loadBookings() async {
    try {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 1));
      final data = MockBookings.getBookings();
      // Descending by date
      sortByDate(data);
      _allBookings.value = data;
      applyFilter();
    } catch (e) {
      Get.snackbar(
        "Error",
        "Can't load bookings",
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// ====== Headers ======
  void toggleDateSort() {
    dateAscending.value = !dateAscending.value;
    sortByDate(bookings);
  }

  /// ====== Quick access ======
  void filteredToday() {
    final today = DateTime.now();
    final start = DateTime(today.year, today.month, today.day);
    final end = DateTime(today.year, today.month, today.day, 23, 59, 59);
    selectedDateRange.value = DateTimeRange(start: start, end: end);
    quickAccess.value = QuickAccessFilter.today;
    applyFilter();
  }

  void filteredThisWeek() {
    final today = DateTime.now();
    final startOfWeek = today.subtract(Duration(days: today.weekday - 1));
    final start = DateTime(
      startOfWeek.year,
      startOfWeek.month,
      startOfWeek.day,
    );
    final endOfWeek = startOfWeek.add(const Duration(days: 6));
    final end = DateTime(
      endOfWeek.year,
      endOfWeek.month,
      endOfWeek.day,
      23,
      59,
      59,
    );
    selectedDateRange.value = DateTimeRange(start: start, end: end);
    quickAccess.value = QuickAccessFilter.thisWeek;
    applyFilter();
  }

  void filterUpcoming() {
    final today = DateTime.now();
    final start = DateTime(today.year, today.month, today.day);
    final end = start.add(Duration(days: 3));
    selectedDateRange.value = DateTimeRange(start: start, end: end);
    quickAccess.value = QuickAccessFilter.upComing;
    applyFilter();
  }

  /// ====== Filter ======
  /// Status filter
  void applyStatus(BookingStatus? status) {
    selectedStatus.value = status;
    applyFilter();
  }

  /// Timeslot filter
  void applyTimeSlot(BookingsTimeslot timeslot) {
    selectedTimeSlot.value = timeslot;
    applyFilter();
  }

  /// Date range filter
  void applyDateRange(DateTimeRange range) {
    selectedDateRange.value = range;
    quickAccess.value = null;
    applyFilter();
  }

  /// Guest filter
  void applyPartySize(String? partySize) {
    selectedPartySize.value = partySize;
    applyFilter();
  }

  /// Searching
  // void searchFilter(String keywords) {
  //   searching.value = keywords;
  // }

  /// Filter chains
  void applyFilter() {
    List<BookingModel> result = _allBookings.toList();
    // === Search
    final searchText = searchController.text.trim().toLowerCase();
    if (searchText.isNotEmpty) {
      result = result
          .where(
            (b) =>
                b.customerName.toLowerCase().contains(searchText) ||
                b.phoneNumber.toLowerCase().contains(searchText) ||
                b.phoneNumber.toLowerCase().contains(searchText) ||
                b.id.toLowerCase().contains(searchText),
          )
          .toList();
    }
    // === Status
    if (selectedStatus.value != null) {
      result = result.where((b) => b.status == selectedStatus.value).toList();
    }
    // === Timeslot
    if (selectedTimeSlot.value != BookingsTimeslot.all) {
      result = result.where((b) {
        final time = b.bookingTime.split(':');
        final hour = int.parse(time[0]);
        return hour >= selectedTimeSlot.value.startHour &&
            selectedTimeSlot.value.endHour > hour;
      }).toList();
    }
    // === Date range
    if (selectedDateRange.value != null) {
      final startDate = DateTime(
        selectedDateRange.value!.start.year,
        selectedDateRange.value!.start.month,
        selectedDateRange.value!.start.day,
      );
      final endDate = DateTime(
        selectedDateRange.value!.end.year,
        selectedDateRange.value!.end.month,
        selectedDateRange.value!.end.day,
        23,
        59,
        59,
      );

      result = result.where((b) {
        final bookingDate = DateTime(
          b.bookingDate.year,
          b.bookingDate.month,
          b.bookingDate.day,
        );
        return bookingDate.compareTo(startDate) >= 0 &&
            bookingDate.compareTo(endDate) <= 0;
      }).toList();
    }

    // === Guests
    if (selectedPartySize.value != null) {
      switch (selectedPartySize.value) {
        case '1-4':
          result = result
              .where((b) => b.numberOfGuests >= 1 && b.numberOfGuests <= 4)
              .toList();
        case '5-7':
          result = result
              .where((b) => b.numberOfGuests >= 5 && b.numberOfGuests <= 7)
              .toList();
        case '8+':
          result = result.where((b) => b.numberOfGuests >= 8).toList();
      }
    }
    sortByDate(result);
    bookings.value = result;
    statusCounts.value = countStatus();
    _checkActiveFiltered();
  }

  /// Check apply filter
  void _checkActiveFiltered() {
    hasActiveFiltered.value =
        selectedStatus.value != null ||
        selectedDateRange.value != null ||
        selectedPartySize.value != null ||
        selectedTimeSlot.value != BookingsTimeslot.all;
  }

  /// Reset all states filter
  void resetFilter() {
    selectedDateRange.value = null;
    selectedStatus.value = null;
    selectedPartySize.value = null;
    // searching.value = '';
    // searchController.clear();
    selectedTimeSlot.value = BookingsTimeslot.all;
    quickAccess.value = null;
    applyFilter();
  }

  void resetQuickAccess() {
    selectedDateRange.value = null;
    quickAccess.value = null;
    applyFilter();
  }

  void selectBooking(BookingModel booking) {
    selectedBooking.value = booking;
    Get.toNamed('/booking-detail', arguments: booking);
  }

  void sortByDate(List<BookingModel> data) {
    data.sort((a, b) {
      final dateTimeA = _combineDateAndTime(a.bookingDate, a.bookingTime);
      final dateTimeB = _combineDateAndTime(b.bookingDate, b.bookingTime);

      return dateAscending.value == true
          ? dateTimeA.compareTo(dateTimeB)
          : dateTimeB.compareTo(dateTimeA);
    });
  }

  DateTime _combineDateAndTime(DateTime date, String time) {
    final parts = time.split(':');
    final hours = int.parse(parts[0]);
    final minutes = int.parse(parts[1]);
    return DateTime(date.year, date.month, date.day, hours, minutes);
  }

  String get formattedDateRange {
    if (selectedDateRange.value == null) return '';
    final start = selectedDateRange.value!.start;
    final end = selectedDateRange.value!.end;
    return '${start.day}/${start.month} - ${end.day}/${end.month}';
  }

  Future<void> showFilterSheet(BuildContext context) async {
    Get.bottomSheet(MobileFilters());
    // showBottomSheet(
    //   constraints: BoxConstraints(maxHeight: Get.height * 0.9),
    //   context: context,
    //   builder: (context) => ,
    // );
  }
}
