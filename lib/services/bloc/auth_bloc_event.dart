part of 'auth_bloc.dart';

@immutable
sealed class AuthBlocEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class AuthEventInitialize extends AuthBlocEvent {
  @override
  List<Object> get props => [];
}

final class AuthEventLogin extends AuthBlocEvent {
  final String email;
  final String password;
  AuthEventLogin(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

final class AuthEventRegister extends AuthBlocEvent {
  final String name;
  final String email;
  final String password;
  final String password2;
  AuthEventRegister(this.name, this.email, this.password, this.password2);

  @override
  List<Object> get props => [email, password];
}

final class AuthEventLogout extends AuthBlocEvent {
  @override
  List<Object> get props => [];
}
