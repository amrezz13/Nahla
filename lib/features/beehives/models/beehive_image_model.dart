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
  final String imagePath;
  final ImageType type;
  final DateTime takenAt;
  final String? note;

  BeehiveImage({
    required this.id,
    required this.beehiveId,
    required this.imagePath,
    required this.type,
    required this.takenAt,
    this.note,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'beehiveId': beehiveId,
      'imagePath': imagePath,
      'type': type.index,
      'takenAt': takenAt.toIso8601String(),
      'note': note,
    };
  }

  factory BeehiveImage.fromMap(Map<String, dynamic> map) {
    return BeehiveImage(
      id: map['id'],
      beehiveId: map['beehiveId'],
      imagePath: map['imagePath'],
      type: ImageType.values[map['type']],
      takenAt: DateTime.parse(map['takenAt']),
      note: map['note'],
    );
  }
}