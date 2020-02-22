import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry_go/blocs/machine/machine_bloc.dart';
import 'package:laundry_go/blocs/washing/washing_bloc.dart';
import 'package:laundry_go/main.dart';
import 'package:laundry_go/models/machine.dart';
import 'package:laundry_go/models/user.dart';
import 'package:laundry_go/private/screens/washing.dart';
import 'package:laundry_go/private/widgets/machine_card.dart';
import 'package:laundry_go/providers/theme.dart';
import 'package:laundry_go/public/splash_screen.dart';
import 'package:laundry_go/repositories/machine_repository.dart';
import 'package:time_formatter/time_formatter.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  final User user;
  final MachineRepository machineRepository;
  const HomeScreen(
      {Key key, @required this.user, @required this.machineRepository})
      : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Completer<void> _refreshCompleter;
  Color doorCardColor = CupertinoColors.activeOrange;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    _refreshCompleter = Completer<void>();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return BlocListener<MachineBloc, MachineState>(
      listener: (context, state) async {
        if (state is MachineLoaded) {
          _refreshCompleter?.complete();
          _refreshCompleter = Completer();
        } else if (state is MachineError) {
          RestartWidget.restartApp(context);
        }
      },
      child: RefreshIndicator(
        backgroundColor: widgetColor,
        color: Colors.white,
        key: _refreshIndicatorKey,
        onRefresh: () {
          BlocProvider.of<MachineBloc>(context).add(MachineRefresh());
          return _refreshCompleter.future;
        },
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(40),
              constraints:
                  BoxConstraints.expand(height: height * 0.35, width: width),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Welcome to,',
                    style: new TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()..shader = linearGradient),
                  ),
                  Container(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Image.asset('assets/logo.png'),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: BlocBuilder<MachineBloc, MachineState>(
                  builder: (context, state) {
                    if (state is MachineLoading) {
                      return buildLoadingCards();
                    } else if (state is MachineLoaded) {
                      return buildMachineCards(state);
                    }
                    return SplashScreen();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  GridView buildMachineCards(MachineLoaded state) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20),
      gridDelegate:
          new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: state.machines.length,
      itemBuilder: (context, index) {
        Machine machine = state.machines[index];
        String lastUsed = formatTime(
            (machine.timestampStart * 1000) + (machine.duration ~/ 60000));
        int now = Timestamp.now().millisecondsSinceEpoch;
        int remain =
            (machine.duration * 60000) - (now - machine.timestampStart);
        return InkWell(
          onTap: () => ((machine.user == widget.user.uid) && machine.isUsed)
              ? (remain < 0)
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider<WashingBloc>(
                          create: (context) => WashingBloc(
                              machineRepository: widget.machineRepository,
                              user: widget.user)
                            ..add(DoneWashing()),
                          child: WashingScreen(machine: machine),
                        ),
                      ),
                    )
                  : Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider<WashingBloc>(
                          create: (context) => WashingBloc(
                              machineRepository: widget.machineRepository,
                              user: widget.user)
                            ..add(DoneStart(machine)),
                          child: WashingScreen(machine: machine),
                        ),
                      ),
                    )
              : (!machine.isUsed)
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider<WashingBloc>(
                          create: (context) => WashingBloc(
                              machineRepository: widget.machineRepository,
                              user: widget.user)
                            ..add(MachineSelected(machine.id)),
                          child: WashingScreen(machine: machine),
                        ),
                      ),
                    )
                  : null,
          child: MachineCard(
              machine: machine,
              user: widget.user,
              lastUsed: lastUsed,
              remain: remain),
        );
      },
    );
  }

  GridView buildLoadingCards() {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20),
      gridDelegate:
          new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: 4,
      itemBuilder: (context, index) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) => Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    loadingColor
                        .evaluate(AlwaysStoppedAnimation(_controller.value)),
                    loadingColor
                        .evaluate(AlwaysStoppedAnimation(_controller.value))
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
