class PassType {
  final String id;
  final String name;
  final String description;
  final int price;
  final String iconBadge;

  const PassType({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.iconBadge,
  });

  static const PassType regular = PassType(
    id: 'regular',
    name: 'Regular Pass',
    description: 'Akses area bermain',
    price: 50000,
    iconBadge: 'ticket',
  );

  static const PassType premium = PassType(
    id: 'premium',
    name: 'Premium Pass',
    description: 'Akses + fasilitas VIP',
    price: 80000,
    iconBadge: 'vip',
  );

  static const List<PassType> availablePasses = [
    regular,
    premium,
  ];
}
