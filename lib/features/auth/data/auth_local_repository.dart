import 'package:allonsvite/features/auth/domain/models/auth_user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/exceptions/failure.dart';

class AuthLocalRepository {
  final FlutterSecureStorage _storage;
  final SharedPreferences _prefs;
  static const _tokenKey = 'auth_token';
  static const _phoneKey = 'phone_number';
  static const _profileCompletedKey = 'is_profile_completed';

  const AuthLocalRepository(this._storage,this._prefs);
  /// Sauvegarde le token d'authentification
  Future<Either<Failure, Unit>> saveToken(String token) async {
    try {
      await _storage.write(
        key: _tokenKey,
        value: token,
        iOptions: const IOSOptions(accessibility: KeychainAccessibility.first_unlock),
      );
      return right(unit);
    } catch (e) {
      return left(Failure('Erreur lors de la sauvegarde du token: $e'));
    }
  }

  /// Récupère le token d'authentification
// Récupère le token
  // Retourne Option<String> : Soit Some(token), soit None (pas de token)
  Future<Option<String>> getToken() async {
    try {
      final token = await _storage.read(key: _tokenKey);
      return Option.fromNullable(token);
    } catch (e) {
      return const Option.none();
    }
  }

  /// Sauvegarde le numéro de téléphone
  Future<Either<Failure, Unit>> savePhone(String phone) async {
    try {
      await _storage.write(key: _phoneKey, value: phone);
      return right(unit);
    } catch (e) {
      return left(Failure('Erreur lors de la sauvegarde du numéro: $e'));
    }
  }

  /// Récupère le numéro de téléphone
  Future<Either<Failure, String?>> getPhone() async {
    try {
      final phone = await _storage.read(key: _phoneKey);
      return right(phone);
    } catch (e) {
      return left(Failure('Erreur lors de la récupération du numéro: $e'));
    }
  }

  /// Supprime toutes les données d'authentification
  Future<Either<Failure, Unit>> clearAuth() async {
    try {
      await _storage.delete(key: _tokenKey);
      await _storage.delete(key: _phoneKey);
      return right(unit);
    } catch (e) {
      return left(Failure('Erreur lors de la suppression des données: $e'));
    }
  }

  /// Vérifie si l'utilisateur est authentifié
  Future<Either<Failure, bool>> isAuthenticated() async {
    try {
      final token = await _storage.read(key: _tokenKey);
      return right(token != null && token.isNotEmpty);
    } catch (e) {
      return left(Failure('Erreur lors de la vérification de l\'authentification: $e'));
    }
  }
  Future<void> setProfileComplete(bool isComplete) async {
    await _prefs.setBool(_profileCompletedKey, isComplete);
  }
  bool isProfileComplete() {
    return _prefs.getBool(_profileCompletedKey) ?? false;
  }

  Future<void> saveUser(AuthUser user) async {
   // sauvegarde dans SecureStorage
    await _storage.write(key: 'user_id', value: user.id.toString());
    await _storage.write(key: 'user_firstname', value: user.firstname);
    await _storage.write(key: 'user_phone', value: user.phone);
  }
}

