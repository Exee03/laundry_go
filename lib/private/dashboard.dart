import 'package:flutter/material.dart';
import 'package:laundry_go/private/tabs/home.dart';
import 'package:laundry_go/private/tabs/profile.dart';
import 'package:laundry_go/providers/theme.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: TabBarView(
          children: [HomeTab(), ProfileTab()],
        ),
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(
              icon: Icon(Icons.home),
            ),
            Tab(
              icon: Icon(Icons.perm_identity),
            )
          ],
          labelColor: primaryColor,
          unselectedLabelColor: Colors.grey,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorPadding: EdgeInsets.all(5.0),
          indicatorColor: primaryColor,
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}