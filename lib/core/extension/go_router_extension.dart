import 'package:go_router/go_router.dart';

/// Extension pour GoRouterState
extension GoRouterExtension on GoRouterState {
  /// Récupère un paramètre de query string
  String? getQueryParam(String key) => uri.queryParameters[key];

  /// Récupère tous les paramètres de query string
  Map<String, String> get queryParams => uri.queryParameters;
}

