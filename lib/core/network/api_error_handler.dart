import 'package:dio/dio.dart';
import '../exceptions/failure.dart';

class ApiErrorHandler {
  static Failure handleDioError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      return Failure(
        'Délai de connexion dépassé. Veuillez vérifier votre connexion internet.',
      );
    }

    if (e.type == DioExceptionType.badResponse) {
      // Try to parse the error message from the backend structure if possible
      try {
        if (e.response != null && e.response!.data != null) {
          final data = e.response!.data;

          // Check for common error fields in your API (e.g., 'message', 'detail', 'error')
          if (data is Map<String, dynamic>) {
            if (data.containsKey('message')) {
              return Failure(data['message']);
            }
            if (data.containsKey('detail')) {
              return Failure(data['detail']);
            }
            if (data.containsKey('error')) {
              return Failure(data['error']);
            }
          }
          return Failure('Erreur serveur: ${e.response?.statusCode}');
        }
      } catch (_) {}

      // Fallback based on status code
      switch (e.response?.statusCode) {
        case 400:
          return Failure('Requête invalide.');
        case 401:
          return Failure('Session expirée. Veuillez vous reconnecter.');
        case 403:
          return Failure('Accès refusé.');
        case 404:
          return Failure('Ressource introuvable.');
        case 500:
          return Failure('Erreur interne du serveur.');
        case 503:
          return Failure('Service indisponible.');
        default:
          return Failure(
            'Une erreur est survenue (${e.response?.statusCode}).',
          );
      }
    }

    if (e.type == DioExceptionType.cancel) {
      return Failure('Requête annulée.');
    }

    if (e.error != null && e.error.toString().contains('SocketException')) {
      return Failure('Pas de connexion internet.');
    }

    return Failure('Une erreur inattendue est survenue.');
  }
}
