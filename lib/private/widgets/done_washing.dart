import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:laundry_go/models/machine.dart';
import 'package:laundry_go/providers/theme.dart';

class DoneWashingWidget extends StatelessWidget {
  const DoneWashingWidget({
    Key key,
    @required this.width,
    @required this.height,
    @required Machine machine,
  }) : _machine = machine, super(key: key);

  final double width;
  final double height;
  final Machine _machine;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Center(
            child: Center(
              child: Hero(
                tag: 'washing${_machine.id}',
                child: Icon(MaterialCommunityIcons.washing_machine,
                    size: 250, color: Colors.black),
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: width + 100),
              child: Text(
                "Washing is done!\nPlease unload...",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline.copyWith(
                    fontSize: 35,
                    fontWeight: FontWeight.w300,
                    foreground: Paint()..shader = linearGradient),
              )
              )
        ],
      ),
    );
  }
}
