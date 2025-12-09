import 'package:fpdart/fpdart.dart';

import '../../../core/exceptions/failure.dart';
import '../domain/models/auth_user.dart';
import 'auth_local_repository.dart';
import 'auth_remote_repository.dart';

class AuthRepository {
  final AuthLocalRepository _localRepository;
  final AuthRemoteRepository _remoteRepository;

  const AuthRepository(this._localRepository, this._remoteRepository);

  /// Vérifie si l'utilisateur est déjà authentifié
  Future<Either<Failure, bool>> isAuthenticated() {
    return _localRepository.isAuthenticated();
  }

  /// Récupère le token stocké localement
  Future<Either<Failure, String?>> getToken() {
    return _localRepository.getToken();
  }

  /// Demande un code OTP
  Future<Either<Failure, Unit>> requestOtp(String phoneNumber) async {
    final remoteResult = await _remoteRepository.requestOtp(phoneNumber);
    if (remoteResult.isRight()) {
      return await _localRepository.savePhone(phoneNumber);
    }
    return remoteResult.mapLeft((failure) => failure);
  }

  /// Vérifie le code OTP et authentifie l'utilisateur
  Future<Either<Failure, Unit>> verifyAndLogin(String phone,
      String code,) async {

    final result = await _remoteRepository.verifyOtp(phone, code);

    return await result.fold(
      (failure) async => left(failure),
      (response) async {
        final saveResult = await _localRepository.saveToken(response.accessToken);
        return saveResult;
      },
    );
  }

  /// Récupère l'utilisateur connecté
  Future<Either<Failure, AuthUser>> getCurrentUser() async {
    final tokenResult = await _localRepository.getToken();

    if (tokenResult.isLeft()) {
      final failure = tokenResult.fold((f) => f, (r) => Failure('Unknown'));
      return left(failure);
    }

    final token = tokenResult.fold((f) => '', (t) => t ?? '');
    if (token.isEmpty) {
      return left(Failure('Non authentifié'));
    }

    return await _remoteRepository.getCurrentUser(token);
  }

  /// Déconnexion
  Future<Either<Failure, Unit>> logout() {
    return _localRepository.clearAuth();
  }

  /// Récupère le numéro de téléphone stocké
  Future<Either<Failure, String?>> getPhone() {
    return _localRepository.getPhone();
  }
}

