class TableModel {
  final int id;
  final int number;
  final String name;
  final int capacity;
  final bool isAvailable;
  final String area;
  final double gridX;
  final double gridY;

  const TableModel({
    required this.id,
    required this.number,
    required this.name,
    required this.capacity,
    required this.isAvailable,
    this.area = 'Main Hall',
    this.gridX = 0,
    this.gridY = 0,
  });

  TableModel copyWith({
    int? id,
    int? number,
    String? name,
    int? capacity,
    bool? isAvailable,
    String? area,
    double? gridX,
    double? gridY,
  }) {
    return TableModel(
      id: id ?? this.id,
      number: number ?? this.number,
      name: name ?? this.name,
      capacity: capacity ?? this.capacity,
      isAvailable: isAvailable ?? this.isAvailable,
      area: area ?? this.area,
      gridX: gridX ?? this.gridX,
      gridY: gridY ?? this.gridY,
    );
  }

  // Pre-configured 8 tables matching mockup
  static List<TableModel> initialTables() {
    return const [
      TableModel(
        id: 1,
        number: 1,
        name: 'Meja 1',
        capacity: 4,
        isAvailable: true,
        gridX: 0.28,
        gridY: 0.16,
      ),
      TableModel(
        id: 2,
        number: 2,
        name: 'Meja 2',
        capacity: 4,
        isAvailable: false, // Terisi in mockup
        gridX: 0.72,
        gridY: 0.16,
      ),
      TableModel(
        id: 3,
        number: 3,
        name: 'Meja 3',
        capacity: 4,
        isAvailable: true,
        gridX: 0.28,
        gridY: 0.38,
      ),
      TableModel(
        id: 4,
        number: 4,
        name: 'Meja 4',
        capacity: 4,
        isAvailable: true,
        gridX: 0.72,
        gridY: 0.38,
      ),
      TableModel(
        id: 5,
        number: 5,
        name: 'Meja 5',
        capacity: 4,
        isAvailable: true,
        gridX: 0.28,
        gridY: 0.60,
      ),
      TableModel(
        id: 6,
        number: 6,
        name: 'Meja 6',
        capacity: 4,
        isAvailable: true,
        gridX: 0.72,
        gridY: 0.60,
      ),
      TableModel(
        id: 7,
        number: 7,
        name: 'Meja 7',
        capacity: 4,
        isAvailable: true,
        gridX: 0.28,
        gridY: 0.82,
      ),
      TableModel(
        id: 8,
        number: 8,
        name: 'Meja 8',
        capacity: 4,
        isAvailable: true,
        gridX: 0.72,
        gridY: 0.82,
      ),
    ];
  }
}
