import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_state_management/model/user_model.dart';
import 'package:bloc_state_management/services/auth_provider.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final UserAuthProvider userAuthProvider;
  AuthBloc({required this.userAuthProvider}) : super(AuthStateUninitialized()) {
    on<AuthEventInitialize>((event, emit) {
      emit(AuthStateLoading(isLoading: true));
      try {} catch (e) {
        log(e.toString());
      }
      emit(AuthStateLoading(isLoading: false));
    });

    on<AuthEventLogin>((event, emit) async {
      emit(AuthStateLoading(isLoading: true));
      try {
        final email = event.email;
        final password = event.password;

        if (email.isNotEmpty || password.isNotEmpty) {
          final UserModel? user = await userAuthProvider.signInUser(
            email: email,
            password: password,
          );
          if (user != null) {
            emit(AuthStateAuthenticated(user: user));
          } else {
            emit(AuthStateUnauthenticated(errorMsg: 'User login failed!'));
          }
        }
      } catch (e) {
        log(e.toString());
      }
      emit(AuthStateLoading(isLoading: false));
    });

    on<AuthEventRegister>((event, emit) async {
      emit(AuthStateLoading(isLoading: true));
      try {
        final name = event.name;
        final email = event.email;
        final password = event.password;
        final password2 = event.password2;

        if (email.isNotEmpty || password.isNotEmpty) {
          if (email.contains('@gmail.com') && password.length >= 6) {
            final UserModel? user = await userAuthProvider.signUpUser(
                name: name,
                email: email,
                password: password,
                password2: password2);
            if (user != null) {
              emit(AuthStateAuthenticated(user: user));
            } else {
              emit(AuthStateUnauthenticated(
                  errorMsg: 'User registration failed!'));
            }
          }
        }
      } catch (e) {
        log(e.toString());
      }
      emit(AuthStateLoading(isLoading: false));
    });

    on<AuthEventLogout>((event, emit) async {
      emit(AuthStateLoading(isLoading: true));
      try {
        await userAuthProvider.signOutUser();
      } catch (e) {
        log(e.toString());
      }
      emit(AuthStateLoading(isLoading: false));
    });
  }
}
