import 'package:equatable/equatable.dart';

sealed class Failure extends Equatable {}

class InternetFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class ServerError extends Failure {
  final String statusCode;

  ServerError(this.statusCode);
  @override
  String toString() {
    return "$statusCode Error";
  }

  @override
  List<Object?> get props => [];
}

class FailureWithMessage extends Failure {
  final String? message;
  FailureWithMessage(this.message);
  @override
  String toString() {
    return "$message";
  }

  @override
  List<Object?> get props => [];
}
