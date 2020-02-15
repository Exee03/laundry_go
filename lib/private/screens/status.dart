import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundry_go/providers/theme.dart';

class StatusScreen extends StatefulWidget {
  @override
  _StatusScreenState createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> with TickerProviderStateMixin {
  String _doorStatus = '';
  String text = '';
  bool _value = true;
  // DatabaseReference _doorRef;
  // StreamSubscription<Event> _doorSubscription;
  // DatabaseError _error;
  String userUid;

  // @override
  // void initState() {
  //   super.initState();
  //   _doorRef = FirebaseDatabase.instance.reference().child('door');
  //   _doorRef.keepSynced(true);
  //   _doorSubscription = _doorRef.onValue.listen((Event event) {
  //     FirebaseAuth.instance.currentUser().then((user) {
  //       userUid = user.uid;
  //       setState(() {
  //         _error = null;
  //         _doorStatus = getStatusDoor(event.snapshot, userUid) ?? 'syncing...';
  //         if (_doorStatus == 'Lock') {
  //           _value = false;
  //           text = 'Unlock';
  //         } else if (_doorStatus == 'Unlock') {
  //           _value = true;
  //           text = 'Lock';
  //         }
  //       });
  //     });
  //   }, onError: (Object o) {
  //     final DatabaseError error = o;
  //     setState(() {
  //       _error = error;
  //     });
  //   });
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _doorSubscription.cancel();
  // }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: primaryColor),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: buildIcon(),
            ),
            Text('Switch the toggle to',
                textAlign: TextAlign.center, style: TextStyle(fontSize: 25)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(text,
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 40)),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              // child: XlivSwitch(
              //   value: _value,
              //   onChanged: _changeValue,
              // ),
            ),
          ],
        ),
      ),
    );
  }

  Icon buildIcon() {
    if (_value == true) {
      return Icon(Icons.lock_open,
          color: CupertinoColors.activeGreen, size: 100);
    } else {
      return Icon(Icons.lock_outline,
          color: CupertinoColors.destructiveRed, size: 100);
    }
  }

  Future _changeValue(bool value) async {
    String status = 'Lock';
    String reverseStatus = 'Unlock';
    if (value == true) {
      status = 'Unlock';
      reverseStatus = 'Lock';
    }
    // await _doorRef
    //     .child(userUid)
    //     .runTransaction((MutableData mutableData) async {
    //   mutableData.value = {'uid': userUid, 'status': status};
    //   return mutableData;
    // });
    setState(() {
      _value = value;
      _doorStatus = status;
      text = reverseStatus;
    });
  }
}