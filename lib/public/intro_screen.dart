import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry_go/blocs/login/login_bloc.dart';
import 'package:laundry_go/providers/theme.dart';
import 'package:laundry_go/public/login_screen.dart';
import 'package:laundry_go/repositories/user_repository.dart';

class IntroScreen extends StatelessWidget {
  final UserRepository _userRepository;

  IntroScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: _width,
        height: _height,
        decoration: BoxDecoration(
          gradient: new LinearGradient(
            colors: [primaryColor, secondaryColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.2, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        child: SafeArea(
          child: Padding(
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
                          top: 10.0, bottom: 10.0, left: 30.0, right: 30.0),
                      child: Text(
                        "Get Started",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 28,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) {
                            return BlocProvider<LoginBloc>(
                              create: (context) =>
                                  LoginBloc(userRepository: _userRepository),
                              child:
                                  LoginScreen(),
                            );
                          }),
                        )),
                SizedBox(height: _height * 0.10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
