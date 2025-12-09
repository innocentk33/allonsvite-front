import 'package:allonsvite/features/auth/domain/models/auth_response.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../../../core/constant/app_constant.dart';
import '../../../core/exceptions/failure.dart';
import '../domain/models/auth_user.dart';

class AuthRemoteRepository {
  final Dio _dio;

  const AuthRemoteRepository(this._dio);

  /// Demande un code OTP pour le numéro de téléphone
  Future<Either<Failure, Unit>> requestOtp(String phoneNumber) async {
    try {
      final response = await _dio.post(
        AppConstant.auth,
        data: {
          'phone': phoneNumber,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return right(unit);
      } else {
        return left(Failure('Erreur lors de la demande OTP: ${response.statusMessage}'));
      }
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      return left(Failure('Erreur lors de la demande OTP: $e'));
    }
  }

  /// Vérifie le code OTP et retourne l'utilisateur authentifié avec le token
  Future<Either<Failure, AuthResponse>> verifyOtp(String phoneNumber, String otpCode) async {
    try {
      final response = await _dio.post(
        AppConstant.verifyOtp,
        data: {
          'phone': phoneNumber,
          'code': otpCode,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        return right(AuthResponse.fromJson(data));
      } else {
        return left(Failure('Code OTP invalide'));
      }
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      return left(Failure('Erreur lors de la vérification OTP: $e'));
    }
  }

  /// Récupère les informations de l'utilisateur connecté
  Future<Either<Failure, AuthUser>> getCurrentUser(String token) async {
    try {
      final response = await _dio.get(
        AppConstant.user,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        return right(AuthUser.fromJson(data));
      } else {
        return left(Failure('Erreur lors de la récupération des informations'));
      }
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      return left(Failure('Erreur lors de la récupération des informations: $e'));
    }
  }
  Failure _handleDioError(DioException e) {
    if (e.response != null && e.response?.data != null) {
      final data = e.response?.data;
      final message = data['message'] ?? 'Erreur inconnue';
      return Failure(message);
    } else if (e.type == DioExceptionType.badResponse) {
      return Failure(e.message ?? 'Erreur de connexion');
    } else if(e.type == DioExceptionType.connectionTimeout){
      return Failure('Délai de connexion dépassé');
    } else {
      return Failure('Erreur lors de la récupération des informations: $e');
    }

  }
}

