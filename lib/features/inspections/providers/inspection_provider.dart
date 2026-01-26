// lib/features/inspections/providers/inspection_provider.dart

import 'dart:io';
import 'package:flutter/foundation.dart';
import '../models/inspection_model.dart';
import '../services/inspection_service.dart';

class InspectionProvider with ChangeNotifier {
  final InspectionService _inspectionService = InspectionService();

  // State
  List<Inspection> _inspections = [];
  Inspection? _selectedInspection;
  bool _isLoading = false;
  String? _error;

  // Getters
  List<Inspection> get inspections => _inspections;
  Inspection? get selectedInspection => _selectedInspection;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasError => _error != null;

  // Filtered getters
  List<Inspection> get inspectionsWithIssues =>
      _inspections.where((i) => i.hasHealthIssues).toList();

  List<Inspection> get inspectionsNeedingFeeding =>
      _inspections.where((i) => i.needsFeeding).toList();

  // === LOAD INSPECTIONS ===
  Future<void> loadInspectionsForBeehive(String beehiveId) async {
    _setLoading(true);
    _clearError();

    try {
      _inspections = await _inspectionService.getInspectionsForBeehive(beehiveId);
      notifyListeners();
    } catch (e) {
      _setError('Failed to load inspections: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> loadInspectionsForApiary(String apiaryId) async {
    _setLoading(true);
    _clearError();

    try {
      _inspections = await _inspectionService.getInspectionsForApiary(apiaryId);
      notifyListeners();
    } catch (e) {
      _setError('Failed to load inspections: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> loadInspectionsForUser(String userId) async {
    _setLoading(true);
    _clearError();

    try {
      _inspections = await _inspectionService.getInspectionsForUser(userId);
      notifyListeners();
    } catch (e) {
      _setError('Failed to load inspections: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> loadRecentInspections(String userId, {int limit = 10}) async {
    _setLoading(true);
    _clearError();

    try {
      _inspections = await _inspectionService.getRecentInspections(
        userId,
        limit: limit,
      );
      notifyListeners();
    } catch (e) {
      _setError('Failed to load recent inspections: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> loadInspectionsByDateRange(
    String userId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    _setLoading(true);
    _clearError();

    try {
      _inspections = await _inspectionService.getInspectionsByDateRange(
        userId,
        startDate,
        endDate,
      );
      notifyListeners();
    } catch (e) {
      _setError('Failed to load inspections by date range: $e');
    } finally {
      _setLoading(false);
    }
  }

  // === SELECT INSPECTION ===
  Future<void> selectInspection(String inspectionId) async {
    _setLoading(true);
    _clearError();

    try {
      _selectedInspection = await _inspectionService.getInspection(inspectionId);
      notifyListeners();
    } catch (e) {
      _setError('Failed to load inspection: $e');
    } finally {
      _setLoading(false);
    }
  }

  void clearSelectedInspection() {
    _selectedInspection = null;
    notifyListeners();
  }

  // === CREATE INSPECTION ===
  Future<String?> createInspection(Inspection inspection) async {
    _setLoading(true);
    _clearError();

    try {
      final inspectionId = await _inspectionService.createInspection(inspection);

      // Reload inspections list
      final createdInspection = await _inspectionService.getInspection(inspectionId);
      if (createdInspection != null) {
        _inspections.insert(0, createdInspection);
        notifyListeners();
      }

      return inspectionId;
    } catch (e) {
      _setError('Failed to create inspection: $e');
      return null;
    } finally {
      _setLoading(false);
    }
  }

  // === UPDATE INSPECTION ===
  Future<bool> updateInspection(Inspection inspection) async {
    _setLoading(true);
    _clearError();

    try {
      await _inspectionService.updateInspection(inspection);

      // Update in local list
      final index = _inspections.indexWhere((i) => i.id == inspection.id);
      if (index != -1) {
        _inspections[index] = inspection.copyWith(updatedAt: DateTime.now());
      }

      // Update selected inspection if it's the same
      if (_selectedInspection?.id == inspection.id) {
        _selectedInspection = inspection.copyWith(updatedAt: DateTime.now());
      }

      notifyListeners();
      return true;
    } catch (e) {
      _setError('Failed to update inspection: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // === DELETE INSPECTION ===
  Future<bool> deleteInspection(String inspectionId) async {
    _setLoading(true);
    _clearError();

    try {
      await _inspectionService.deleteInspection(inspectionId);

      // Remove from local list
      _inspections.removeWhere((i) => i.id == inspectionId);

      // Clear selected if it was deleted
      if (_selectedInspection?.id == inspectionId) {
        _selectedInspection = null;
      }

      notifyListeners();
      return true;
    } catch (e) {
      _setError('Failed to delete inspection: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // === IMAGES ===
  Future<String?> addImage({
    required String inspectionId,
    required String userId,
    required File imageFile,
    required InspectionImageType type,
    String? note,
  }) async {
    _clearError();

    try {
      final imageId = await _inspectionService.uploadInspectionImage(
        inspectionId: inspectionId,
        userId: userId,
        imageFile: imageFile,
        type: type,
        note: note,
      );

      // Reload the inspection to get updated images
      await selectInspection(inspectionId);

      return imageId;
    } catch (e) {
      _setError('Failed to add image: $e');
      return null;
    }
  }

  Future<bool> deleteImage(String inspectionId, InspectionImage image) async {
    _clearError();

    try {
      await _inspectionService.deleteInspectionImage(inspectionId, image);

      // Update selected inspection's images
      if (_selectedInspection?.id == inspectionId) {
        final updatedImages = _selectedInspection!.images
            .where((i) => i.id != image.id)
            .toList();
        _selectedInspection = _selectedInspection!.copyWith(images: updatedImages);
        notifyListeners();
      }

      return true;
    } catch (e) {
      _setError('Failed to delete image: $e');
      return false;
    }
  }

  // === STATISTICS ===
  Future<int> getInspectionCount(String beehiveId) async {
    try {
      return await _inspectionService.getInspectionCountForBeehive(beehiveId);
    } catch (e) {
      return 0;
    }
  }

  Future<Inspection?> getLastInspection(String beehiveId) async {
    try {
      return await _inspectionService.getLastInspectionForBeehive(beehiveId);
    } catch (e) {
      return null;
    }
  }

  // === HELPERS ===
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String message) {
    _error = message;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
  }

  void clearAll() {
    _inspections = [];
    _selectedInspection = null;
    _isLoading = false;
    _error = null;
    notifyListeners();
  }
}