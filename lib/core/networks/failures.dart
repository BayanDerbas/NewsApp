import 'package:dio/dio.dart';

class Failure {
  final String message;
  final int? status;

  Failure(this.message, [this.status]);

  @override
  String toString() {
    return 'Failure: (statusCode: $status, message: $message)';
  }

  factory Failure.fromDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return Failure('Connection timeout');
      case DioExceptionType.receiveTimeout:
        return Failure('Receive timeout');
      case DioExceptionType.sendTimeout:
        return Failure('Send timeout');
      case DioExceptionType.badCertificate:
        return Failure('Bad Certificate');
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message = _handleHttpStatus(statusCode, error.response?.statusMessage ?? 'Unknown error');
        return Failure(message, statusCode);
      case DioExceptionType.cancel:
        return Failure('Request was cancelled');
      case DioExceptionType.connectionError:
        return Failure('Connection error occurred');
      case DioExceptionType.unknown:
        return Failure('Unexpected error: ${error.message}');
      default:
        return Failure('Something went wrong');
    }
  }

  static String _handleHttpStatus(int? statusCode, String defaultMessage) {
    switch (statusCode) {
      case 400:
        return 'Bad request (400)';
      case 401:
        return 'Unauthorized (401)';
      case 403:
        return 'Forbidden (403)';
      case 404:
        return 'Not found (404)';
      case 500:
        return 'Internal server error (500)';
      case 503:
        return 'Service unavailable (503)';
      default:
        return defaultMessage;
    }
  }
}