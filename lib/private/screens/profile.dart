import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry_go/blocs/authentication/authentication_bloc.dart';
import 'package:laundry_go/models/user.dart';

class ProfileScreen extends StatefulWidget {
  final User user;
  const ProfileScreen({Key key, this.user}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(left: width * 0.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // CircleAvatar(
          //   backgroundColor: Colors.white,
          //   radius: width * 0.2,
          //   backgroundImage: NetworkImage(snapshot.data.photoUrl),
          // ),
          SizedBox(height: 30),
          Text(widget.user.name,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25)),
          SizedBox(height: 10),
          Text(widget.user.studentId.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25)),
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.symmetric(horizontal: height * 0.1),
            width: width * 0.5,
            child: RaisedButton(
              color: Colors.redAccent,
              child: Text(
                'Sign Out',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
              },
              // onPressed: () => auth.signOut(),
            ),
          ),
        ],
      ),
    );
  }
}
