class ApiResponse {
  final bool success;
  final List<dynamic> data;

  ApiResponse({
    required this.success,
    this.data = const [],
  });

  factory ApiResponse.fromJson(dynamic json) {
    return ApiResponse(
      success: json['success'],
      data: json['data'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'data': data};
  }

  // copyWith method
  ApiResponse copyWith({bool? success, List<dynamic>? data}) {
    return ApiResponse(
      success: success ?? this.success,
      data: data ?? this.data,
    );
  }

  @override
  int get hashCode => Object.hash(success, data);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ApiResponse &&
            other.success == success &&
            other.data == data);
  }
}
