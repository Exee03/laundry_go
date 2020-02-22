import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry_go/blocs/washing/washing_bloc.dart';
import 'package:laundry_go/providers/theme.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class DurationWidget extends StatefulWidget {
  const DurationWidget({Key key}) : super(key: key);

  @override
  _DurationWidgetState createState() => _DurationWidgetState();
}

class _DurationWidgetState extends State<DurationWidget> {

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    int selectedDuration;

    final customWidth01 = CustomSliderWidths(
        trackWidth: 2, progressBarWidth: 20, shadowWidth: 50);

    final customColors01 = CustomSliderColors(
      dotColor: Colors.white.withOpacity(0.8),
      trackColor: primaryColor,
      progressBarColors: [primaryColor, widgetColor, secondaryColor],
      shadowColor: widgetColor,
      shadowMaxOpacity: 0.08,
    );

    final info = InfoProperties(
        bottomLabelStyle: Theme.of(context)
            .textTheme
            .caption
            .copyWith(fontSize: 30, fontStyle: FontStyle.normal),
        bottomLabelText: 'min',
        mainLabelStyle: Theme.of(context)
            .textTheme
            .headline
            .copyWith(fontSize: 60, fontWeight: FontWeight.w200),
        modifier: (double value) {
          int duration = value.toInt();
          final increment = 5;
          final divider = increment / 2;
          if (duration <= 20 + divider) {
            duration = 20;
          } else if (duration > 20 + divider && duration <= 25 + divider) {
            duration = 25;
          } else if (duration > 25 + divider && duration <= 30 + divider) {
            duration = 30;
          } else if (duration > 30 + divider && duration <= 35 + divider) {
            duration = 35;
          } else if (duration > 35 + divider && duration <= 40) {
            duration = 40;
          }
          selectedDuration = duration;
          return duration.toString();
        });

    final CircularSliderAppearance appearance01 = CircularSliderAppearance(
        customWidths: customWidth01,
        customColors: customColors01,
        infoProperties: info,
        startAngle: 180,
        angleRange: 180,
        size: 250.0);

    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          height: height,
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  width: width - 100,
                  child: FlareActor(
                    'assets/washing.flr',
                    fit: BoxFit.contain,
                    animation: "idle",
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                child: Container(
                  width: width,
                  height: width,
                  child: SleekCircularSlider(
                    appearance: appearance01,
                    // min: 1,
                    // max: 10,
                    // initialValue: 5,
                    onChangeStart: (double value) {
                      print(value);
                    },
                    onChangeEnd: (double value) {
                      print(value);
                    },
                    min: 20,
                    max: 40,
                    initialValue: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
          child: SizedBox(
            height: width - 100,
            width: width - 100,
            child: FlatButton(
              // color: Colors.red,
              onPressed: () => BlocProvider.of<WashingBloc>(context)
                  .add(DurationSelected(selectedDuration)),
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: 170.0),
                  child: Text(
                    'START',
                    style: Theme.of(context)
                        .textTheme
                        .headline
                        .copyWith(color: secondaryColor),
                  ),
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(width - 30),
                side: BorderSide(color: Colors.grey.withOpacity(0.5), width: 5),
              ),
            ),
          ),
        )
      ],
    );
  }
}
