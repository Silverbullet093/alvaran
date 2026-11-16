import 'pass_type.dart';

class BookingTicket {
  final String id;
  final String ticketCode;
  final PassType passType;
  final DateTime date;
  final String timeSlot;
  final int visitorCount;
  final int tableNumber;
  final int totalPrice;
  final int discountAmount;
  final String customerName;
  final String customerEmail;
  final String qrPayload;
  final DateTime createdAt;
  final bool isUsed;

  const BookingTicket({
    required this.id,
    required this.ticketCode,
    required this.passType,
    required this.date,
    required this.timeSlot,
    required this.visitorCount,
    required this.tableNumber,
    required this.totalPrice,
    this.discountAmount = 0,
    required this.customerName,
    required this.customerEmail,
    required this.qrPayload,
    required this.createdAt,
    this.isUsed = false,
  });

  String get formattedPassAndVisitors =>
      '${passType.name} · $visitorCount Orang';

  String get tableLabel => 'Meja $tableNumber';

  // Sample initial ticket shown in Profile mockup
  static BookingTicket sampleTicket() {
    return BookingTicket(
      id: 'ticket-1',
      ticketCode: 'ALV-20250524-001',
      passType: PassType.regular,
      date: DateTime(2025, 5, 24),
      timeSlot: '14:00',
      visitorCount: 2,
      tableNumber: 1,
      totalPrice: 100000,
      customerName: 'Andi Pratama',
      customerEmail: 'andi.pratama@email.com',
      qrPayload: 'ALVARAN:ALV-20250524-001:REGULAR:2P:TABLE1:2025-05-24',
      createdAt: DateTime(2025, 5, 20, 10, 30),
    );
  }
}
