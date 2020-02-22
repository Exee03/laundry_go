import 'package:custom_splash/custom_splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry_go/blocs/authentication/authentication_bloc.dart';
import 'package:laundry_go/blocs/login/login_bloc.dart';
import 'package:laundry_go/blocs/app/app_bloc.dart';
import 'package:laundry_go/blocs/simple_bloc_delegate.dart';
import 'package:laundry_go/private/app.dart';
import 'package:laundry_go/providers/theme.dart';
import 'package:laundry_go/public/login_screen.dart';
import 'package:laundry_go/public/splash_screen.dart';
import 'package:laundry_go/repositories/user_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final UserRepository userRepository = UserRepository();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) => runApp(
      RestartWidget(
        child: BlocProvider<AuthenticationBloc>(
          create: (context) =>
              AuthenticationBloc(userRepository: userRepository)
                ..add(AppStarted()),
          child: App(userRepository: userRepository),
        ),
      ),
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
        imagePath: 'assets/icon(transparent).png',
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
                child: LoginScreen(),
              );
            } else if (state is Authenticated) {
              return BlocProvider<AppBloc>(
                create: (context) => AppBloc()..add(HomeScreenTap()),
                child: AppScreen(user: state.user, userRepository: _userRepository),
              );
            }
            return SplashScreen();
          },
        ),
      ),
    );
  }
}

class RestartWidget extends StatefulWidget {
  RestartWidget({this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>().restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}
