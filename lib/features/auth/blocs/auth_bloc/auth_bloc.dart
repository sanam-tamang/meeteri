import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '/common/enum.dart';
import '/core/failure/failure.dart';
import '/features/auth/repositories/auth_repository.dart';
part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final BaseAuthRepository _repository;
  AuthBloc({required BaseAuthRepository repository})
      : _repository = repository,
        super(const _Initial()) {
    on<AuthEvent>((event, emit) async {
    await  event.map(
          signUp: (event) async =>await _signUp(event, emit),
          signIn: (event)async =>await _signIn(event, emit),
          signOut: (event) async=> await _signOut(event, emit));
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
        log("user is $failureOrSuccess");

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

   Future<void> _signOut(_SignOut event, Emitter<AuthState> emit) async {

    //TODO:: need to implement later
   }
}
