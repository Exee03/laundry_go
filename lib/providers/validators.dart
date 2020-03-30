class Validators {
  static final RegExp _nameRegExp = RegExp(
    r'^[a-zA-Z]+(([,. -][a-zA-Z ])?[a-zA-Z]*)*$',
  );

  static final RegExp _studentIdRegExp = RegExp(
    r'^[0-9]{11}$',
  );

  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  static isValidName(String name) {
    return _nameRegExp.hasMatch(name);
  }

  static isValidStudentId(String studentId) {
    return _studentIdRegExp.hasMatch(studentId);
  }

  static isValidPassword(String password) {
    return _passwordRegExp.hasMatch(password);
  }

  static isSamePassword(String password, String confirmPassword) {
    return password == confirmPassword;
  }
}