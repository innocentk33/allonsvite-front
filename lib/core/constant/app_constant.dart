class AppConstant {
  static const apiBaseUrl = 'https://allonsvite-api.cactus.ci/api';

  // Auth api endpoints
  static const auth = '/auth'; // demande le code OTP
  static const verifyOtp = '/verify-otp'; // vérifie le code OTP

  // User api endpoints
  static const user = '/me'; // récupère le profil utilisateur
  static const userUpdate = '/me/update'; // met à jour le profil utilisateur

  // Location api endpoints
  static const locations = '/locations'; // récupère les emplacements connus

  static const rides = '/rides'; // recuperes les trajets
  static const createRide = '/rides'; // crée un nouveau trajet
  static const getRide = '/rides/'; // récupère un trajet par ID
}
