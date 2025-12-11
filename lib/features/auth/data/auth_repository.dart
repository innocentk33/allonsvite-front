import 'package:fpdart/fpdart.dart';

import '../../../core/exceptions/failure.dart';
import 'auth_local_repository.dart';
import 'auth_remote_repository.dart';

class AuthRepository {
  final AuthLocalRepository _localRepository;
  final AuthRemoteRepository _remoteRepository;

  const AuthRepository(this._localRepository, this._remoteRepository);
  // Vérification initiale : on regarde juste le local
  Future<Option<String>> checkAuthStatus() => _localRepository.getToken();
  // Vérifie si le profil utilisateur est complet
  Future<bool> checkProfileCompletion() async {
    // On se base sur le cache local pour la rapidité du router
    return _localRepository.isProfileComplete();
  }
  // Vérifie si l'utilisateur est déjà authentifié
  Future<Either<Failure, bool>> isAuthenticated() {
    return _localRepository.isAuthenticated();
  }

  // Récupère le token stocké localement
  Future<Option<String>> getToken() {
    return _localRepository.getToken();
  }

  // Demande un code OTP
  Future<Either<Failure, Unit>> requestOtp(String phoneNumber) async {
    final remoteResult = await _remoteRepository.requestOtp(phoneNumber);
    if (remoteResult.isRight()) {
      return await _localRepository.savePhone(phoneNumber);
    }
    return remoteResult.mapLeft((failure) => failure);
  }

  // Vérifie le code OTP ET récupère le profil
  Future<Either<Failure, Unit>> verifyOtpAndLogin(String phone,
      String code) async {
    final otpResult = await _remoteRepository.verifyOtp(phone, code);
    return otpResult.fold(
          (failure) => left(failure), // Échec OTP
          (authResponse) async {
        // 2. Succès OTP : On sauvegarde le token
        final token = authResponse.accessToken;
        await _localRepository.saveToken(token);
        final userResult = await _remoteRepository.getUser(token);
        return userResult.fold(
              (failure) async {
            // Cas particulier : Le token est bon, mais l'API User échoue (réseau, 500...)
            // Par sécurité, on considère le profil comme incomplet,
            // mais on renvoie quand même "Succès" car l'auth technique a marché.
            // L'utilisateur sera redirigé vers CreateProfile et pourra réessayer.
            await _localRepository.setProfileComplete(false);
            return right(unit);
          },
              (user) async {
            // 4. Succès User
            final isComplete = user.isProfileCompleted;
            await _localRepository.setProfileComplete(isComplete);
            await _localRepository.saveUser(user);
            return right(unit);
          },
        );
      },
    );
  }

  Future<Either<Failure, Unit>> completeProfile({
    required String firstName,
    required String lastName,
  }) async {
    // 1. Récupérer le Token
    final tokenOption = await _localRepository.getToken();

    // 2. Récupérer le numéro de téléphone (sauvegardé à l'étape requestOtp)
    final phoneResult = await _localRepository.getPhone();

    // Si pas de token OU pas de téléphone -> Erreur locale
    if (tokenOption.isNone()) {
      return left(Failure("Utilisateur non authentifié (Token manquant)"));
    }

    // Extraction du téléphone depuis le Either
    String? phone;
    phoneResult.fold((l) => null, (r) => phone = r);

    if (phone == null || phone!.isEmpty) {
      return left(Failure("Numéro de téléphone introuvable en local"));
    }

    // 3. Appel au Remote Repository
    final result = await _remoteRepository.updateProfile(
      token: tokenOption.toNullable()!, // On est sûr qu'il existe ici
      phone: phone!,
      firstName: firstName,
      lastName: lastName,
    );

    return result.fold(
          (failure) => left(failure),
          (updatedUser) async {
        // 4. SUCCÈS : On met à jour le statut local
        await _localRepository.setProfileComplete(true);
        return right(unit);
      },
    );
  }

  // Déconnexion
  Future<Either<Failure, Unit>> logout() {
    return _localRepository.clearAuth();
  }

  // Récupère le numéro de téléphone stocké
  Future<Either<Failure, String?>> getPhone() {
    return _localRepository.getPhone();
  }
}

