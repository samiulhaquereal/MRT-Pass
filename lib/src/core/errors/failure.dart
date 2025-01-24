import 'package:nfcmrt/src/app_config/imports/import.dart';

/// Base Failure class
abstract class Failure extends Equatable {
  const Failure({
    this.name = 'An unexpected error occurred',
    this.code,
    this.error,
  });

  final String name; // Error name or default message
  final String? code; // Error code
  final dynamic error;

  @override
  List<Object?> get props => [name, code, error];

  @override
  String toString() {
    return {
      'name': name,
      'code': code,
      'error': error,
    }.toString();
  }
}

class UnknownError extends Failure {
  const UnknownError (
      dynamic error,
      ) : super(name: 'Unknown Error', code: 'UNKNOWN', error: error);
}