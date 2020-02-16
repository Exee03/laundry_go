import 'package:custom_splash/custom_splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry_go/blocs/authentication/authentication_bloc.dart';
import 'package:laundry_go/blocs/login/login_bloc.dart';
import 'package:laundry_go/blocs/simple_bloc_delegate.dart';
import 'package:laundry_go/private/dashboard.dart';
import 'package:laundry_go/private/screens/status.dart';
import 'package:laundry_go/providers/theme.dart';
import 'package:laundry_go/public/intro_screen.dart';
import 'package:laundry_go/public/login_screen.dart';
import 'package:laundry_go/public/splash_screen.dart';
import 'package:laundry_go/repositories/user_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final UserRepository userRepository = UserRepository();
  runApp(
    BlocProvider<AuthenticationBloc>(
      create: (context) =>
          AuthenticationBloc(userRepository: userRepository)..add(AppStarted()),
      child: App(userRepository: userRepository),
    ),
  );
}

class App extends StatelessWidget {
  final UserRepository _userRepository;

  App({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: buildThemeData(),
      home: CustomSplash(
        imagePath: 'assets/icon.png',
        backGroundColor: Colors.white,
        animationEffect: 'fade-in',
        duration: 2500,
        type: CustomSplashType.StaticDuration,
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is Unauthenticated) {
              // return IntroScreen(userRepository: _userRepository);
              return BlocProvider<LoginBloc>(
              create: (context) => LoginBloc(userRepository: _userRepository),
              child: LoginScreen(userRepository: _userRepository),
            );
            } else if (state is Authenticated) {
              return Dashboard();
            }
            return SplashScreen();
          },
        ),
      ),
      routes: <String, WidgetBuilder>{
        '/loginScreen': (BuildContext context) => BlocProvider<LoginBloc>(
              create: (context) => LoginBloc(userRepository: _userRepository),
              child: LoginScreen(userRepository: _userRepository),
            ),
        '/statusScreen': (BuildContext context) => StatusScreen(),
      },
    );
  }
}
