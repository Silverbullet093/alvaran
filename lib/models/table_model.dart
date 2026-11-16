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
    this.capacity = 6, // Kapasitas 6 orang satu meja
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

  /// 7 Meja ALVARAN, masing-masing berkapasitas 6 orang
  static List<TableModel> initialTables() {
    return const [
      TableModel(
        id: 1,
        number: 1,
        name: 'Meja 1',
        capacity: 6,
        isAvailable: true,
        area: 'Main Hall A',
      ),
      TableModel(
        id: 2,
        number: 2,
        name: 'Meja 2',
        capacity: 6,
        isAvailable: false, // Terisi
        area: 'Main Hall A',
      ),
      TableModel(
        id: 3,
        number: 3,
        name: 'Meja 3',
        capacity: 6,
        isAvailable: true,
        area: 'Main Hall B',
      ),
      TableModel(
        id: 4,
        number: 4,
        name: 'Meja 4',
        capacity: 6,
        isAvailable: true,
        area: 'Main Hall B',
      ),
      TableModel(
        id: 5,
        number: 5,
        name: 'Meja 5',
        capacity: 6,
        isAvailable: true,
        area: 'Cozy Corner',
      ),
      TableModel(
        id: 6,
        number: 6,
        name: 'Meja 6',
        capacity: 6,
        isAvailable: true,
        area: 'Cozy Corner',
      ),
      TableModel(
        id: 7,
        number: 7,
        name: 'Meja 7',
        capacity: 6,
        isAvailable: true,
        area: 'Grand Table Center',
      ),
    ];
  }
}
