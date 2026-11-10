class ApiError {
  final int statusCode;
  final String message;
  
  ApiError({
    required this.statusCode,
    required this.message,
  });
  
  factory ApiError.fromJson(Map<String, dynamic> json) {
    return ApiError(
      statusCode: json['status_code'] ?? 500,
      message: json['message'] ?? 'Unknown error',
    );
  }
}