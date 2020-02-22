import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry_go/blocs/washing/washing_bloc.dart';
import 'package:laundry_go/models/machine.dart';
import 'package:laundry_go/private/widgets/countdown.dart';
import 'package:laundry_go/private/widgets/duration.dart';
import 'package:laundry_go/private/widgets/scan.dart';
import 'package:laundry_go/private/widgets/done_washing.dart';

class WashingScreen extends StatefulWidget {
  final Machine machine;
  const WashingScreen({Key key, this.machine}) : super(key: key);

  @override
  _WashingScreenState createState() => _WashingScreenState();
}

class _WashingScreenState extends State<WashingScreen> {
  Machine _machine;

  @override
  void initState() {
    super.initState();
    _machine = widget.machine;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: BlocBuilder<WashingBloc, WashingState>(
        builder: (context, state) {
          if (state is WashingLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ScanCode) {
            return ScanWidget(listMachine: state.machines);
          } else if (state is SelectDuration) {
            return DurationWidget();
          } else if (state is Washing) {
            return CountdownWidget(
              machine: state.machine,
              animation: state.animation,
              durationSec: state.durationSec,
              endSec: state.endSec,
              remain: state.remain,
              startSec: state.startSec,
            );
          } else if (state is NotifyWashing) {
            return DoneWashingWidget(width: width, height: height, machine: _machine);
          }
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}

