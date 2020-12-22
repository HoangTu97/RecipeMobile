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

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null),
        super(const LoginState());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginUsernameChanged) {
      yield _mapUsernameChangedToState(event, state);
    } else if (event is LoginPasswordChanged) {
      yield _mapPasswordChangedToState(event, state);
    } else if (event is LoginSubmitted) {
      yield* _mapLoginSubmittedToState(event, state);
    }
  }

  LoginState _mapUsernameChangedToState(
    LoginUsernameChanged event,
    LoginState state,
  ) {
    final username = Username.dirty(event.username);
    final form = state.form.copyWith(username: username);
    return state.copyWith(form: form, status: form.status);
  }

  LoginState _mapPasswordChangedToState(
    LoginPasswordChanged event,
    LoginState state,
  ) {
    final password = Password.dirty(event.password);
    final form = state.form.copyWith(password: password);
    return state.copyWith(form: form, status: form.status);
  }

  Stream<LoginState> _mapLoginSubmittedToState(
    LoginSubmitted event,
    LoginState state,
  ) async* {
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        final token = await userRepository.authenticate(
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
