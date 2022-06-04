class ApiResponse<T> {

  final int statusCode;

  final T? data;

  final String? error;

  bool get isSuccess => isSuccessStatusCode(statusCode);

  ApiResponse(this.statusCode, {this.data, this.error});

  bool isSuccessStatusCode(int code) => (code >= 200 && code < 300);
}
