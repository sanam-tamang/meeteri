
import 'package:internet_connection_checker/internet_connection_checker.dart';

sealed class BaseInternetChecker {
  Future<bool> get isConnecsted;
}

class InternetChecker implements BaseInternetChecker {
  final InternetConnectionChecker _internetChecker;

  InternetChecker({required InternetConnectionChecker internetChecker})
      : _internetChecker = internetChecker;
  @override
  Future<bool> get isConnecsted async=>await _internetChecker.hasConnection;
}
