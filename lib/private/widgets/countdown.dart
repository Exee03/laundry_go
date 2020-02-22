import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:countdown_flutter/countdown_flutter.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry_go/blocs/washing/washing_bloc.dart';
import 'package:laundry_go/models/machine.dart';
import 'package:laundry_go/providers/theme.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class CountdownWidget extends StatefulWidget {
  final Machine machine;
  final String animation;
  final int startSec;
  final int durationSec;
  final int endSec;
  final int remain;
  const CountdownWidget(
      {Key key,
      @required this.machine,
      @required this.animation,
      @required this.startSec,
      @required this.durationSec,
      @required this.endSec,
      @required this.remain})
      : super(key: key);

  @override
  _CountdownWidgetState createState() => _CountdownWidgetState();
}

class _CountdownWidgetState extends State<CountdownWidget> {
  Timer _timer;
  int timestamp;
  double nowSec = 1;

  void setTime(Timer timer) {
    setState(() {
      timestamp = Timestamp.now().millisecondsSinceEpoch;
    });
  }

  @override
  void initState() {
    super.initState();
    timestamp = Timestamp.now().millisecondsSinceEpoch;
    _timer = Timer.periodic(const Duration(seconds: 1), setTime);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    nowSec = (timestamp ~/ 1000).toDouble();

    final customWidth01 = CustomSliderWidths(
        trackWidth: 2, progressBarWidth: 10, shadowWidth: 20);

    final customColors01 = CustomSliderColors(
        dotColor: Colors.white.withOpacity(0.8),
        trackColor: Colors.grey.withOpacity(0.5),
        progressBarColors: [secondaryColor, widgetColor, primaryColor],
        shadowColor: secondaryColor,
        shadowStep: 10.0,
        shadowMaxOpacity: 0.6);

    final CircularSliderAppearance appearance01 = CircularSliderAppearance(
        customWidths: customWidth01,
        customColors: customColors01,
        startAngle: 270,
        angleRange: 360,
        size: 350.0,
        animationEnabled: false);

    if (nowSec == widget.endSec) {
      BlocProvider.of<WashingBloc>(context).add(StopWashing());
      _timer.cancel();
    }
    return Container(
      height: height,
      width: width,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Center(
            child: SleekCircularSlider(
              appearance: appearance01,
              min: widget.startSec.toDouble(),
              max: widget.endSec.toDouble(),
              initialValue: nowSec,
              innerWidget: (double value) {
                return Container(
                  width: width,
                  height: height,
                  child: Center(
                    child: Hero(
                      tag: 'washing${widget.machine.id}',
                      child: FlareActor('assets/washing.flr',
                          fit: BoxFit.contain, animation: widget.animation),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: width + 100),
            child: CountdownFormatted(
              duration: Duration(milliseconds: widget.remain),
              builder: (BuildContext context, String remaining) => Text(
                remaining,
                style: Theme.of(context)
                    .textTheme
                    .headline
                    .copyWith(fontSize: 40, fontWeight: FontWeight.w200),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
