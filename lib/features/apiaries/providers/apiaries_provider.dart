// lib/features/apiaries/providers/apiaries_provider.dart

import 'dart:async';
import 'package:flutter/material.dart';
import '../models/apiary_model.dart';
import '../services/apiary_service.dart';

class ApiariesProvider extends ChangeNotifier {
  final ApiaryService _apiaryService = ApiaryService();
  
  List<Apiary> _apiaries = [];
  bool _isLoading = false;
  String? _error;
  StreamSubscription? _subscription;

  // Getters
  List<Apiary> get apiaries => _apiaries;
  bool get isLoading => _isLoading;
  String? get error => _error;
  int get totalApiaries => _apiaries.length;

  // Initialize stream for a user
  void initApiaries(String userId) {
    _isLoading = true;
    notifyListeners();

    _subscription?.cancel();
    _subscription = _apiaryService.getApiariesStream(userId).listen(
      (apiaries) {
        _apiaries = apiaries;
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

  // Add apiary
  Future<bool> addApiary({
    required String name,
    required String location,
    required String userId,
    double? latitude,
    double? longitude,
    String? notes,
    String? imageUrl,
  }) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final apiary = Apiary(
        id: '',
        name: name,
        location: location,
        latitude: latitude,
        longitude: longitude,
        notes: notes,
        imageUrl: imageUrl,
        createdAt: DateTime.now(),
        userId: userId,
      );

      await _apiaryService.addApiary(apiary);
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Update apiary
  Future<bool> updateApiary(Apiary apiary) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _apiaryService.updateApiary(apiary);
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Delete apiary
  Future<bool> deleteApiary(String id) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _apiaryService.deleteApiary(id);
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Get apiary by id
  Apiary? getApiaryById(String id) {
    try {
      return _apiaries.firstWhere((a) => a.id == id);
    } catch (e) {
      return null;
    }
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }

  // Dispose subscription
  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}