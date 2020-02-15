part of 'login_bloc.dart';

@immutable
class LoginState {
  final bool isIntro;
  final bool isNameValid;
  final bool isStudentIdValid;
  final bool isPasswordValid;
  final bool isPasswordSame;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final bool isRegister;

  bool get isLoginFormValid => isStudentIdValid && isPasswordValid;

  bool get isRegisterFormValid => isNameValid && isStudentIdValid && isPasswordValid && isPasswordSame;

  LoginState({
    @required this.isIntro,
    @required this.isNameValid,
    @required this.isStudentIdValid,
    @required this.isPasswordValid,
    @required this.isPasswordSame,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
    @required this.isRegister,
  });

  factory LoginState.empty() {
    return LoginState(
      isIntro: true,
      isNameValid: true,
      isStudentIdValid: true,
      isPasswordValid: true,
      isPasswordSame: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      isRegister: false,
    );
  }

  factory LoginState.loading() {
    return LoginState(
      isIntro: false,
      isNameValid: true,
      isStudentIdValid: true,
      isPasswordValid: true,
      isPasswordSame: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
      isRegister: false,
    );
  }

  factory LoginState.failure() {
    return LoginState(
      isIntro: false,
      isNameValid: true,
      isStudentIdValid: true,
      isPasswordValid: true,
      isPasswordSame: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
      isRegister: false,
    );
  }

  factory LoginState.success() {
    return LoginState(
      isIntro: false,
      isNameValid: true,
      isStudentIdValid: true,
      isPasswordValid: true,
      isPasswordSame: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
      isRegister: false,
    );
  }

  LoginState update({
    bool isIntro,
    bool isNameValid,
    bool isStudentIdValid,
    bool isPasswordValid,
    bool isPasswordSame,
    bool isRegister,
  }) {
    return copyWith(
      isIntro: isIntro,
      isNameValid: isNameValid,
      isStudentIdValid: isStudentIdValid,
      isPasswordValid: isPasswordValid,
      isPasswordSame: isPasswordSame,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      isRegister: isRegister,
    );
  }

  LoginState copyWith({
    bool isIntro,
    bool isNameValid,
    bool isStudentIdValid,
    bool isPasswordValid,
    bool isPasswordSame,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
    bool isRegister,
  }) {
    return LoginState(
      isIntro: isIntro ?? this.isIntro,
      isNameValid: isNameValid ?? this.isNameValid,
      isStudentIdValid: isStudentIdValid ?? this.isStudentIdValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isPasswordSame: isPasswordSame ?? this.isPasswordSame,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      isRegister: isRegister ?? this.isRegister,
    );
  }

  @override
  String toString() {
    return '''LoginState {
      isIntro: $isIntro,
      isNameValid: $isNameValid,
      isStudentIdValid: $isStudentIdValid,
      isPasswordValid: $isPasswordValid,
      isPasswordSame: $isPasswordSame,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
      isRegister: $isRegister,
    }''';
  }
}

