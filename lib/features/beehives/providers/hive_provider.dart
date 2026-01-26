// lib/features/beehives/providers/hive_provider.dart

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import '../models/beehive_model.dart';
import '../models/beehive_image_model.dart';
import '../services/hive_service.dart';

class HiveProvider extends ChangeNotifier {
  final HiveService _hiveService = HiveService();

  List<Beehive> _beehives = [];
  Beehive? _selectedBeehive;
  bool _isLoading = false;
  String? _error;
  StreamSubscription? _subscription;

  // Getters
  List<Beehive> get beehives => _beehives;
  Beehive? get selectedBeehive => _selectedBeehive;
  bool get isLoading => _isLoading;
  String? get error => _error;
  int get totalBeehives => _beehives.length;

  // Stats getters
  int get healthyCount => _beehives.where((h) => h.healthStatus == HealthStatus.healthy).length;
  int get queenlessCount => _beehives.where((h) => !h.hasQueen).length;
  int get sickCount => _beehives.where((h) => h.healthStatus == HealthStatus.sick || h.healthStatus == HealthStatus.critical).length;

  // Initialize stream for an apiary
  void initBeehives(String apiaryId, String userId) {
    _isLoading = true;
    notifyListeners();

    _subscription?.cancel();
    _subscription = _hiveService.getBeehivesStream(apiaryId, userId).listen(
      (beehives) {
        _beehives = beehives;
        _isLoading = false;
        _error = null;
        notifyListeners();
      },
      onError: (e) {
        _error = e.toString();
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  // Add beehive
  Future<bool> addBeehive({
    required Beehive beehive,
    required String userId,
    List<File>? imageFiles,
  }) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      // Create beehive with userId
      final newBeehive = beehive.copyWith(
        userId: userId,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Add to Firestore
      final docId = await _hiveService.addBeehive(newBeehive);

      // Upload images if any
      if (imageFiles != null && imageFiles.isNotEmpty) {
        for (int i = 0; i < imageFiles.length; i++) {
          final imageType = beehive.images.length > i 
              ? beehive.images[i].type 
              : ImageType.general;
          
          await _hiveService.uploadImage(
            userId: userId,
            beehiveId: docId,
            imageFile: imageFiles[i],
            type: imageType,
          );
        }
      }

      // Update apiary hive count
      await _hiveService.updateApiaryHiveCount(beehive.apiaryId, 1);

      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Update beehive
  Future<bool> updateBeehive(Beehive beehive) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final updatedBeehive = beehive.copyWith(updatedAt: DateTime.now());
      await _hiveService.updateBeehive(updatedBeehive);

      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Delete beehive
  Future<bool> deleteBeehive(String beehiveId, String apiaryId) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _hiveService.deleteBeehive(beehiveId);
      await _hiveService.updateApiaryHiveCount(apiaryId, -1);

      // Clear selected if deleted
      if (_selectedBeehive?.id == beehiveId) {
        _selectedBeehive = null;
      }

      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Add image to beehive
  Future<BeehiveImage?> addImage({
    required String userId,
    required String beehiveId,
    required File imageFile,
    required ImageType type,
    String? note,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      final image = await _hiveService.uploadImage(
        userId: userId,
        beehiveId: beehiveId,
        imageFile: imageFile,
        type: type,
        note: note,
      );

      return image;
    } catch (e) {
      _error = e.toString();
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Delete image
  Future<bool> deleteImage(String beehiveId, BeehiveImage image) async {
    try {
      await _hiveService.deleteImage(beehiveId, image);
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    }
  }

  // Select beehive
  void selectBeehive(Beehive? beehive) {
    _selectedBeehive = beehive;
    notifyListeners();
  }

  // Get beehive by ID
  Beehive? getBeehiveById(String id) {
    try {
      return _beehives.firstWhere((h) => h.id == id);
    } catch (e) {
      return null;
    }
  }

  // Get next system number
  Future<int> getNextSystemNumber(String apiaryId) async {
    return await _hiveService.getNextSystemNumber(apiaryId);
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }

  // Clear beehives (when changing apiary)
  void clearBeehives() {
    _beehives = [];
    _selectedBeehive = null;
    _subscription?.cancel();
    notifyListeners();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
