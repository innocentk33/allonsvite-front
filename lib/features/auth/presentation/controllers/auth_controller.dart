import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/auth_providers.dart';
import '../../domain/models/auth_user.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {

  // État initial : AsyncData(null) signifie "Rien à signaler, prêt".
  @override
  FutureOr<void> build() {
    return null;
  }

  /// Méthode pour demander l'OTP (Step 1)
  Future<void> requestOtp(String phone) async {
    state = const AsyncLoading(); // 1. On affiche le loader

    final repo = ref.read(authRepositoryProvider);
    final result = await repo.requestOtp(phone);

    state = result.fold(
          (failure) => AsyncError(failure.message, StackTrace.current), // Cas Erreur
          (success) => const AsyncData(null), // Cas Succès
    );
  }

  /// Méthode pour vérifier l'OTP et se connecter (Step 2)
  /// C'est celle que tu as demandée
  Future<void> verifyOtp(String phone, String code) async {
    // 1. Validation défensive (Optionnel mais recommandé)
    if (code.length < 4) {
      state = AsyncError("Le code doit contenir 4 chiffres", StackTrace.current);
      return;
    }

    // 2. Passage de l'état à "Chargement"
    // L'UI va afficher un CircularProgressIndicator et désactiver le bouton
    state = const AsyncLoading();

    // 3. Appel au Repository
    // Note : On ne fait aucun try/catch ici, car le Repo gère déjà les exceptions
    // et nous retourne un objet "Either" (Soit une Erreur, Soit un Succès).
    final repo = ref.read(authRepositoryProvider);
    final result = await repo.verifyOtpAndLogin(phone, code);

    // 4. Traitement du résultat avec fpdart (.fold)
    // .fold(fonctionSiGauche, fonctionSiDroite)
    result.fold(
          (failure) {
        // GAUCHE (Left) : C'est une AuthFailure (Erreur réseau, code faux, etc.)
        // On met l'état en erreur pour que l'UI affiche une SnackBar rouge.
        state = AsyncError(failure.message, StackTrace.current);
      },
          (success) {
        // DROITE (Right) : C'est un Unit (Succès)
        // Le token est déjà sauvegardé dans le SecureStorage par le Repo.
        // On met l'état en succès.
        // L'UI (via ref.listen) détectera ce changement et naviguera vers le Dashboard.
        state = const AsyncData(null);
      },
    );
  }
  Future<void> createProfile({required String firstName, required String lastName}) async {
    state = const AsyncLoading();

    final repo = ref.read(authRepositoryProvider);
    final result = await repo.completeProfile(firstName: firstName, lastName: lastName);

    state = result.fold(
          (failure) => AsyncError(failure, StackTrace.current),
          (success) => const AsyncData(null),
    );
  }
}

