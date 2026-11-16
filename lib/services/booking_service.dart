import 'package:flutter/foundation.dart';
import '../models/pass_type.dart';
import '../models/table_model.dart';
import '../models/booking_ticket.dart';
import '../utils/date_formatter.dart';

class BookingService extends ChangeNotifier {
  DateTime _selectedDate = DateTime(2025, 5, 24); // Sabtu, 24 Mei 2025
  PassType _selectedPass = PassType.allDay;
  int _visitorCount = 2;
  int _hoursCount = 2; // Durasi jika memilih pass per jam
  TableModel? _selectedTable;
  bool _isPromoApplied = false;
  final double _promoDiscountPercent = 0.20; // 20% discount

  final List<TableModel> _tables = TableModel.initialTables();
  final List<BookingTicket> _tickets = [
    BookingTicket.sampleTicket(),
  ];

  BookingService() {
    _selectedTable = _tables.firstWhere((t) => t.id == 1);
  }

  // Getters
  DateTime get selectedDate => _selectedDate;
  PassType get selectedPass => _selectedPass;
  int get visitorCount => _visitorCount;
  int get hoursCount => _hoursCount;
  TableModel? get selectedTable => _selectedTable;
  bool get isPromoApplied => _isPromoApplied;
  double get promoDiscountPercent => _promoDiscountPercent;
  List<TableModel> get tables => List.unmodifiable(_tables);
  List<BookingTicket> get tickets => List.unmodifiable(_tickets);

  /// Cek apakah tanggal yang dipilih adalah Sabtu atau Minggu (Weekend)
  bool get isWeekend =>
      _selectedDate.weekday == DateTime.saturday ||
      _selectedDate.weekday == DateTime.sunday;

  String get dayCategoryLabel =>
      isWeekend ? 'Sabtu – Minggu (Weekend)' : 'Senin – Jumat (Weekday)';

  /// Harga tiket per orang saat ini sesuai weekday/weekend
  int get currentPricePerPerson => _selectedPass.getPrice(isWeekend);

  /// Subtotal sebelum promo
  int get subtotal {
    if (_selectedPass.isHourly) {
      return currentPricePerPerson * _visitorCount * _hoursCount;
    }
    return currentPricePerPerson * _visitorCount;
  }

  int get discountAmount =>
      _isPromoApplied ? (subtotal * _promoDiscountPercent).round() : 0;

  int get grandTotal => subtotal - discountAmount;

  // Actions
  void selectDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void selectPassType(PassType pass) {
    _selectedPass = pass;
    notifyListeners();
  }

  void incrementVisitor() {
    if (_visitorCount < 10) {
      _visitorCount++;
      notifyListeners();
    }
  }

  void decrementVisitor() {
    if (_visitorCount > 1) {
      _visitorCount--;
      notifyListeners();
    }
  }

  void incrementHours() {
    if (_hoursCount < 8) {
      _hoursCount++;
      notifyListeners();
    }
  }

  void decrementHours() {
    if (_hoursCount > 1) {
      _hoursCount--;
      notifyListeners();
    }
  }

  void setVisitorCount(int count) {
    if (count >= 1 && count <= 10) {
      _visitorCount = count;
      notifyListeners();
    }
  }

  void selectTable(TableModel table) {
    _selectedTable = table;
    notifyListeners();
  }

  void togglePromo() {
    _isPromoApplied = !_isPromoApplied;
    notifyListeners();
  }

  void applyPromo(bool apply) {
    _isPromoApplied = apply;
    notifyListeners();
  }

  /// Create booking and return the created ticket
  BookingTicket createBooking({
    required String customerName,
    required String customerEmail,
  }) {
    final now = DateTime.now();
    final ticketId = 'ticket-${_tickets.length + 1}';
    final code =
        'ALV-${_selectedDate.year}${_selectedDate.month.toString().padLeft(2, '0')}${_selectedDate.day.toString().padLeft(2, '0')}-${(_tickets.length + 1).toString().padLeft(3, '0')}';

    final durationText = _selectedPass.isHourly ? '${_hoursCount}H' : 'ALLDAY';
    final qrCode =
        'ALVARAN:$code:${_selectedPass.id.toUpperCase()}:$durationText:${_visitorCount}P:TABLE${_selectedTable?.number ?? 1}:${_selectedDate.toIso8601String().split('T').first}';

    final newTicket = BookingTicket(
      id: ticketId,
      ticketCode: code,
      passType: _selectedPass,
      date: _selectedDate,
      timeSlot: '14:00',
      visitorCount: _visitorCount,
      tableNumber: _selectedTable?.number ?? 1,
      totalPrice: grandTotal,
      discountAmount: discountAmount,
      customerName: customerName,
      customerEmail: customerEmail,
      qrPayload: qrCode,
      createdAt: now,
    );

    _tickets.insert(0, newTicket);

    if (_selectedTable != null) {
      final index = _tables.indexWhere((t) => t.id == _selectedTable!.id);
      if (index != -1) {
        _tables[index] = _tables[index].copyWith(isAvailable: false);
      }
    }

    notifyListeners();
    return newTicket;
  }

  String get formattedSelectedDate =>
      DateFormatter.formatFullIndonesian(_selectedDate);
}
