import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:laundry_go/blocs/authentication/authentication_bloc.dart';
import 'package:laundry_go/blocs/machine/machine_bloc.dart';
import 'package:laundry_go/blocs/washing/washing_bloc.dart';
import 'package:laundry_go/models/user.dart';
import 'package:laundry_go/private/screens/home.dart';
import 'package:laundry_go/blocs/app/app_bloc.dart';
import 'package:laundry_go/private/screens/profile.dart';
import 'package:laundry_go/private/screens/washing.dart';
import 'package:laundry_go/providers/theme.dart';
import 'dart:ui';

import 'package:laundry_go/public/splash_screen.dart';
import 'package:laundry_go/repositories/machine_repository.dart';
import 'package:laundry_go/repositories/user_repository.dart';

class AppScreen extends StatefulWidget {
  final UserRepository userRepository;
  final User user;
  const AppScreen({Key key, this.user, @required this.userRepository})
      : super(key: key);

  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();
  final FirebaseMessaging _fcm = FirebaseMessaging();

  InnerDrawerAnimation _animationType = InnerDrawerAnimation.quadratic;
  double _dragUpdate = 0;
  InnerDrawerDirection _direction = InnerDrawerDirection.start;
  MachineBloc machineBloc;
  MachineRepository machineRepository = MachineRepository();

  @override
  void initState() {
    super.initState();
    machineBloc =
        MachineBloc(machineRepository: machineRepository, user: widget.user);

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // TODO optional
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        // TODO optional
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Color pickerColor = Color(0xff443a49);
  ValueChanged<Color> onColorChanged;

  void _toggle() {
    _innerDrawerKey.currentState.toggle(direction: InnerDrawerDirection.start);
  }

  @override
  Widget build(BuildContext context) {
    return InnerDrawer(
      key: _innerDrawerKey,
      onTapClose: true,
      tapScaffoldEnabled: true,
      leftOffset: 0.4,
      rightOffset: 0.4,
      swipe: true,
      boxShadow: _direction == InnerDrawerDirection.start &&
              _animationType == InnerDrawerAnimation.linear
          ? []
          : null,
      colorTransition: Colors.black54,
      leftAnimationType: InnerDrawerAnimation.quadratic,
      leftChild: BlocListener<AppBloc, AppState>(
        listener: (context, state) {
          if (state is SwitchScreen) {
            _toggle();
          }
        },
        child: Material(
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      ColorTween(
                        begin: Theme.of(context).primaryColor,
                        end: Theme.of(context).primaryColor,
                      ).lerp(_dragUpdate),
                      ColorTween(
                        begin: Theme.of(context).accentColor,
                        end: Theme.of(context).accentColor,
                      ).lerp(_dragUpdate),
                    ],
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            widget.user.name,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                          ),
                          BlocBuilder<AppBloc, AppState>(
                            builder: (context, state) {
                              if (state is ToHomeScreen) {
                                return Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      ListTile(
                                        onTap: () =>
                                            BlocProvider.of<AppBloc>(context)
                                                .add(HomeScreenTap()),
                                        title: Text(
                                          "Home",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                        leading: Icon(
                                          Icons.dashboard,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                      ),
                                      ListTile(
                                        onTap: () =>
                                            BlocProvider.of<AppBloc>(context)
                                                .add(ProfileScreenTap()),
                                        title: Text(
                                          "Profile",
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        leading: Icon(
                                          Icons.rounded_corner,
                                          size: 22,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else if (state is ToProfileScreen) {
                                return Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      ListTile(
                                        onTap: () =>
                                            BlocProvider.of<AppBloc>(context)
                                                .add(HomeScreenTap()),
                                        title: Text(
                                          "Home",
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        leading: Icon(
                                          Icons.dashboard,
                                          size: 22,
                                        ),
                                      ),
                                      ListTile(
                                        onTap: () =>
                                            BlocProvider.of<AppBloc>(context)
                                                .add(ProfileScreenTap()),
                                        title: Text(
                                          "Profile",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                        leading: Icon(
                                          MaterialCommunityIcons.face_profile,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                              return Container();
                            },
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        margin: EdgeInsets.only(top: 50),
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                        width: double.maxFinite,
                        child: CupertinoButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Icon(
                                  Icons.all_out,
                                  size: 18,
                                  color: Colors.black,
                                ),
                                Text(
                                  "  Sign Out",
                                  style: TextStyle(
                                    // fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            onPressed: () =>
                                BlocProvider.of<AuthenticationBloc>(context)
                                    .add(LoggedOut())),
                      ),
                    )
                  ],
                ),
              ),
              _dragUpdate < 1
                  ? BackdropFilter(
                      filter: ImageFilter.blur(
                          sigmaX: (10 - _dragUpdate * 10),
                          sigmaY: (10 - _dragUpdate * 10)),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0),
                        ),
                      ),
                    )
                  : null,
            ].where((a) => a != null).toList(),
          ),
        ),
      ),
      scaffold: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          if (state is ToHomeScreen) {
            return Scaffold(
              floatingActionButton: FloatingActionButton(
                backgroundColor: widgetColor,
                child: Icon(Ionicons.ios_qr_scanner),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider<WashingBloc>(
                      create: (context) => WashingBloc(
                          machineRepository: machineRepository,
                          user: widget.user)
                        ..add(StartScaning()),
                      child: WashingScreen(),
                    ),
                  ),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              body: SafeArea(
                child: Material(
                  color: Colors.white,
                  child: Container(
                    child: BlocProvider<MachineBloc>(
                      create: (context) => machineBloc..add(MachinePreparing()),
                      child: HomeScreen(
                          user: widget.user,
                          machineRepository: machineRepository),
                    ),
                  ),
                ),
              ),
            );
          } else if (state is ToProfileScreen) {
            return Scaffold(
              body: SafeArea(
                child: Material(
                  color: Colors.white,
                  child: Container(
                    child: ProfileScreen(user: widget.user),
                  ),
                ),
              ),
            );
          }
          return SplashScreen();
        },
      ),
      onDragUpdate: (double val, InnerDrawerDirection direction) {
        _direction = direction;
        setState(() => _dragUpdate = val);
      },
    );
  }
}
