// lib/features/apiaries/services/apiary_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/apiary_model.dart';

class ApiaryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'apiaries';

  // Get all apiaries for a user (Stream - real-time)
  Stream<List<Apiary>> getApiariesStream(String userId) {
    return _firestore
        .collection(_collection)
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) => Apiary.fromDocument(doc)).toList();
        });
  }

  // Get single apiary by ID
  Future<Apiary?> getApiary(String apiaryId) async {
    final doc = await _firestore.collection(_collection).doc(apiaryId).get();
    if (doc.exists) {
      return Apiary.fromDocument(doc);
    }
    return null;
  }

  // Add new apiary
  Future<String> addApiary(Apiary apiary) async {
    final docRef = await _firestore.collection(_collection).add(apiary.toMap());
    return docRef.id;
  }

  // Update apiary
  Future<void> updateApiary(Apiary apiary) async {
    await _firestore
        .collection(_collection)
        .doc(apiary.id)
        .update(apiary.toMap());
  }

  // Delete apiary
  Future<void> deleteApiary(String apiaryId) async {
    final hivesSnapshot = await _firestore
        .collection('hives')
        .where('apiaryId', isEqualTo: apiaryId)
        .get();

    final batch = _firestore.batch();

    for (var doc in hivesSnapshot.docs) {
      batch.delete(doc.reference);
    }

    batch.delete(_firestore.collection(_collection).doc(apiaryId));

    await batch.commit();
  }

  // Increment hive count
  Future<void> incrementHiveCount(String apiaryId) async {
    await _firestore
        .collection(_collection)
        .doc(apiaryId)
        .update({'hiveCount': FieldValue.increment(1)});
  }

  // Decrement hive count
  Future<void> decrementHiveCount(String apiaryId) async {
    await _firestore
        .collection(_collection)
        .doc(apiaryId)
        .update({'hiveCount': FieldValue.increment(-1)});
  }
}