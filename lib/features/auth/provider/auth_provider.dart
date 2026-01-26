// lib/features/auth/providers/auth_provider.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_models.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  User? _user;
  UserModel? _userModel;
  bool _isLoading = false;
  String? _error;
  StreamSubscription? _authSubscription;

  // Getters
  User? get user => _user;
  UserModel? get userModel => _userModel;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _user != null;
  String? get userId => _user?.uid;

  // Initialize - call this in main.dart
  void init() {
    _authSubscription = _authService.authStateChanges.listen(_onAuthStateChanged);
  }

  Future<void> _onAuthStateChanged(User? user) async {
    _user = user;
    if (user != null) {
      await _fetchUserModel(user.uid);
    } else {
      _userModel = null;
    }
    notifyListeners();
  }

  Future<void> _fetchUserModel(String uid) async {
    try {
      _userModel = await _authService.getUserDocument(uid);
    } catch (e) {
      _error = e.toString();
    }
  }

  // Sign Up
  Future<bool> signUp({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final credential = await _authService.signUp(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        await _authService.createUserDocument(
          uid: credential.user!.uid,
          email: email,
          displayName: displayName,
        );

        await _fetchUserModel(credential.user!.uid);
      }

      return true;
    } on FirebaseAuthException catch (e) {
      _error = _authService.getErrorMessage(e.code);
      return false;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Sign In
  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final credential = await _authService.signIn(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        await _authService.updateLastLogin(credential.user!.uid);
        await _fetchUserModel(credential.user!.uid);
      }

      return true;
    } on FirebaseAuthException catch (e) {
      _error = _authService.getErrorMessage(e.code);
      return false;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Sign Out
  Future<void> signOut() async {
    try {
      _isLoading = true;
      notifyListeners();

      await _authService.signOut();
      _userModel = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Reset Password
  Future<bool> resetPassword(String email) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _authService.resetPassword(email);
      return true;
    } on FirebaseAuthException catch (e) {
      _error = _authService.getErrorMessage(e.code);
      return false;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Update Profile
  Future<bool> updateProfile({
    String? displayName,
    String? photoUrl,
    String? phone,
  }) async {
    if (_userModel == null) return false;

    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final updatedUser = _userModel!.copyWith(
        displayName: displayName,
        photoUrl: photoUrl,
        phone: phone,
      );

      await _authService.updateUserDocument(updatedUser);
      _userModel = updatedUser;

      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Delete Account
  Future<bool> deleteAccount() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _authService.deleteAccount();
      _userModel = null;

      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }
}
