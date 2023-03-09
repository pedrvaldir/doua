class ErrorException implements Exception {
  String cause;
  ErrorException(this.cause);
}

throwException(String cause) {
  throw new ErrorException(cause);
}