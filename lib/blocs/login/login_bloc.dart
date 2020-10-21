import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laundry_go/providers/validators.dart';
import 'package:laundry_go/repositories/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository _userRepository;
  bool isRegister = false;
  bool isIntro = true;

  LoginBloc({
    @required UserRepository userRepository,
  })  : assert(userRepository != null),
        _userRepository = userRepository,
        super(LoginState.empty());

  // LoginState get initialState => LoginState.empty();

  @override
  Stream<Transition<LoginEvent, LoginState>> transformEvents(
    events,
    transitionFn,
  ) {
    final nonDebounceStream = events.where((event) {
      return (event is! StudentIdChanged && event is! PasswordChanged);
    });
    final debounceStream = events.where((event) {
      return (event is StudentIdChanged || event is PasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      transitionFn,
    );
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is BeginSignIn) {
      yield* _mapBeginSignInToState();
    } else if (event is NameChanged) {
      yield* _mapNameChangedToState(event.name);
    } else if (event is StudentIdChanged) {
      yield* _mapStudentIdChangedToState(event.studentId);
    } else if (event is ConfirmPasswordChanged) {
      yield* _mapConfirmPasswordChangedToState(
          event.password, event.confirmPassword);
    } else if (event is LoginWithCredentialsPressed) {
      yield* _mapLoginWithCredentialsPressedToState(
        studentId: event.studentId,
        password: event.password,
      );
    } else if (event is SwitchForm) {
      yield* _mapSwitchFormToState();
    } else if (event is Submitted) {
      yield* _mapFormSubmittedToState(
          event.name, event.studentId, event.password);
    }
  }

  Stream<LoginState> _mapBeginSignInToState() async* {
    isIntro = !isIntro;
    yield state.update(
      isIntro: isIntro,
    );
  }

  Stream<LoginState> _mapNameChangedToState(String name) async* {
    yield state.update(
      isNameValid: Validators.isValidName(name),
    );
  }

  Stream<LoginState> _mapStudentIdChangedToState(String studentId) async* {
    yield state.update(
      isStudentIdValid: Validators.isValidStudentId(studentId),
    );
  }

  Stream<LoginState> _mapConfirmPasswordChangedToState(
      String password, String confirmPassword) async* {
    yield state.update(
      isPasswordValid: Validators.isValidPassword(password),
      isPasswordSame: Validators.isSamePassword(password, confirmPassword),
    );
  }

  Stream<LoginState> _mapLoginWithCredentialsPressedToState({
    String studentId,
    String password,
  }) async* {
    yield LoginState.loading();
    try {
      await _userRepository.signInWithEmailAndPassword(
          studentId: int.parse(studentId), password: password);
      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }

  Stream<LoginState> _mapSwitchFormToState() async* {
    isRegister = !isRegister;
    yield state.update(
      isRegister: isRegister,
    );
  }

  Stream<LoginState> _mapFormSubmittedToState(
    String name,
    int studentId,
    String password,
  ) async* {
    yield LoginState.loading();
    try {
      await _userRepository.createUserWithEmailAndPassword(
        name: name,
        studentId: studentId,
        password: password,
      );
      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }
}
