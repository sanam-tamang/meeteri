import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meeteri/common/enum.dart';
import 'package:meeteri/core/failure/failure.dart';
import 'package:meeteri/features/auth/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final BaseAuthRepository _repository;

  AuthBloc({required BaseAuthRepository repository})
      : _repository = repository,
        super(const _Initial()) {
    on<AuthEvent>((event, emit) async {
      event.map(
          signUp: (event) async => _signUp(event, emit),
          signIn: (event) => _signIn(event, emit),
          signOut: (event) => ());
    });
  }

  Future<void> _signUp(_SignUp event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final failureOrSuccess = await _repository.signUp(
        email: event.email,
        password: event.password,
        dateOfBirth: event.dateOfBirth,
        avatar: event.avatar,
        username: event.username,
        gender: event.gender,
        userType: event.userType);

    failureOrSuccess.fold((l) => emit(AuthState.failure(l)),
        (r) => emit(const AuthState.loaded("User register successful")));
  }

  Future<void> _signIn(_SignIn event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final failureOrSuccess = await _repository.signIn(
      email: event.email,
      password: event.password,
    );

    failureOrSuccess.fold((l) => emit(AuthState.failure(l)),
        (r) => emit(const AuthState.loaded("User login")));
  }
}
