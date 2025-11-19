class ApiResponse<T> {
  final int statusCode;
  final String message;
  final T? data;

  const ApiResponse({
    required this.statusCode,
    required this.message,
    this.data,
  });

  bool get isSuccess => statusCode >= 200 && statusCode < 300;
}
