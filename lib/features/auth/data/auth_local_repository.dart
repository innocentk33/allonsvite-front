import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpdart/fpdart.dart';

import '../../../core/exceptions/failure.dart';

class AuthLocalRepository {
  final FlutterSecureStorage _storage;
  static const _tokenKey = 'auth_token';
  static const _phoneKey = 'phone_number';

  const AuthLocalRepository(this._storage);

  /// Sauvegarde le token d'authentification
  Future<Either<Failure, Unit>> saveToken(String token) async {
    try {
      await _storage.write(key: _tokenKey, value: token);
      return right(unit);
    } catch (e) {
      return left(Failure('Erreur lors de la sauvegarde du token: $e'));
    }
  }

  /// Récupère le token d'authentification
  Future<Either<Failure, String?>> getToken() async {
    try {
      final token = await _storage.read(key: _tokenKey);
      return right(token);
    } catch (e) {
      return left(Failure('Erreur lors de la récupération du token: $e'));
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
}

