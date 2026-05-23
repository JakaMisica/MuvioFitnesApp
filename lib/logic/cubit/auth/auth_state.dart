import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final dynamic user; // Changed User to dynamic
  final bool isGuest;

  const AuthSuccess({required this.user, this.isGuest = false});

  @override
  List<Object?> get props => [user, isGuest];
}

class AuthFailure extends AuthState {
  final String error;

  const AuthFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class AuthNeedsVerification extends AuthState {
  final String email;
  const AuthNeedsVerification(this.email);

  @override
  List<Object?> get props => [email];
}
