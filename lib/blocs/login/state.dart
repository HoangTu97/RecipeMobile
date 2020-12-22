import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class LoginState extends Equatable {
  final LoginForm form;
  final FormzStatus status;

  const LoginState({
    this.form = const LoginForm.pure(),
    this.status = FormzStatus.pure,
  });

  LoginState copyWith({
    LoginForm form,
    FormzStatus status,
  }) {
    return LoginState(
      form: form ?? this.form,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [form, status];
}

class LoginForm with FormzMixin {
  final Username username;
  final Password password;

  const LoginForm.pure()
      : this.username = const Username.pure(),
        this.password = const Password.pure();

  LoginForm({
    this.username = const Username.pure(),
    this.password = const Password.pure(),
  });

  LoginForm copyWith({
    Username username,
    Password password,
  }) {
    return LoginForm(
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  @override
  List<FormzInput> get inputs => [username, password];
}

enum UsernameValidationError { empty }

class Username extends FormzInput<String, UsernameValidationError> {
  const Username.pure() : super.pure('');
  const Username.dirty([String value = '']) : super.dirty(value);

  @override
  UsernameValidationError validator(String value) {
    return value?.isNotEmpty == true ? null : UsernameValidationError.empty;
  }
}

enum PasswordValidationError { empty }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordValidationError validator(String value) {
    return value?.isNotEmpty == true ? null : PasswordValidationError.empty;
  }
}
