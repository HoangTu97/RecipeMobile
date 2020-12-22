import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class RegisterState extends Equatable {
  final RegisterForm form;
  final FormzStatus status;

  const RegisterState({
    this.form = const RegisterForm.pure(),
    this.status = FormzStatus.pure,
  });

  RegisterState copyWith({
    RegisterForm form,
    FormzStatus status,
  }) {
    return RegisterState(
      form: form ?? this.form,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [form, status];
}

class RegisterForm with FormzMixin {
  final Username username;
  final Name name;
  final Password password;
  final ConfirmPassword confirmPassword;

  const RegisterForm.pure()
      : this.username = const Username.pure(),
        this.name = const Name.pure(),
        this.password = const Password.pure(),
        this.confirmPassword = const ConfirmPassword.pure();

  RegisterForm({
    this.username = const Username.pure(),
    this.name = const Name.pure(),
    this.password = const Password.pure(),
    this.confirmPassword = const ConfirmPassword.pure(),
  });

  RegisterForm copyWith({
    Username username,
    Name name,
    Password password,
    ConfirmPassword confirmPassword,
  }) {
    return RegisterForm(
      username: username ?? this.username,
      name: name ?? this.name,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }

  @override
  List<FormzInput> get inputs => [username, name, password, confirmPassword];
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

enum NameValidationError { empty }

class Name extends FormzInput<String, NameValidationError> {
  const Name.pure() : super.pure('');
  const Name.dirty([String value = '']) : super.dirty(value);

  @override
  NameValidationError validator(String value) {
    return value?.isNotEmpty == true ? null : NameValidationError.empty;
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

enum ConfirmPasswordValidationError { empty, noMatch }

class ConfirmPassword
    extends FormzInput<String, ConfirmPasswordValidationError> {
  final String password;

  const ConfirmPassword.pure()
      : this.password = '',
        super.pure('');
  const ConfirmPassword.dirty([String value = '', this.password])
      : super.dirty(value);

  @override
  ConfirmPasswordValidationError validator(String value) {
    return value?.isNotEmpty == true
        ? (value == this.password
            ? null
            : ConfirmPasswordValidationError.noMatch)
        : ConfirmPasswordValidationError.empty;
  }
}
