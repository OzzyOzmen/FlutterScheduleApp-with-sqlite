import 'package:flutter/material.dart';
import 'package:ozzyschedule/Screens/Pages/SignInPage.dart';

class NavDrawer extends StatefulWidget {
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  String _userFullName = SignInPageState.userFullName;
  String _userEmail = SignInPageState.userEmail;
  String userPhoto = SignInPageState.userPhoto;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: new ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: new Text("$_userFullName"),
            accountEmail: new Text("$_userEmail"),
            decoration: new BoxDecoration(
                /* image: new DecorationImage(
                   image: new ExactAssetImage('assets/images/lake.jpeg'),
                  fit: BoxFit.cover,
                ),*/
                color: Colors.red),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset("assets/images/$userPhoto"),
              ),
            ),
          ),
          new ListTile(
              leading: Icon(Icons.home),
              title: new Text("Home"),
              onTap: () {
                Navigator.pushNamed(context, '/home');
              }),
              new ListTile(
              leading: Icon(Icons.category),
              title: new Text("Categories"),
              onTap: () {
                Navigator.pushNamed(context, '/CategoryList');
              }),
          new ListTile(
              leading: Icon(Icons.event_note),
              title: new Text("Tasks"),
              onTap: () {
                Navigator.pushNamed(context, '/TaskList');
              }),
          new ListTile(
              leading: Icon(Icons.schedule),
              title: new Text("Events"),
              onTap: () {
                Navigator.pushNamed(context, '/AllEvents');
              }),
          new ListTile(
              leading: Icon(Icons.settings),
              title: new Text("ProfileSettings"),
              onTap: () {
                Navigator.pushNamed(context, '/ProfileSettings');
              }),
          new Divider(),
          new ListTile(
              leading: Icon(Icons.info),
              title: new Text("About"),
              onTap: () {
                Navigator.pushNamed(context, '/AboutUs');
              }),
          new ListTile(
              leading: Icon(Icons.power_settings_new),
              title: new Text("Logout"),
              onTap: () {
                Navigator.pushNamed(context, '/SignInPage');
              }),
        ],
      ),
    );
  }
}
