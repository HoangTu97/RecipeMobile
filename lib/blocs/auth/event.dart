import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';
}

class LoggedIn extends AuthenticationEvent {
  final String token;

  LoggedIn({@required this.token}) : super();

  @override
  String toString() => 'LoggedIn(token: $token)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is LoggedIn && o.token == token;
  }

  @override
  int get hashCode => token.hashCode;
}

class LoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'LoggedOut';
}
