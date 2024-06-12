

import 'package:meeteri/core/failure/failure.dart';

extension RoutePath on String {
  String get path => "/$this";
  String get rootPath => "/";
}

extension FailureMessage on Failure {
  String get getMessage {
    switch (this) {
      case FailureWithMessage():
        return toString();

      case InternetFailure():
        return "No Internet connection!";
      case ServerError():
        return toString();
    }
  }
}
