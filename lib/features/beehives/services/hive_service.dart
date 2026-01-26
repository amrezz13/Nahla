// lib/services/hive_service.dart

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import '../models/beehive_model.dart';
import '../models/beehive_image_model.dart';

class HiveService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Collection reference
  CollectionReference get _hivesCollection => _firestore.collection('beehives');

  // === CREATE ===
  Future<String> addBeehive(Beehive beehive) async {
    final docRef = await _hivesCollection.add(beehive.toMap());
    return docRef.id;
  }

  // === READ ===
  
  // Stream beehives by apiary (real-time)
  Stream<List<Beehive>> getBeehivesStream(String apiaryId, String userId) {
    return _hivesCollection
        .where('apiaryId', isEqualTo: apiaryId)
        .where('userId', isEqualTo: userId)
        .orderBy('systemNumber')
        .snapshots()
        .asyncMap((snapshot) async {
      return await Future.wait(
        snapshot.docs.map((doc) async {
          final images = await getBeehiveImages(doc.id);
          return Beehive.fromDocument(doc, images: images);
        }),
      );
    });
  }

  // Get single beehive
  Future<Beehive?> getBeehive(String beehiveId) async {
    final doc = await _hivesCollection.doc(beehiveId).get();
    if (!doc.exists) return null;

    final images = await getBeehiveImages(beehiveId);
    return Beehive.fromDocument(doc, images: images);
  }

  // Get all beehives for user (for stats)
  Future<List<Beehive>> getAllUserBeehives(String userId) async {
    final snapshot = await _hivesCollection
        .where('userId', isEqualTo: userId)
        .get();

    return snapshot.docs
        .map((doc) => Beehive.fromDocument(doc))
        .toList();
  }

  // === UPDATE ===
  Future<void> updateBeehive(Beehive beehive) async {
    await _hivesCollection.doc(beehive.id).update(beehive.toMap());
  }

  // === DELETE ===
  Future<void> deleteBeehive(String beehiveId) async {
    // Delete all images first
    await deleteAllBeehiveImages(beehiveId);
    // Delete beehive document
    await _hivesCollection.doc(beehiveId).delete();
  }

  // === IMAGE OPERATIONS ===

  // Upload image to Firebase Storage
  Future<BeehiveImage?> uploadImage({
    required String userId,
    required String beehiveId,
    required File imageFile,
    required ImageType type,
    String? note,
  }) async {
    try {
      final imageId = DateTime.now().millisecondsSinceEpoch.toString();
      final storagePath = 'users/$userId/beehives/$beehiveId/$imageId.jpg';

      // Upload to Storage
      final ref = _storage.ref().child(storagePath);
      await ref.putFile(imageFile);

      // Get download URL
      final imageUrl = await ref.getDownloadURL();

      // Create image object
      final image = BeehiveImage(
        id: imageId,
        beehiveId: beehiveId,
        imageUrl: imageUrl,
        storagePath: storagePath,
        type: type,
        takenAt: DateTime.now(),
        note: note,
      );

      // Save to Firestore subcollection
      await _hivesCollection
          .doc(beehiveId)
          .collection('images')
          .doc(imageId)
          .set(image.toMap());

      return image;
    } catch (e) {
      debugPrint('Error uploading image: $e');
      return null;
    }
  }

  // Get beehive images
  Future<List<BeehiveImage>> getBeehiveImages(String beehiveId) async {
    try {
      final snapshot = await _hivesCollection
          .doc(beehiveId)
          .collection('images')
          .orderBy('takenAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => BeehiveImage.fromDocument(doc))
          .toList();
    } catch (e) {
      debugPrint('Error getting images: $e');
      return [];
    }
  }

  // Delete single image
  Future<void> deleteImage(String beehiveId, BeehiveImage image) async {
    // Delete from Storage
    await _storage.ref().child(image.storagePath).delete();

    // Delete from Firestore
    await _hivesCollection
        .doc(beehiveId)
        .collection('images')
        .doc(image.id)
        .delete();
  }

  // Delete all images for a beehive
  Future<void> deleteAllBeehiveImages(String beehiveId) async {
    final images = await getBeehiveImages(beehiveId);

    for (final image in images) {
      try {
        await _storage.ref().child(image.storagePath).delete();
        await _hivesCollection
            .doc(beehiveId)
            .collection('images')
            .doc(image.id)
            .delete();
      } catch (e) {
        debugPrint('Error deleting image: $e');
      }
    }
  }

  // === HELPERS ===

  // Get next system number for apiary
  Future<int> getNextSystemNumber(String apiaryId) async {
    try {
      final snapshot = await _hivesCollection
          .where('apiaryId', isEqualTo: apiaryId)
          .orderBy('systemNumber', descending: true)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) return 1;

      final data = snapshot.docs.first.data() as Map<String, dynamic>;
      return (data['systemNumber'] as int) + 1;
    } catch (e) {
      return 1;
    }
  }

  // Update apiary hive count
  Future<void> updateApiaryHiveCount(String apiaryId, int change) async {
    await _firestore.collection('apiaries').doc(apiaryId).update({
      'hiveCount': FieldValue.increment(change),
    });
  }
}