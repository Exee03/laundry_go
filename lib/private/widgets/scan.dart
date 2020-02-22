import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry_go/blocs/washing/washing_bloc.dart';
import 'package:laundry_go/models/machine.dart';
import 'package:laundry_go/providers/theme.dart';
import 'package:qr_mobile_vision/qr_camera.dart';

class ScanWidget extends StatefulWidget {
  final List<Machine> listMachine;
  ScanWidget({Key key, @required this.listMachine}) : super(key: key);

  @override
  _ScanWidgetState createState() => _ScanWidgetState();
}

class _ScanWidgetState extends State<ScanWidget> {
  bool _camState = false;
  String lastCode = '';
  String lastId = '';

  _scanCode() {
    setState(() {
      _camState = true;
    });
  }

  _qrCallback(String id) {
    setState(() {
      _camState = false;
    });
    BlocProvider.of<WashingBloc>(context).add(MachineSelected(id));
  }

  @override
  void initState() {
    super.initState();
    _scanCode();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Stack(
      children: <Widget>[
        Container(
          child: _camState
              ? Center(
                  child: SizedBox(
                    height: height,
                    width: width,
                    child: QrCamera(
                      onError: (context, error) => Center(
                        child: Text(error.toString()),
                      ),
                      qrCodeCallback: (String code) {
                        if (code.substring(9) != 'LaundryGo0' &&
                            code.length != 11) {
                          if (code != lastCode) {
                            invalidCode(code, context);
                          }
                        } else {
                          final id = code.substring(9, 11);
                          final machine = widget.listMachine.singleWhere(
                              (Machine element) => element.id == id);
                          if (machine.isUsed) {
                            if (machine.id != lastId) {
                              lastId = machine.id;
                              return Scaffold.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(
                                  SnackBar(
                                    duration: Duration(seconds: 3),
                                    content: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('This machine is in use'),
                                        Icon(Icons.error)
                                      ],
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                            }
                          } else {
                            return _qrCallback(id);
                          }
                        }
                      },
                    ),
                  ),
                )
              : Center(
                  child: Container(
                      width: width, height: height, color: Colors.black),
                ),
        ),
        Container(
          height: height,
          width: width,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildCloseButton(context),
                buildTitle(context, width),
                Container(
                  height: 300,
                  width: width,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          color: Colors.black26,
                        ),
                      ),
                      Container(
                        width: 300,
                        color: Colors.transparent,
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.black26,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: height / 4,
                  width: width,
                  color: Colors.black26,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Expanded buildTitle(BuildContext context, double width) {
    return Expanded(
      child: Container(
          width: width,
          color: Colors.black26,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Scan QR Code',
                  style: Theme.of(context)
                      .textTheme
                      .headline
                      .copyWith(color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Scan the QR code from washing machine',
                  style: Theme.of(context)
                      .textTheme
                      .body1
                      .copyWith(color: Colors.white),
                ),
              ),
              SizedBox(
                height: 30,
              )
            ],
          )),
    );
  }

  Container buildCloseButton(BuildContext context) {
    return Container(
      height: 48,
      color: Colors.black26,
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: widgetColor),
                width: 40,
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    BlocProvider.of<WashingBloc>(context).drain();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void invalidCode(String code, BuildContext context) {
    lastCode = code;
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: Duration(seconds: 3),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('Invalid QR Code'), Icon(Icons.error)],
          ),
          backgroundColor: Colors.red,
        ),
      );
  }
}
