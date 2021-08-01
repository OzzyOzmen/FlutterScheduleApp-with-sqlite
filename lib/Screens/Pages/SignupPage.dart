import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:ozzyschedule/Datebase/UserHelper/UserHelper.dart';
import 'package:ozzyschedule/Models/Users/Users.dart';
import 'package:ozzyschedule/widgets/custom_date_time_picker.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String _userName;
  String _userPassword;
  String _userFullName;
  String _userDayOfBirth;
  String _userPhoneNumber;
  String _userEmail;
  String _userGender = "Chose Your Gender";
  String _userPhoto;
  bool _userStatus;

  DateTime _today = DateTime.now();

  //var userRoles = ["Admin", "User"];

  Future _pickDate() async {
    DateTime datepick = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime.now().add(Duration(days: -29200)),
        lastDate: new DateTime.now().add(Duration(days: 365)));
    if (datepick != null)
      setState(() {
        _today = datepick;
        _userDayOfBirth = _today.toString().substring(0, 10);
      });
  }

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
                  Padding(padding: EdgeInsets.fromLTRB(5, 50, 5, 5)),
                  new Image(
                      image: new AssetImage("assets/images/Logo.png"),
                      width: 150,
                      height: 150),
                  Padding(padding: EdgeInsets.fromLTRB(5, 35, 5, 5)),
                  new TextFormField(
                      decoration: const InputDecoration(
                        icon: const Icon(Icons.person, color: Colors.red),
                        hintText: 'Enter your user name',
                        labelText: 'User Name',
                      ),
                      keyboardType: TextInputType.text,
                      onChanged: (String value) {
                        setState(() {
                          _userName = value.toLowerCase();
                        });
                      }),
                  new TextFormField(
                      decoration: const InputDecoration(
                        icon: const Icon(Icons.vpn_key, color: Colors.red),
                        hintText: 'Enter your password',
                        labelText: 'Password',
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: (String value) {
                        setState(() {
                          _userPassword = value;
                        });
                      }),
                  new TextFormField(
                      decoration: const InputDecoration(
                        icon: const Icon(Icons.person, color: Colors.red),
                        hintText: 'Enter your full name',
                        labelText: 'Full Name',
                      ),
                      keyboardType: TextInputType.text,
                      onChanged: (String value) {
                        setState(() {
                          _userFullName = value;
                        });
                      }),
                  CustomDateTimePicker(
                    icon: Icons.date_range,
                    onPressed: _pickDate,
                    value: new DateFormat("dd-MM-yyyy").format(_today),
                  ),
                  new TextFormField(
                      decoration: const InputDecoration(
                        icon: const Icon(Icons.phone, color: Colors.red),
                        hintText: 'Enter a phone number',
                        labelText: 'Phone',
                      ),
                      keyboardType: TextInputType.phone,
                      inputFormatters: [],
                      onChanged: (String value) {
                        setState(() {
                          _userPhoneNumber = value;
                        });
                      }),
                  new TextFormField(
                      decoration: const InputDecoration(
                        icon: const Icon(Icons.email, color: Colors.red),
                        hintText: 'Enter a email address',
                        labelText: 'Email',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (String value) {
                        setState(() {
                          _userEmail = value;
                        });
                      }),
                  new Row(
                    children: <Widget>[
                      Container(
                          padding: const EdgeInsets.only(top: 15),
                          child: Icon(
                            MdiIcons.humanMaleFemale,
                            color: Colors.red,
                          )),
                      Container(
                        padding: const EdgeInsets.only(top: 15, left: 15),
                        child: DropdownButton(
                          value: _userGender,
                          items: <String>['Chose Your Gender', 'Male', 'Female']
                              .map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(
                                value,
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                            );
                          }).toList(),
                          onChanged: (d) {
                            setState(() {
                              _userGender = d;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                  new Container(
                    padding: const EdgeInsets.only(left: 0.0, top: 35.0),
                    child: FlatButton.icon(
                      color: Colors.red,
                      icon: Icon(Icons.check, color: Colors.white),
                      label: Text(
                        'Sign Up',
                      ),
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.red)),
                      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                      onPressed: () {
                        _userPhoto = "Ozzy.jpg";
                        _userStatus = true;
                        userSignUp();
                        Navigator.pushNamed(context, '/SignInPage');
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 0.0, top: 5.0),
                    child: OutlineButton.icon(
                        color: Colors.red,
                        icon: Icon(Icons.priority_high, color: Colors.red),
                        label: Text(
                          'Already Member ?',
                        ),
                        textColor: Colors.red,
                        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.red)),
                        onPressed: () {
                          Navigator.pushNamed(context, '/SignInPage');
                        }),
                  )
                ],
              ))),
    ));
  }

  void userSignUp() {
    UserHelper userHelper = new UserHelper();
    Users user = new Users(
        _userName,
        _userPassword,
        _userFullName,
        _userDayOfBirth,
        _userPhoneNumber,
        _userEmail,
        _userGender,
        _userPhoto,
        _userStatus.toString());

    try {
      if (_userName != null &&
          _userPassword != null &&
          _userFullName != null &&
          _userDayOfBirth != null &&
          _userPhoneNumber != null &&
          _userEmail != null &&
          _userGender != null) {
        userHelper.addUser(user);
      } else {
        fieldError();
      }
    } catch (e) {
      e.toString();
    }
  }

  Future<void> fieldError() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ups !! Incomplete required fields ',
              style: TextStyle(color: Colors.red)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    ' Please make sure all required fields are filled out correctly'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}


