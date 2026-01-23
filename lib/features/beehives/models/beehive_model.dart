import 'beehive_image_model.dart';

enum QueenType { local, imported, bred, swarm, purchased, unknown }

extension QueenTypeExtension on QueenType {
  String get label {
    switch (this) {
      case QueenType.local: return 'Local';
      case QueenType.imported: return 'Imported';
      case QueenType.bred: return 'Home Bred';
      case QueenType.swarm: return 'From Swarm';
      case QueenType.purchased: return 'Purchased';
      case QueenType.unknown: return 'Unknown';
    }
  }

  String get labelAr {
    switch (this) {
      case QueenType.local: return 'محلية';
      case QueenType.imported: return 'مستوردة';
      case QueenType.bred: return 'مربّاة';
      case QueenType.swarm: return 'من طرد';
      case QueenType.purchased: return 'مشتراة';
      case QueenType.unknown: return 'غير معروف';
    }
  }
}

enum QueenBreed { italian, carniolan, buckfast, caucasian, local, hybrid, other }

extension QueenBreedExtension on QueenBreed {
  String get label {
    switch (this) {
      case QueenBreed.italian: return 'Italian';
      case QueenBreed.carniolan: return 'Carniolan';
      case QueenBreed.buckfast: return 'Buckfast';
      case QueenBreed.caucasian: return 'Caucasian';
      case QueenBreed.local: return 'Local';
      case QueenBreed.hybrid: return 'Hybrid';
      case QueenBreed.other: return 'Other';
    }
  }

  String get labelAr {
    switch (this) {
      case QueenBreed.italian: return 'إيطالي';
      case QueenBreed.carniolan: return 'كرنيولي';
      case QueenBreed.buckfast: return 'باكفاست';
      case QueenBreed.caucasian: return 'قوقازي';
      case QueenBreed.local: return 'بلدي';
      case QueenBreed.hybrid: return 'هجين';
      case QueenBreed.other: return 'آخر';
    }
  }
}

enum HealthStatus { healthy, weak, sick, critical, unknown }

extension HealthStatusExtension on HealthStatus {
  String get label {
    switch (this) {
      case HealthStatus.healthy: return 'Healthy';
      case HealthStatus.weak: return 'Weak';
      case HealthStatus.sick: return 'Sick';
      case HealthStatus.critical: return 'Critical';
      case HealthStatus.unknown: return 'Unknown';
    }
  }

  String get emoji {
    switch (this) {
      case HealthStatus.healthy: return '💚';
      case HealthStatus.weak: return '💛';
      case HealthStatus.sick: return '🧡';
      case HealthStatus.critical: return '❤️';
      case HealthStatus.unknown: return '❔';
    }
  }
}

enum QueenMarkingColor { white, yellow, red, green, blue }

extension QueenMarkingColorExtension on QueenMarkingColor {
  String get label {
    switch (this) {
      case QueenMarkingColor.white: return 'White (1, 6)';
      case QueenMarkingColor.yellow: return 'Yellow (2, 7)';
      case QueenMarkingColor.red: return 'Red (3, 8)';
      case QueenMarkingColor.green: return 'Green (4, 9)';
      case QueenMarkingColor.blue: return 'Blue (5, 0)';
    }
  }

  String get colorCode {
    switch (this) {
      case QueenMarkingColor.white: return '#FFFFFF';
      case QueenMarkingColor.yellow: return '#FFD700';
      case QueenMarkingColor.red: return '#FF4444';
      case QueenMarkingColor.green: return '#44BB44';
      case QueenMarkingColor.blue: return '#4444FF';
    }
  }
}

class Beehive {
  final String id;
  final String apiaryId;
  
  // Identification
  final int systemNumber;
  final String hiveNumber;
  final String? name;
  
  // Hive info
  final int frameCount;
  
  // Queen info
  final bool hasQueen;
  final QueenType? queenType;
  final QueenBreed? queenBreed;
  final DateTime? queenAddedDate;
  final bool isQueenMarked;
  final QueenMarkingColor? queenMarkingColor;
  
  // Status
  final HealthStatus healthStatus;
  
  // Images
  final List<BeehiveImage> images;
  
  // Notes
  final String? notes;
  
  // Metadata
  final DateTime createdAt;
  final DateTime updatedAt;

  Beehive({
    required this.id,
    required this.apiaryId,
    required this.systemNumber,
    required this.hiveNumber,
    this.name,
    required this.frameCount,
    required this.hasQueen,
    this.queenType,
    this.queenBreed,
    this.queenAddedDate,
    this.isQueenMarked = false,
    this.queenMarkingColor,
    this.healthStatus = HealthStatus.unknown,
    this.images = const [],
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'apiaryId': apiaryId,
      'systemNumber': systemNumber,
      'hiveNumber': hiveNumber,
      'name': name,
      'frameCount': frameCount,
      'hasQueen': hasQueen ? 1 : 0,
      'queenType': queenType?.index,
      'queenBreed': queenBreed?.index,
      'queenAddedDate': queenAddedDate?.toIso8601String(),
      'isQueenMarked': isQueenMarked ? 1 : 0,
      'queenMarkingColor': queenMarkingColor?.index,
      'healthStatus': healthStatus.index,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Beehive.fromMap(Map<String, dynamic> map, {List<BeehiveImage>? images}) {
    return Beehive(
      id: map['id'],
      apiaryId: map['apiaryId'],
      systemNumber: map['systemNumber'],
      hiveNumber: map['hiveNumber'],
      name: map['name'],
      frameCount: map['frameCount'],
      hasQueen: map['hasQueen'] == 1,
      queenType: map['queenType'] != null ? QueenType.values[map['queenType']] : null,
      queenBreed: map['queenBreed'] != null ? QueenBreed.values[map['queenBreed']] : null,
      queenAddedDate: map['queenAddedDate'] != null ? DateTime.parse(map['queenAddedDate']) : null,
      isQueenMarked: map['isQueenMarked'] == 1,
      queenMarkingColor: map['queenMarkingColor'] != null 
          ? QueenMarkingColor.values[map['queenMarkingColor']] 
          : null,
      healthStatus: HealthStatus.values[map['healthStatus']],
      images: images ?? [],
      notes: map['notes'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }
}