import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundry_go/providers/theme.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({
    Key key,
  }) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  Color doorCardColor = CupertinoColors.activeOrange;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.all(40),
            constraints: BoxConstraints.expand(height: height * 0.4),
            decoration: BoxDecoration(
              gradient: new LinearGradient(
                colors: [primaryColor, Colors.blueAccent],
                begin: Alignment.bottomCenter,
                end: Alignment.topRight,
                stops: [0.2, 1.0],
                tileMode: TileMode.clamp,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "Hi !\nasdasd",
                            // "Hi !\n${_user.name}",
                            style: TextStyle(
                                fontFamily: 'OpenSans',
                                fontSize: 25.0,
                                color: secondaryColor),
                          ),
                        ),
                        // CircleAvatar(
                        //   backgroundColor: Colors.white,
                        //   radius: width * 0.1,
                        //   backgroundImage: NetworkImage(_user.photoUrl),
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Text(
                    "Dashboard",
                    style: TextStyle(
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )
                ],
              ),
            )),
        Container(
          margin: EdgeInsets.only(top: height * 0.42),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              doorCard(height, width),
              // mailCard(height, width, _user)
            ],
          ),
        ),
      ],
    );
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Oppsss...',
              style: TextStyle(fontSize: 30),
            ),
            content: Container(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10),
                  Text(
                    'There are something with your SiMBOX.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Please contact KoolBox Intelligent (M) Pvt. Ltd. for more infomation.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Close"),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        });
  }

  Card doorCard(double height, double width) {
    return Card(
      margin: EdgeInsets.only(
          bottom: height * 0.03, left: width * 0.1, right: width * 0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: doorCardColor,
      elevation: 10,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed('/doorScreen');
          // if (_doorStatus == 'Unknown') {
          //   _showDialog();
          // } else {
          //   Navigator.of(context).pushNamed('/doorScreen');
          // }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              trailing: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.lock, size: 40),
              ),
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('DOOR',
                    style: TextStyle(
                        color: Colors.white, fontSize: 28.0, letterSpacing: 3)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                  height: 0.5,
                  width: width * 0.8,
                  child: Container(color: Colors.white)),
            ),
            ButtonBar(
              buttonPadding: EdgeInsets.only(bottom: 10.0),
              alignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text('Status:',
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.white, fontSize: 18.0)),
                Text(
                  '  _doorStatus',
                  // '  $_doorStatus',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                )
              ],
            )
            // ButtonTheme.bar(
            //   child: Padding(
            //     padding: const EdgeInsets.only(bottom: 10.0),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceAround,
            //       children: <Widget>[
            //         Text('Status:',
            //             textAlign: TextAlign.right,
            //             style: TextStyle(color: Colors.white, fontSize: 18.0)),
            //         Text('  $_doorStatus',
            //             textAlign: TextAlign.right,
            //             style: TextStyle(
            //                 color: Colors.white,
            //                 fontSize: 18.0,
            //                 fontWeight: FontWeight.bold))
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  // Card mailCard(double height, double width, FirebaseUser user) {
  //   return Card(
  //     margin: EdgeInsets.only(
  //         bottom: height * 0.03, left: width * 0.1, right: width * 0.1),
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(15.0),
  //     ),
  //     color: secondaryColor,
  //     elevation: 10,
  //     child: InkWell(
  //       onTap: () => Navigator.of(context).pushNamed('/mailScreen'),
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: <Widget>[
  //           const ListTile(
  //             trailing: Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Icon(Icons.markunread_mailbox, size: 40),
  //             ),
  //             title: Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Text('MAIL',
  //                   style: TextStyle(
  //                     color: Colors.white,
  //                     fontSize: 28.0,
  //                     letterSpacing: 3,
  //                   )),
  //             ),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.all(10.0),
  //             child: SizedBox(
  //                 height: 0.5,
  //                 width: width * 0.8,
  //                 child: Container(color: Colors.white)),
  //           ),
  //           ButtonTheme.bar(
  //             child: Padding(
  //               padding: const EdgeInsets.only(bottom: 10.0),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                 children: <Widget>[
  //                   Text('Items:',
  //                       textAlign: TextAlign.right,
  //                       style: TextStyle(color: Colors.white, fontSize: 18.0)),
  //                   StreamBuilder(
  //                       stream: Firestore.instance
  //                           .collection("items")
  //                           .where('userUid', isEqualTo: user.uid)
  //                           .snapshots(),
  //                       builder: (context, snapshot) {
  //                         if (!snapshot.hasData) {
  //                           return Center(
  //                             child: CircularProgressIndicator(),
  //                           );
  //                         }
  //                         List data = snapshot.data.documents;
  //                         String itemCount = '0';
  //                         data.forEach((e) => {
  //                               if (e['date'] == dateNow)
  //                                 {itemCount = e['count'].toString()}
  //                             });
  //                         return Text('  $itemCount',
  //                             textAlign: TextAlign.right,
  //                             style: TextStyle(
  //                                 color: Colors.white,
  //                                 fontSize: 18.0,
  //                                 fontWeight: FontWeight.bold));
  //                       }),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
