
import 'package:ozzyschedule/Models/Schedule/Events/Event.dart';
import 'package:ozzyschedule/Models/Users/Users.dart';
import 'package:ozzyschedule/Screens/Category/CategoryList.dart';
import 'package:ozzyschedule/Screens/Event/AllEvents.dart';
import 'package:ozzyschedule/Screens/Event/EventList.dart';
import 'package:ozzyschedule/Screens/Pages/AboutUs.dart';
import 'package:ozzyschedule/Screens/Pages/SignInPage.dart';
import 'package:ozzyschedule/Screens/Pages/SignupPage.dart';
import 'package:ozzyschedule/Screens/Task/TaskList.dart';
import 'package:ozzyschedule/Screens/Users/ProfileSettings.dart';
import 'package:ozzyschedule/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Users user;
  List<Event> event;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ozzy Schedule App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SignInPage(),
        '/home': (homePage) => HomePage(),
        '/CategoryList': (categorylist) => CategoryList(),
        '/TaskList': (tasklist) => TaskList(),
        '/AllEvents': (allevents) => AllEvents(),
        '/EventList': (eventList) => EventList(event),
        '/ProfileSettings': (profileSettings) => ProfileSettings(user),
        '/AboutUs': (aboutUs) => AboutUs(),
        '/SignInPage': (signInPage) => SignInPage(),
        '/SignupPage': (signUpPage) => SignupPage(),
      },
    );
  }


}
