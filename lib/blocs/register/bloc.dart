import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';
import 'package:recipes/blocs/auth/bloc.dart';
import 'package:recipes/blocs/auth/event.dart';
import 'package:recipes/repository/index.dart';
import 'package:recipes/services/locator.dart';
import 'package:recipes/services/navigation.dart';

import 'event.dart';
import 'state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  RegisterBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null),
        super(const RegisterState());

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is RegisterUsernameChanged) {
      yield _mapUsernameChangedToState(event, state);
    } else if (event is RegisterNameChanged) {
      yield _mapNameChangedToState(event, state);
    } else if (event is RegisterPasswordChanged) {
      yield _mapPasswordChangedToState(event, state);
    } else if (event is RegisterConfirmPasswordChanged) {
      yield _mapConfirmPasswordChangedToState(event, state);
    } else if (event is RegisterSubmitted) {
      yield* _mapLoginSubmittedToState(event, state);
    }
  }

  RegisterState _mapUsernameChangedToState(
    RegisterUsernameChanged event,
    RegisterState state,
  ) {
    final username = Username.dirty(event.username);
    final form = state.form.copyWith(username: username);
    return state.copyWith(form: form, status: form.status);
  }

  RegisterState _mapNameChangedToState(
    RegisterNameChanged event,
    RegisterState state,
  ) {
    final name = Name.dirty(event.name);
    final form = state.form.copyWith(name: name);
    return state.copyWith(form: form, status: form.status);
  }

  RegisterState _mapPasswordChangedToState(
    RegisterPasswordChanged event,
    RegisterState state,
  ) {
    final password = Password.dirty(event.password);
    final form = state.form.copyWith(password: password);
    return state.copyWith(form: form, status: form.status);
  }

  RegisterState _mapConfirmPasswordChangedToState(
    RegisterConfirmPasswordChanged event,
    RegisterState state,
  ) {
    final confirmPassword =
        ConfirmPassword.dirty(event.password, state.form.password.value);
    final form = state.form.copyWith(confirmPassword: confirmPassword);
    return state.copyWith(form: form, status: form.status);
  }

  Stream<RegisterState> _mapLoginSubmittedToState(
    RegisterSubmitted event,
    RegisterState state,
  ) async* {
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        final token = await userRepository.register(
          username: state.form.username.value,
          password: state.form.password.value,
        );

        authenticationBloc.add(LoggedIn(token: token));

        locator<NavigationService>().pop();

        yield state.copyWith(status: FormzStatus.submissionSuccess);
      } on Exception catch (_) {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
  }
}
