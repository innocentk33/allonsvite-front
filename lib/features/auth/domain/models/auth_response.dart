class AuthResponse {
  final bool success;
  final String accessToken;

  AuthResponse({this.success = false, required this.accessToken});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      success: json['success'],
      accessToken: json['access_token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'access_token': accessToken};
  }

  // copyWith method
  AuthResponse copyWith({bool success = false, String? accessToken}) {
    return AuthResponse(
      success: success ,
      accessToken: accessToken ?? this.accessToken,
    );
  }

  @override
  int get hashCode => Object.hash(success, accessToken);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AuthResponse &&
            other.success == success &&
            other.accessToken == accessToken);
  }
}
