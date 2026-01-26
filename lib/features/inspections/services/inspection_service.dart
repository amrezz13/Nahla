// lib/features/inspections/services/inspection_service.dart

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/inspection_model.dart';

class InspectionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Collection references
  CollectionReference get _inspectionsCollection =>
      _firestore.collection('inspections');

  CollectionReference _imagesCollection(String inspectionId) =>
      _inspectionsCollection.doc(inspectionId).collection('images');

  // === CREATE ===
  Future<String> createInspection(Inspection inspection) async {
    try {
      final docRef = await _inspectionsCollection.add(inspection.toMap());
      return docRef.id;
    } catch (e) {
      throw Exception('Failed to create inspection: $e');
    }
  }

  // === READ ===
  Future<Inspection?> getInspection(String inspectionId) async {
    try {
      final doc = await _inspectionsCollection.doc(inspectionId).get();
      if (!doc.exists) return null;

      final images = await getInspectionImages(inspectionId);
      return Inspection.fromDocument(doc, images: images);
    } catch (e) {
      throw Exception('Failed to get inspection: $e');
    }
  }

  // Get inspections for a beehive
  Future<List<Inspection>> getInspectionsForBeehive(String beehiveId) async {
    try {
      final snapshot = await _inspectionsCollection
          .where('beehiveId', isEqualTo: beehiveId)
          .orderBy('inspectionDate', descending: true)
          .get();

      List<Inspection> inspections = [];
      for (var doc in snapshot.docs) {
        final images = await getInspectionImages(doc.id);
        inspections.add(Inspection.fromDocument(doc, images: images));
      }
      return inspections;
    } catch (e) {
      throw Exception('Failed to get inspections for beehive: $e');
    }
  }

  // Get inspections for an apiary
  Future<List<Inspection>> getInspectionsForApiary(String apiaryId) async {
    try {
      final snapshot = await _inspectionsCollection
          .where('apiaryId', isEqualTo: apiaryId)
          .orderBy('inspectionDate', descending: true)
          .get();

      List<Inspection> inspections = [];
      for (var doc in snapshot.docs) {
        final images = await getInspectionImages(doc.id);
        inspections.add(Inspection.fromDocument(doc, images: images));
      }
      return inspections;
    } catch (e) {
      throw Exception('Failed to get inspections for apiary: $e');
    }
  }

  // Get all inspections for a user
  Future<List<Inspection>> getInspectionsForUser(String userId) async {
    try {
      final snapshot = await _inspectionsCollection
          .where('userId', isEqualTo: userId)
          .orderBy('inspectionDate', descending: true)
          .get();

      List<Inspection> inspections = [];
      for (var doc in snapshot.docs) {
        final images = await getInspectionImages(doc.id);
        inspections.add(Inspection.fromDocument(doc, images: images));
      }
      return inspections;
    } catch (e) {
      throw Exception('Failed to get inspections for user: $e');
    }
  }

  // Get recent inspections (with limit)
  Future<List<Inspection>> getRecentInspections(
    String userId, {
    int limit = 10,
  }) async {
    try {
      final snapshot = await _inspectionsCollection
          .where('userId', isEqualTo: userId)
          .orderBy('inspectionDate', descending: true)
          .limit(limit)
          .get();

      List<Inspection> inspections = [];
      for (var doc in snapshot.docs) {
        final images = await getInspectionImages(doc.id);
        inspections.add(Inspection.fromDocument(doc, images: images));
      }
      return inspections;
    } catch (e) {
      throw Exception('Failed to get recent inspections: $e');
    }
  }

  // Get inspections by date range
  Future<List<Inspection>> getInspectionsByDateRange(
    String userId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      final snapshot = await _inspectionsCollection
          .where('userId', isEqualTo: userId)
          .where('inspectionDate', isGreaterThanOrEqualTo: Timestamp.fromDate(startDate))
          .where('inspectionDate', isLessThanOrEqualTo: Timestamp.fromDate(endDate))
          .orderBy('inspectionDate', descending: true)
          .get();

      List<Inspection> inspections = [];
      for (var doc in snapshot.docs) {
        final images = await getInspectionImages(doc.id);
        inspections.add(Inspection.fromDocument(doc, images: images));
      }
      return inspections;
    } catch (e) {
      throw Exception('Failed to get inspections by date range: $e');
    }
  }

  // Stream inspections for a beehive (real-time)
  Stream<List<Inspection>> streamInspectionsForBeehive(String beehiveId) {
    return _inspectionsCollection
        .where('beehiveId', isEqualTo: beehiveId)
        .orderBy('inspectionDate', descending: true)
        .snapshots()
        .asyncMap((snapshot) async {
      List<Inspection> inspections = [];
      for (var doc in snapshot.docs) {
        final images = await getInspectionImages(doc.id);
        inspections.add(Inspection.fromDocument(doc, images: images));
      }
      return inspections;
    });
  }

  // === UPDATE ===
  Future<void> updateInspection(Inspection inspection) async {
    try {
      await _inspectionsCollection.doc(inspection.id).update(
            inspection.copyWith(updatedAt: DateTime.now()).toMap(),
          );
    } catch (e) {
      throw Exception('Failed to update inspection: $e');
    }
  }

  // === DELETE ===
  Future<void> deleteInspection(String inspectionId) async {
    try {
      // Delete all images first
      await deleteAllInspectionImages(inspectionId);

      // Delete the inspection document
      await _inspectionsCollection.doc(inspectionId).delete();
    } catch (e) {
      throw Exception('Failed to delete inspection: $e');
    }
  }

  // === IMAGES ===
  Future<List<InspectionImage>> getInspectionImages(String inspectionId) async {
    try {
      final snapshot = await _imagesCollection(inspectionId)
          .orderBy('takenAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => InspectionImage.fromDocument(doc))
          .toList();
    } catch (e) {
      // Return empty list if subcollection doesn't exist
      return [];
    }
  }

  Future<String> uploadInspectionImage({
    required String inspectionId,
    required String userId,
    required File imageFile,
    required InspectionImageType type,
    String? note,
  }) async {
    try {
      // Create storage path
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final storagePath = 'users/$userId/inspections/$inspectionId/$fileName';

      // Upload to Firebase Storage
      final ref = _storage.ref().child(storagePath);
      await ref.putFile(imageFile);
      final downloadUrl = await ref.getDownloadURL();

      // Save image metadata to Firestore
      final imageData = InspectionImage(
        id: '',
        inspectionId: inspectionId,
        imageUrl: downloadUrl,
        storagePath: storagePath,
        type: type,
        takenAt: DateTime.now(),
        note: note,
      );

      final docRef = await _imagesCollection(inspectionId).add(imageData.toMap());
      return docRef.id;
    } catch (e) {
      throw Exception('Failed to upload inspection image: $e');
    }
  }

  Future<void> deleteInspectionImage(
    String inspectionId,
    InspectionImage image,
  ) async {
    try {
      // Delete from Storage
      if (image.storagePath.isNotEmpty) {
        await _storage.ref().child(image.storagePath).delete();
      }

      // Delete from Firestore
      await _imagesCollection(inspectionId).doc(image.id).delete();
    } catch (e) {
      throw Exception('Failed to delete inspection image: $e');
    }
  }

  Future<void> deleteAllInspectionImages(String inspectionId) async {
    try {
      final images = await getInspectionImages(inspectionId);
      for (var image in images) {
        await deleteInspectionImage(inspectionId, image);
      }
    } catch (e) {
      throw Exception('Failed to delete all inspection images: $e');
    }
  }

  // === STATISTICS ===
  Future<int> getInspectionCountForBeehive(String beehiveId) async {
    try {
      final snapshot = await _inspectionsCollection
          .where('beehiveId', isEqualTo: beehiveId)
          .count()
          .get();
      return snapshot.count ?? 0;
    } catch (e) {
      throw Exception('Failed to get inspection count: $e');
    }
  }

  Future<Inspection?> getLastInspectionForBeehive(String beehiveId) async {
    try {
      final snapshot = await _inspectionsCollection
          .where('beehiveId', isEqualTo: beehiveId)
          .orderBy('inspectionDate', descending: true)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) return null;

      final doc = snapshot.docs.first;
      final images = await getInspectionImages(doc.id);
      return Inspection.fromDocument(doc, images: images);
    } catch (e) {
      throw Exception('Failed to get last inspection: $e');
    }
  }
}