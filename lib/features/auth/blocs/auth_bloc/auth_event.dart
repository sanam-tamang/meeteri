part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.signUp(
      {required String email,
      required String password,
      required String username,
      required String gender,
      required UserType userType,
      required String dateOfBirth,
      required String avatar}) = _SignUp;
  const factory AuthEvent.signIn(
      {required String email, required String password}) = _SignIn;
  const factory AuthEvent.signOut() = _SignOut;
}
