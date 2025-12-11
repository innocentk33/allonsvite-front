class ApiResponse {
  final bool success;
  final String message;
  final List<dynamic> data;

  ApiResponse({
    required this.success,
    required this.message,
    this.data = const [],
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      success: json['success'],
      message: json['message'],
      data: json['data'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message, 'data': data};
  }

  // copyWith method
  ApiResponse copyWith({bool? success, String? message, List<dynamic>? data}) {
    return ApiResponse(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  @override
  int get hashCode => Object.hash(success, message, data);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ApiResponse &&
            other.success == success &&
            other.message == message &&
            other.data == data);
  }
}
