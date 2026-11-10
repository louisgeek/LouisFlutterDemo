
class ApiResponse<T> {
  final int code;
  final String? msg;
  final T? data;

  ApiResponse({required this.code, this.msg, this.data});

  bool get isSuccess => code == 0;

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json)? fromJsonT,
  ) {
    return ApiResponse(
      code: json['code'],
      msg: json['msg'],
      data: json['data'] != null && fromJsonT != null
          ? fromJsonT(json['data'])
          : null,
    );
  }

  @override
  String toString() {
    return 'ApiResponse{code: $code, msg: $msg, data: $data}';
  }
}
