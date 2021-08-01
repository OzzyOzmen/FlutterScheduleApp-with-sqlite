import 'package:flutter/material.dart';
import 'package:ozzyschedule/Datebase/DbHelper.dart';
import 'package:ozzyschedule/Datebase/UserHelper/UserHelper.dart';
import 'package:ozzyschedule/Models/Users/Users.dart';

class SignInPage extends StatefulWidget {
  @override
  State createState() => new SignInPageState();
}

class  SignInPageState extends State<SignInPage>
    with SingleTickerProviderStateMixin {
  DbHelper dbHelper = new DbHelper();
  UserHelper userHelper = new UserHelper();

  static int userId;
  static String userName;
  static String userPassword;
  static String userFullName;
  static String userDayOfBirth;
  static String userPhoneNumber;
  static String userEmail;
  static String userGender;
  static String userPhoto;
  static String userStatus;

  String _userName;
  String _userPassword;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      body: new SafeArea(
          top: false,
          bottom: false,
          child: new Form(
              autovalidate: true,
              child: new ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: <Widget>[
                  Padding(padding: EdgeInsets.fromLTRB(5, 100, 5, 5)),
                  new Image(
                      image: new AssetImage("assets/images/Logo.png"),
                      width: 150,
                      height: 150),
                  Padding(padding: EdgeInsets.fromLTRB(5, 75, 5, 5)),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.person, color: Colors.red),
                      hintText: 'Enter your username',
                      labelText: 'UserName',
                    ),
                    onChanged: (String value) {
                      setState(() {
                        _userName = value.toLowerCase();
                      });
                    },
                  ),
                  new TextFormField(
                      decoration: const InputDecoration(
                        icon: const Icon(Icons.vpn_key, color: Colors.red),
                        hintText: 'Enter your password',
                        labelText: 'Password',
                      ),
                      onChanged: (String value) {
                        setState(() {
                          _userPassword = value;
                        });
                      }),
                  new Container(
                    padding: const EdgeInsets.only(left: 0.0, top: 50.0),
                    child: FlatButton.icon(
                      color: Colors.red,
                      icon: Icon(Icons.check, color: Colors.white),
                      label: Text(
                        'SignIn',
                      ),
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.red)),
                      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                      onPressed: () {
                        var user = userHelper.getUser();
                        user.then((data) {
                          List<Users> userlist = List<Users>();

                          for (var i = 0; i < data.length; i++) {
                            userlist.add(Users.fromObject(data[i]));
                          }
                          if (userlist.length >= 1) {
                            for (var item in userlist) {
                              if (_userName == item.userName &&
                                  _userPassword == item.userPassword) {
                                userId = item.userId;
                                userName = item.userName;
                                userPassword = item.userPassword;
                                userFullName = item.userFullName;
                                userDayOfBirth = item.userDayOfBirth;
                                userPhoneNumber = item.userPhoneNumber;
                                userEmail = item.userEmail;
                                userGender = item.userGender;
                                userPhoto = item.userPhoto;
                                userStatus = item.userStatus;
                                Navigator.pushNamed(context, '/home');
                              } else {
                                print(
                                    "Username or Password is wrong !!! Pls try again");
                              }
                            }
                          } else {
                            print("There is no any  registered user");
                          }
                        });
                      },
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.only(left: 0.0, top: 10.0),
                      child: FlatButton.icon(
                          color: Colors.red,
                          icon: Icon(Icons.people_outline, color: Colors.white),
                          label: Text(
                            'SignUp',
                          ),
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.red)),
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                          onPressed: () {
                          

                            Navigator.pushNamed(context, '/SignupPage');
                          })),
                  Container(
                    padding: const EdgeInsets.only(left: 0.0, top: 5.0),
                    child: OutlineButton.icon(
                        color: Colors.red,
                        icon: Icon(Icons.priority_high, color: Colors.red),
                        label: Text(
                          'Lost Password ?',
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.red)),
                        textColor: Colors.red,
                        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        onPressed: () {
                          Navigator.pushNamed(context, '/LostPassword');
                        }),
                  )
                ],
              ))),
    ));
  }

  
}
