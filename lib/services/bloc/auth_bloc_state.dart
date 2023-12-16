part of 'auth_bloc.dart';

@immutable
sealed class AuthBlocState extends Equatable{}

final class AuthStateUninitialized extends AuthBlocState {//logou screen/builder
  @override
  List<Object?> get props => [];
}

final class AuthStateLoading extends AuthBlocState {//listen 
  final bool isLoading;

  AuthStateLoading({required this.isLoading});

  @override
  List<Object?> get props => [];
}

final class AuthStateAuthenticated extends AuthBlocState {//home /builder
  final UserModel user;

  AuthStateAuthenticated({required this.user});

  @override
  List<Object?> get props => [user];
}

final class AuthStateUnauthenticated extends AuthBlocState {//
  final String errorMsg;

  AuthStateUnauthenticated({required this.errorMsg});

  @override
  List<Object?> get props => [];
}


