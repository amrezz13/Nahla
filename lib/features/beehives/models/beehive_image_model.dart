// lib/features/beehives/models/beehive_image_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';

enum ImageType {
  queen,
  brood,
  honey,
  frames,
  disease,
  general,
}

extension ImageTypeExtension on ImageType {
  String get label {
    switch (this) {
      case ImageType.queen: return 'Queen';
      case ImageType.brood: return 'Brood/Eggs';
      case ImageType.honey: return 'Honey';
      case ImageType.frames: return 'Frames';
      case ImageType.disease: return 'Disease/Problem';
      case ImageType.general: return 'General';
    }
  }

  String get labelAr {
    switch (this) {
      case ImageType.queen: return 'الملكة';
      case ImageType.brood: return 'الحضنة';
      case ImageType.honey: return 'العسل';
      case ImageType.frames: return 'الإطارات';
      case ImageType.disease: return 'مرض/مشكلة';
      case ImageType.general: return 'عام';
    }
  }

  String get emoji {
    switch (this) {
      case ImageType.queen: return '👑';
      case ImageType.brood: return '🐝';
      case ImageType.honey: return '🍯';
      case ImageType.frames: return '🖼️';
      case ImageType.disease: return '🦠';
      case ImageType.general: return '📷';
    }
  }
}

class BeehiveImage {
  final String id;
  final String beehiveId;
  final String imageUrl;      // Firebase Storage URL
  final String storagePath;   // Path in Firebase Storage (for deletion)
  final ImageType type;
  final DateTime takenAt;
  final String? note;

  BeehiveImage({
    required this.id,
    required this.beehiveId,
    required this.imageUrl,
    required this.storagePath,
    required this.type,
    required this.takenAt,
    this.note,
  });

  Map<String, dynamic> toMap() {
    return {
      'beehiveId': beehiveId,
      'imageUrl': imageUrl,
      'storagePath': storagePath,
      'type': type.index,
      'takenAt': Timestamp.fromDate(takenAt),
      'note': note,
    };
  }

  factory BeehiveImage.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return BeehiveImage(
      id: doc.id,
      beehiveId: data['beehiveId'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      storagePath: data['storagePath'] ?? '',
      type: ImageType.values[data['type'] ?? 5],
      takenAt: (data['takenAt'] as Timestamp).toDate(),
      note: data['note'],
    );
  }

  BeehiveImage copyWith({
    String? id,
    String? beehiveId,
    String? imageUrl,
    String? storagePath,
    ImageType? type,
    DateTime? takenAt,
    String? note,
  }) {
    return BeehiveImage(
      id: id ?? this.id,
      beehiveId: beehiveId ?? this.beehiveId,
      imageUrl: imageUrl ?? this.imageUrl,
      storagePath: storagePath ?? this.storagePath,
      type: type ?? this.type,
      takenAt: takenAt ?? this.takenAt,
      note: note ?? this.note,
    );
  }
}