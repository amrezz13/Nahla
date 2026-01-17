import 'package:flutter/material.dart';
import '../models/apiary_model.dart';

class ApiariesProvider extends ChangeNotifier {
  final List<Apiary> _apiaries = [];

  List<Apiary> get apiaries => _apiaries;

  // Add apiary
  void addApiary(Apiary apiary) {
    _apiaries.add(apiary);
    notifyListeners();
  }

  // Update apiary
  void updateApiary(String id, Apiary updatedApiary) {
    final index = _apiaries.indexWhere((a) => a.id == id);
    if (index != -1) {
      _apiaries[index] = updatedApiary;
      notifyListeners();
    }
  }

  // Delete apiary
  void deleteApiary(String id) {
    _apiaries.removeWhere((a) => a.id == id);
    notifyListeners();
  }

  // Get apiary by id
  Apiary? getApiaryById(String id) {
    try {
      return _apiaries.firstWhere((a) => a.id == id);
    } catch (e) {
      return null;
    }
  }
}