import 'package:countdown_flutter/countdown_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:laundry_go/blocs/machine/machine_bloc.dart';
import 'package:laundry_go/models/machine.dart';
import 'package:laundry_go/models/user.dart';
import 'package:laundry_go/providers/theme.dart';

class MachineCard extends StatelessWidget {
  const MachineCard({
    Key key,
    @required this.machine,
    @required this.user,
    @required this.lastUsed,
    @required this.remain,
  }) : super(key: key);

  final Machine machine;
  final User user;
  final String lastUsed;
  final int remain;

  @override
  Widget build(BuildContext context) {
    final TextStyle captionTextStyle =
        Theme.of(context).textTheme.caption.copyWith(fontSize: 15);
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: (!machine.isUsed)
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.greenAccent[700], Colors.greenAccent],
                )
              : (machine.user == user.uid)
                  ? LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [primaryColor, secondaryColor],
                    )
                  : LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.grey, Colors.grey],
                    ),
        ),
        child: GridTile(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('No: ${machine.id}'),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    child: Hero(
                      tag: 'washing${machine.id}',
                      child: Icon(
                        MaterialCommunityIcons.washing_machine,
                        size: 60,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: (!machine.isUsed)
                          ? buildCardContent(
                              captionTextStyle, 'Last used:', lastUsed)
                          : (remain < 0)
                              ? buildCardContent(captionTextStyle, 'Status:',
                                  'Waiting for unload...')
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Remaining:'),
                                    Align(
                                      alignment: Alignment.center,
                                      child: CountdownFormatted(
                                        onFinish: () => BlocProvider.of<MachineBloc>(context).add(MachineRefresh()),
                                        duration:
                                            Duration(milliseconds: remain),
                                        builder: (BuildContext context,
                                                String remaining) =>
                                            Text(
                                          remaining,
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption
                                              .copyWith(fontSize: 15),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column buildCardContent(TextStyle textStyle, String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title),
        Align(
          alignment: Alignment.center,
          child: Text(
            subtitle,
            style: textStyle,
          ),
        ),
      ],
    );
  }
}
