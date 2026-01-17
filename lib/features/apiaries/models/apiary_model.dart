class Apiary {
  final String id;
  final String name;
  final String? imagePath;
  final double? latitude;
  final double? longitude;
  final int hiveCount;
  final DateTime createdAt;
  final String? notes;

  Apiary({
    required this.id,
    required this.name,
    this.imagePath,
    this.latitude,
    this.longitude,
    this.hiveCount = 0,
    required this.createdAt,
    this.notes,
  });

  // Get location string
  String get locationString {
    if (latitude != null && longitude != null) {
      return 'Lat: ${latitude!.toStringAsFixed(4)}, Lon: ${longitude!.toStringAsFixed(4)}';
    }
    return 'No location';
  }

  // Check if has location
  bool get hasLocation => latitude != null && longitude != null;

  // Check if has image
  bool get hasImage => imagePath != null && imagePath!.isNotEmpty;

  Apiary copyWith({
    String? id,
    String? name,
    String? imagePath,
    double? latitude,
    double? longitude,
    int? hiveCount,
    DateTime? createdAt,
    String? notes,
  }) {
    return Apiary(
      id: id ?? this.id,
      name: name ?? this.name,
      imagePath: imagePath ?? this.imagePath,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      hiveCount: hiveCount ?? this.hiveCount,
      createdAt: createdAt ?? this.createdAt,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imagePath': imagePath,
      'latitude': latitude,
      'longitude': longitude,
      'hiveCount': hiveCount,
      'createdAt': createdAt.toIso8601String(),
      'notes': notes,
    };
  }

  factory Apiary.fromMap(Map<String, dynamic> map) {
    return Apiary(
      id: map['id'],
      name: map['name'],
      imagePath: map['imagePath'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      hiveCount: map['hiveCount'] ?? 0,
      createdAt: DateTime.parse(map['createdAt']),
      notes: map['notes'],
    );
  }
}