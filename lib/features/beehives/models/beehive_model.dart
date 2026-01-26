// lib/features/beehives/models/beehive_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';
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

  String get labelAr {
    switch (this) {
      case HealthStatus.healthy: return 'سليمة';
      case HealthStatus.weak: return 'ضعيفة';
      case HealthStatus.sick: return 'مريضة';
      case HealthStatus.critical: return 'حرجة';
      case HealthStatus.unknown: return 'غير معروف';
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
  final String userId;
  
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
  
  // Images (stored as subcollection or separate)
  final List<BeehiveImage> images;
  
  // Notes
  final String? notes;
  
  // Metadata
  final DateTime createdAt;
  final DateTime updatedAt;

  Beehive({
    required this.id,
    required this.apiaryId,
    required this.userId,
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

  // Convert to Firestore map
  Map<String, dynamic> toMap() {
    return {
      'apiaryId': apiaryId,
      'userId': userId,
      'systemNumber': systemNumber,
      'hiveNumber': hiveNumber,
      'name': name,
      'frameCount': frameCount,
      'hasQueen': hasQueen,
      'queenType': queenType?.index,
      'queenBreed': queenBreed?.index,
      'queenAddedDate': queenAddedDate != null 
          ? Timestamp.fromDate(queenAddedDate!) 
          : null,
      'isQueenMarked': isQueenMarked,
      'queenMarkingColor': queenMarkingColor?.index,
      'healthStatus': healthStatus.index,
      'notes': notes,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  // Create from Firestore document
  factory Beehive.fromDocument(DocumentSnapshot doc, {List<BeehiveImage>? images}) {
    final data = doc.data() as Map<String, dynamic>;
    return Beehive(
      id: doc.id,
      apiaryId: data['apiaryId'] ?? '',
      userId: data['userId'] ?? '',
      systemNumber: data['systemNumber'] ?? 0,
      hiveNumber: data['hiveNumber'] ?? '',
      name: data['name'],
      frameCount: data['frameCount'] ?? 10,
      hasQueen: data['hasQueen'] ?? false,
      queenType: data['queenType'] != null 
          ? QueenType.values[data['queenType']] 
          : null,
      queenBreed: data['queenBreed'] != null 
          ? QueenBreed.values[data['queenBreed']] 
          : null,
      queenAddedDate: data['queenAddedDate'] != null 
          ? (data['queenAddedDate'] as Timestamp).toDate() 
          : null,
      isQueenMarked: data['isQueenMarked'] ?? false,
      queenMarkingColor: data['queenMarkingColor'] != null 
          ? QueenMarkingColor.values[data['queenMarkingColor']] 
          : null,
      healthStatus: data['healthStatus'] != null 
          ? HealthStatus.values[data['healthStatus']] 
          : HealthStatus.unknown,
      images: images ?? [],
      notes: data['notes'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }

  // Copy with new values
  Beehive copyWith({
    String? id,
    String? apiaryId,
    String? userId,
    int? systemNumber,
    String? hiveNumber,
    String? name,
    int? frameCount,
    bool? hasQueen,
    QueenType? queenType,
    QueenBreed? queenBreed,
    DateTime? queenAddedDate,
    bool? isQueenMarked,
    QueenMarkingColor? queenMarkingColor,
    HealthStatus? healthStatus,
    List<BeehiveImage>? images,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Beehive(
      id: id ?? this.id,
      apiaryId: apiaryId ?? this.apiaryId,
      userId: userId ?? this.userId,
      systemNumber: systemNumber ?? this.systemNumber,
      hiveNumber: hiveNumber ?? this.hiveNumber,
      name: name ?? this.name,
      frameCount: frameCount ?? this.frameCount,
      hasQueen: hasQueen ?? this.hasQueen,
      queenType: queenType ?? this.queenType,
      queenBreed: queenBreed ?? this.queenBreed,
      queenAddedDate: queenAddedDate ?? this.queenAddedDate,
      isQueenMarked: isQueenMarked ?? this.isQueenMarked,
      queenMarkingColor: queenMarkingColor ?? this.queenMarkingColor,
      healthStatus: healthStatus ?? this.healthStatus,
      images: images ?? this.images,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Helper getters
  String get displayName => name ?? 'Hive #$hiveNumber';
  
  String get queenStatusText {
    if (!hasQueen) return 'No Queen';
    return queenType?.label ?? 'Has Queen';
  }

  @override
  String toString() {
    return 'Beehive(id: $id, hiveNumber: $hiveNumber, apiaryId: $apiaryId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Beehive && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}