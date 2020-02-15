import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry_go/blocs/authentication/authentication_bloc.dart';
import 'package:laundry_go/blocs/login/login_bloc.dart';
import 'package:laundry_go/repositories/user_repository.dart';
import 'package:laundry_go/providers/theme.dart';

class LoginScreen extends StatefulWidget {
  final UserRepository _userRepository;

  LoginScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  // String _email, _password, _name;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _studentIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  LoginBloc _loginBloc;

  UserRepository get _userRepository => widget._userRepository;

  bool get isLoginPopulated =>
      _studentIdController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty;

  bool get isRegisterPopulated =>
      _nameController.text.isNotEmpty &&
      _studentIdController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _confirmPasswordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState state) {
    return state.isLoginFormValid && isLoginPopulated && !state.isSubmitting;
  }

  bool isRegisterButtonEnabled(LoginState state) {
    return state.isRegisterFormValid && isLoginPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _nameController.addListener(_onNameChanged);
    _studentIdController.addListener(_onStudentIdChanged);
    _passwordController.addListener(_onConfirmPasswordChanged);
    _confirmPasswordController.addListener(_onConfirmPasswordChanged);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _studentIdController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onNameChanged() {
    _loginBloc.add(
      NameChanged(name: _nameController.text),
    );
  }

  void _onStudentIdChanged() {
    _loginBloc.add(
      StudentIdChanged(studentId: _studentIdController.text),
    );
  }

  // void _onPasswordChanged() {
  //   _loginBloc.add(
  //     PasswordChanged(password: _passwordController.text),
  //   );
  // }

  void _onConfirmPasswordChanged() {
    _loginBloc.add(
      ConfirmPasswordChanged(
          password: _passwordController.text,
          confirmPassword: _confirmPasswordController.text),
    );
  }

  void _onSwitchForm() {
    _nameController.clear();
    _studentIdController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
    _loginBloc.add(SwitchForm());
  }

  void _onLoginFormSubmitted() {
    final form = formKey.currentState;
    form.save();
    FocusScope.of(context).unfocus();
    _loginBloc.add(
      LoginWithCredentialsPressed(
        studentId: _studentIdController.text,
        password: _passwordController.text,
      ),
    );
  }

  void _onRegisterFormSubmitted() {
    final form = formKey.currentState;
    form.save();
    FocusScope.of(context).unfocus();
    _loginBloc.add(
      Submitted(
        name: _nameController.text,
        studentId: int.parse(_studentIdController.text),
        password: _passwordController.text,
      ),
    );
  }

  // void submit() async {
  //   final form = formKey.currentState;
  //   form.save();
  //   BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
  //   // try {
  //   //   final auth = Provider.of(context).auth;
  //   //   if (authFormType == AuthFormType.signIn) {
  //   //     String uid = await auth.signInWithEmailAndPassword(_email, _password);
  //   //     print("Signed In with ID $uid");
  //   //     Navigator.of(context).pushReplacementNamed('/home');
  //   //   } else {
  //   //     String uid =
  //   //         await auth.createUserWithEmailAndPassword(_email, _password, _name);
  //   //     print("Signed up with New ID $uid");
  //   //     Navigator.of(context).pushReplacementNamed('/home');
  //   //   }
  //   // } catch (e) {
  //   //   print(e);
  //   // }
  // }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        height: _height,
        width: _width,
        decoration: BoxDecoration(
          gradient: new LinearGradient(
            colors: [primaryColor, secondaryColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.2, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.isFailure) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('Login Failure'), Icon(Icons.error)],
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
            }
            if (state.isSubmitting) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Logging In...'),
                        CircularProgressIndicator(),
                      ],
                    ),
                  ),
                );
            }
            if (state.isSuccess) {
              BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
            }
          },
          child: SafeArea(
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state.isIntro) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: _height * 0.10),
                        Text(
                          "Welcome",
                          style: TextStyle(fontSize: 44, color: Colors.white),
                        ),
                        SizedBox(height: _height * 0.10),
                        Expanded(
                          child: AutoSizeText(
                            "Let's making your laundry Better!",
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        RaisedButton(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0,
                                  bottom: 10.0,
                                  left: 30.0,
                                  right: 30.0),
                              child: Text(
                                "Get Started",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                            onPressed: () => _loginBloc.add(BeginSignIn())),
                        SizedBox(height: _height * 0.10),
                      ],
                    ),
                  );
                } else {
                  return ListView(
                    children: <Widget>[
                      SizedBox(height: _height * 0.1),
                      buildHeaderText(state),
                      SizedBox(height: _height * 0.1),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: buildInputs(state) + buildButtons(state),
                          ),
                        ),
                      )
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHeaderText(LoginState state) {
    String _headerText;
    if (state.isRegister) {
      _headerText = "Create New Account";
    } else {
      _headerText = "Sign In";
    }
    return AutoSizeText(
      _headerText,
      maxLines: 1,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headline.copyWith(color: Colors.white),
    );
  }

  List<Widget> buildInputs(LoginState state) {
    List<Widget> textFields = [];
    if (state.isRegister) {
      textFields.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Theme(
            data: ThemeData(primaryColor: Colors.white),
            child: TextFormField(
              controller: _nameController,
              style: TextStyle(color: Colors.white),
              decoration: buildSignUpInputDecoration("Name", Icons.person),
              validator: (_) {
                return !state.isNameValid ? 'Invalid Name' : null;
              },
            ),
          ),
        ),
      );
      textFields.add(SizedBox(height: 20));
    }
    textFields.add(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Theme(
            data: ThemeData(primaryColor: Colors.white),
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: _studentIdController,
              style: TextStyle(color: Colors.white),
              decoration:
                  buildSignUpInputDecoration("Student ID", Icons.credit_card),
              validator: (_) {
                return !state.isStudentIdValid ? 'Invalid Student ID' : null;
              },
            )),
      ),
    );
    textFields.add(SizedBox(height: 20));
    textFields.add(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Theme(
          data: ThemeData(primaryColor: Colors.white),
          child: TextFormField(
            controller: _passwordController,
            style: TextStyle(color: Colors.white),
            decoration: buildSignUpInputDecoration("Password", Icons.lock),
            obscureText: true,
            validator: (_) {
              return !state.isPasswordValid ? 'Invalid Password' : null;
            },
          ),
        ),
      ),
    );
    textFields.add(SizedBox(height: 20));
    if (state.isRegister) {
      textFields.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Theme(
            data: ThemeData(primaryColor: Colors.white),
            child: TextFormField(
              controller: _confirmPasswordController,
              style: TextStyle(color: Colors.white),
              decoration:
                  buildSignUpInputDecoration("Confirm Password", Icons.lock),
              obscureText: true,
              validator: (_) {
                return !state.isPasswordSame ? 'Password do not match' : null;
              },
            ),
          ),
        ),
      );
      textFields.add(SizedBox(height: 20));
    }
    return textFields;
  }

  InputDecoration buildSignUpInputDecoration(String hint, IconData icon) {
    return InputDecoration(
      icon: Icon(icon),
      labelText: hint,
      labelStyle: TextStyle(color: Colors.white),
      focusColor: Colors.white,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(25.7),
      ),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: Colors.white)),
      // contentPadding:
      //     const EdgeInsets.only(left: 14.0, bottom: 10.0, top: 10.0),
    );
  }

  List<Widget> buildButtons(LoginState state) {
    String _switchButtonText, _submitButtonText;
    if (!state.isRegister) {
      _switchButtonText = "Create New Account";
      _submitButtonText = "Sign In";
    } else {
      _switchButtonText = "Have an Account? Sign In";
      _submitButtonText = "Sign Up";
    }
    return [
      Container(
        width: MediaQuery.of(context).size.width * 0.7,
        child: RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          color: Colors.white,
          textColor: primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _submitButtonText,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300),
            ),
          ),
          onPressed: (!state.isRegister)
              ? (isLoginButtonEnabled(state) ? _onLoginFormSubmitted : null)
              : (isRegisterButtonEnabled(state)
                  ? _onRegisterFormSubmitted
                  : null),
        ),
      ),
      FlatButton(
        padding: EdgeInsets.only(top: 30),
        child: Text(
          _switchButtonText,
          style: TextStyle(color: Colors.white),
        ),
        onPressed: _onSwitchForm,
      ),
    ];
  }
}
