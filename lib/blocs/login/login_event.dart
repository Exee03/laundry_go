part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object> get props => [];
}

class BeginSignIn extends LoginEvent {}

class NameChanged extends LoginEvent {
  final String name;

  const NameChanged({@required this.name});

  @override
  List<Object> get props => [name];

  @override
  String toString() => 'NameChanged { name :$name }';
}

class StudentIdChanged extends LoginEvent {
  final String studentId;

  const StudentIdChanged({@required this.studentId});

  @override
  List<Object> get props => [studentId];

  @override
  String toString() => 'StudentIdChanged { studentId :$studentId }';
}

class PasswordChanged extends LoginEvent {
  final String password;

  const PasswordChanged({@required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

class ConfirmPasswordChanged extends LoginEvent {
  final String password;
  final String confirmPassword;

  const ConfirmPasswordChanged({@required this.password, @required this.confirmPassword});

  @override
  List<Object> get props => [confirmPassword];

  @override
  String toString() => 'ConfirmPasswordChanged { confirmPassword: $confirmPassword, password: $password }';
}
class LoginWithCredentialsPressed extends LoginEvent {
  final String studentId;
  final String password;

  const LoginWithCredentialsPressed({
    @required this.studentId,
    @required this.password,
  });

  @override
  List<Object> get props => [studentId, password];

  @override
  String toString() {
    return 'LoginWithCredentialsPressed { studentId: $studentId, password: $password }';
  }
}

class SwitchForm extends LoginEvent {}

class Submitted extends LoginEvent {
  final String name;
  final int studentId;
  final String password;

  const Submitted({
    @required this.name,
    @required this.studentId,
    @required this.password,
  });

  @override
  List<Object> get props => [name, studentId, password];

  @override
  String toString() {
    return 'Submitted { name: $name, studentId: $studentId, password: $password }';
  }
}

