import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
  @override
  List<Object> get props => [];
}

class RegisterUsernameChanged extends RegisterEvent {
  final String username;
  const RegisterUsernameChanged(this.username);
  @override
  List<Object> get props => [username];
}

class RegisterNameChanged extends RegisterEvent {
  final String name;
  const RegisterNameChanged(this.name);
  @override
  List<Object> get props => [name];
}

class RegisterPasswordChanged extends RegisterEvent {
  final String password;
  const RegisterPasswordChanged(this.password);
  @override
  List<Object> get props => [password];
}

class RegisterConfirmPasswordChanged extends RegisterEvent {
  final String password;
  const RegisterConfirmPasswordChanged(this.password);
  @override
  List<Object> get props => [password];
}

class RegisterSubmitted extends RegisterEvent {
  const RegisterSubmitted();
}
