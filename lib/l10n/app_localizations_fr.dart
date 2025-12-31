// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get helloWorld => 'Bonjour le monde';

  @override
  String get slogan => 'Chap Chap';

  @override
  String get phoneLoginTitle => 'Entrez vos coordonnées';

  @override
  String get phoneLoginSubtitle =>
      'Entrez votre numéro de téléphone, nous vous enverrons un code de vérification';

  @override
  String get sendCode => 'Envoyer le code de vérification';

  @override
  String get phoneNumber => 'Numéro de téléphone';

  @override
  String get verificationCodePlaceholder => 'Entrez le code de vérification';

  @override
  String get verificationCodeTitle => 'Entrez le code de vérification';

  @override
  String get sendCodeAgain => 'Renvoyer le code';

  @override
  String get sendYouSMS => 'Nous vous avons envoyé un SMS';

  @override
  String get resendCode => 'Renvoyer le code dans';

  @override
  String get verificationCode => 'Code de vérification';

  @override
  String get verifyCode => 'Vérifier le code';

  @override
  String get pleaseEnterYourVerificationCode =>
      'Veuillez saisir le code que nous venons d\'envoyer au ';

  @override
  String get name => 'Nom';

  @override
  String get firstName => 'Prénom';

  @override
  String get lastName => 'Nom de famille';

  @override
  String get email => 'E-mail';

  @override
  String get password => 'Mot de passe';

  @override
  String get confirmPassword => 'Confirmez le mot de passe';

  @override
  String get createAccount => 'Créer un compte';

  @override
  String get next => 'Suivant';

  @override
  String get alreadyHaveAccount => 'Vous avez déjà un compte ?';

  @override
  String get login => 'Connexion';

  @override
  String get logout => 'Déconnexion';

  @override
  String get profile => 'Profil';

  @override
  String get settings => 'Paramètres';

  @override
  String get byCreatingAccount => 'En créant un compte, vous acceptez nos';

  @override
  String get termsOfService => 'Conditions d\'utilisation';

  @override
  String get termOfUs => 'Conditions d\'utilisation';

  @override
  String get and => 'et';

  @override
  String get privacyPolicy => 'Politique de confidentialité';

  @override
  String get forgotPassword => 'Mot de passe oublié ?';

  @override
  String get backToLogin => 'Retour à la connexion';

  @override
  String get shareLocation => 'Partager la position';

  @override
  String get location => 'Position';

  @override
  String get man => 'Homme';

  @override
  String get woman => 'Femme';

  @override
  String get addPhoto => 'Ajouter une photo';

  @override
  String get uploadPhoto => 'Télécharger une photo';

  @override
  String get addProfilePicture => 'Ajouter une photo de profil';

  @override
  String get uploadProfilePicture => 'Télécharger une photo de profil';

  @override
  String get takeASelfie => 'Prendre un selfie';

  @override
  String get chooseFormGallery => 'Choisir dans la galerie';

  @override
  String get takeAPhoto => 'Prendre une photo';

  @override
  String get takePhotoMessage =>
      'Aidez les chauffeurs ou les passagers à vous identifier plus facilement, cela augmente la confiance.';

  @override
  String get welcomeMessage => 'Bienvenue sur mon application';

  @override
  String get loginButton => 'Se connecter';

  @override
  String get trips => 'voyages';

  @override
  String get homeGreetingMessage => 'Que souhaitez-vous faire aujourd\'hui ?';

  @override
  String get today => 'Aujourd\'hui';

  @override
  String get tomorrow => 'Demain';

  @override
  String get person => 'Person';

  @override
  String get people => 'Personnes';

  @override
  String get hello => 'Bonjour';

  @override
  String get searchFromPlaceholder => 'De ?';

  @override
  String get searchToPlaceholder => 'Vers ?';

  @override
  String get howManySeats => 'Combien de sièges voulez-vous ?';

  @override
  String get confirm => 'Confirmer';

  @override
  String get findARide => 'Rechercher un trajet';

  @override
  String get selectDepartureLocationError =>
      'Veuillez sélectionner un lieu de départ';

  @override
  String get selectDestinationError => 'Veuillez sélectionner une destination';

  @override
  String get selectPassengerError =>
      'Veuillez sélectionner au moins un passager';

  @override
  String get noRidesFound => 'Aucun trajet trouvé.';

  @override
  String get seats => 'Sièges';

  @override
  String get passenger => 'Passager';

  @override
  String get passengers => 'Passagers';

  @override
  String get availableRides => 'TRAJETS DISPONIBLES';

  @override
  String get bookRide => 'RÉSERVER UN TRAJET';

  @override
  String get departure => 'Départ';

  @override
  String get from => 'DE';

  @override
  String get to => 'À';

  @override
  String get pickUp => 'RAMASSAGE';

  @override
  String get dropOff => 'DÉPOSE';

  @override
  String get start => 'Début';

  @override
  String get end => 'Fin';

  @override
  String get driver => 'Chauffeur';

  @override
  String get totalPrice => 'Prix total';

  @override
  String errorPrefix(String error) {
    return 'Erreur : $error';
  }
}
