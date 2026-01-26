// lib/features/apiaries/models/apiary.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class Apiary {
  final String id;
  final String name;
  final String location;
  final double? latitude;
  final double? longitude;
  final String? notes;
  final String? imageUrl;
  final DateTime createdAt;
  final String userId;
  final int hiveCount;

  Apiary({
    required this.id,
    required this.name,
    required this.location,
    this.latitude,
    this.longitude,
    this.notes,
    this.imageUrl,
    required this.createdAt,
    required this.userId,
    this.hiveCount = 0,
  });

  // Get location string
  String get locationString {
    if (latitude != null && longitude != null) {
      return 'Lat: ${latitude!.toStringAsFixed(4)}, Lon: ${longitude!.toStringAsFixed(4)}';
    }
    return location.isNotEmpty ? location : 'No location';
  }

  // Check if has coordinates
  bool get hasCoordinates => latitude != null && longitude != null;

  // Check if has location (address or coordinates)
  bool get hasLocation => location.isNotEmpty || hasCoordinates;

  // Check if has image
  bool get hasImage => imageUrl != null && imageUrl!.isNotEmpty;

  // Convert to Firestore map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'notes': notes,
      'imageUrl': imageUrl,
      'createdAt': Timestamp.fromDate(createdAt),
      'userId': userId,
      'hiveCount': hiveCount,
    };
  }

  // Create from Firestore document
  factory Apiary.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Apiary(
      id: doc.id,
      name: data['name'] ?? '',
      location: data['location'] ?? '',
      latitude: data['latitude']?.toDouble(),
      longitude: data['longitude']?.toDouble(),
      notes: data['notes'],
      imageUrl: data['imageUrl'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      userId: data['userId'] ?? '',
      hiveCount: data['hiveCount'] ?? 0,
    );
  }

  // Create from Map (for local storage or JSON)
  factory Apiary.fromMap(Map<String, dynamic> map) {
    return Apiary(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      location: map['location'] ?? '',
      latitude: map['latitude']?.toDouble(),
      longitude: map['longitude']?.toDouble(),
      notes: map['notes'],
      imageUrl: map['imageUrl'],
      createdAt: map['createdAt'] is Timestamp
          ? (map['createdAt'] as Timestamp).toDate()
          : DateTime.parse(map['createdAt']),
      userId: map['userId'] ?? '',
      hiveCount: map['hiveCount'] ?? 0,
    );
  }

  // Copy with new values
  Apiary copyWith({
    String? id,
    String? name,
    String? location,
    double? latitude,
    double? longitude,
    String? notes,
    String? imageUrl,
    DateTime? createdAt,
    String? userId,
    int? hiveCount,
  }) {
    return Apiary(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      notes: notes ?? this.notes,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      userId: userId ?? this.userId,
      hiveCount: hiveCount ?? this.hiveCount,
    );
  }

  @override
  String toString() {
    return 'Apiary(id: $id, name: $name, location: $location, hiveCount: $hiveCount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Apiary && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}