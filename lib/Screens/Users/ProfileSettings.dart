import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:ozzyschedule/AppBody.dart';
import 'package:flutter/material.dart';
import 'package:ozzyschedule/Datebase/UserHelper/UserHelper.dart';
import 'package:ozzyschedule/Models/Users/Users.dart';
import 'package:ozzyschedule/Screens/Pages/SignInPage.dart';
import 'package:ozzyschedule/widgets/custom_date_time_picker.dart';

class ProfileSettings extends StatefulWidget {
  Users user;

  ProfileSettings(this.user);
  @override
  _ProfileSettingsState createState() => _ProfileSettingsState(user);
}

class _ProfileSettingsState extends State<ProfileSettings> {
  Users user;
  _ProfileSettingsState(this.user);

  String _userName;
  String _userPassword;
  String _userFullName;
  DateTime _userDayOfBirth;
  String _userPhoneNumber;
  String _userEmail;
  String _userGender = "Chose Your Gender";
  String _userPhoto;
  bool _userStatus;

  TextEditingController userId;
  TextEditingController userName;
  TextEditingController userPassword;
  TextEditingController userFullName;
  TextEditingController userDateOfBirth;
  TextEditingController userPhoneNumber;
  TextEditingController userEmail;
  TextEditingController userGender;
  TextEditingController userPhoto;
  TextEditingController userStatus;

  @override
  void initState() {
    super.initState();

    userId = new TextEditingController(text: '${SignInPageState.userId}');
    userName = new TextEditingController(text: '${SignInPageState.userName}');
    userPassword =
        new TextEditingController(text: '${SignInPageState.userPassword}');
    userFullName =
        new TextEditingController(text: '${SignInPageState.userFullName}');
    userDateOfBirth =
        new TextEditingController(text: '${SignInPageState.userDayOfBirth}');
    userPhoneNumber =
        new TextEditingController(text: '${SignInPageState.userPhoneNumber}');
    userEmail = new TextEditingController(text: '${SignInPageState.userEmail}');
    userPhoto = new TextEditingController(text: '${SignInPageState.userPhoto}');
    userGender =
        new TextEditingController(text: '${SignInPageState.userGender}');
    userStatus =
        new TextEditingController(text: '${SignInPageState.userStatus}');

    if (userName.text != null) {
      _userName = userName.text;
    }
    if (userPassword.text != null) {
      _userPassword = userPassword.text;
    }
    if (userFullName.text != null) {
      _userFullName = userFullName.text;
    }

    var parsedDate = DateTime.parse(userDateOfBirth.text);

    if (userDateOfBirth.text != null) {
      _userDayOfBirth = parsedDate;
    } else {
      _userDayOfBirth = DateTime.now();
    }

    if (userPhoneNumber.text != null) {
      _userPhoneNumber = userPhoneNumber.text;
    }

    if (userEmail.text != null) {
      _userEmail = userEmail.text;
    }
    if (userPhoto.text != null) {
      _userPhoto = userPhoto.text;
    }

    if (userGender.text != null) {
      _userGender = userGender.text;
    } else {
      _userGender = "Chose Your Gender";
    }

    // if (userStatus.text == "true") {
    //   _userStatus = true;
    // }
    // if (userStatus.text == "false") {
    //   _userStatus = false;
    // }
  }

  Future _pickDate() async {
    DateTime datepick = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime.now().add(Duration(days: -365)),
        lastDate: new DateTime.now().add(Duration(days: 365)));
    if (datepick != null) {
      setState(() {
        _userDayOfBirth = datepick;
      });
    } else {
      setState(() {
        datepick = _userDayOfBirth;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: AppBody(
      body: new SafeArea(
          top: false,
          bottom: false,
          child: new Form(
              autovalidate: true,
              child: new ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: <Widget>[
                  Padding(padding: EdgeInsets.fromLTRB(5, 50, 5, 5)),
                  CircleAvatar(
                    maxRadius: 100,
                    minRadius: 50,
                    child: ClipOval(
                      child: Image.asset(
                        "assets/images/Ozzy.jpg",
                        fit: BoxFit.fill,
                        height: 200,
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(5, 25, 5, 5)),
                  new TextFormField(
                      decoration: const InputDecoration(
                        icon: const Icon(
                          Icons.person,
                          color: Colors.red,
                        ),
                        hintText: 'Enter your full name',
                        labelText: 'Name',
                      ),
                      controller: userFullName),
                  CustomDateTimePicker(
                    icon: Icons.date_range,
                    onPressed: _pickDate,
                    value: new DateFormat("dd-MM-yyyy").format(_userDayOfBirth),
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(
                        Icons.phone,
                        color: Colors.red,
                      ),
                      hintText: 'Enter a phone number',
                      labelText: 'Phone',
                    ),
                    controller: userPassword,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [],
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(
                        Icons.email,
                        color: Colors.red,
                      ),
                      hintText: 'Enter a email address',
                      labelText: 'Email',
                    ),
                    controller: userEmail,
                    keyboardType: TextInputType.emailAddress,
                  ),
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
                          items: <String>[
                            'Choose Your Gender',
                            'Male',
                            'Female'
                          ].map((String value) {
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
                            print(d);
                          },
                        ),
                      )
                    ],
                  ),
                  new Container(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: FlatButton.icon(
                      color: Colors.red,
                      icon: Icon(Icons.check, color: Colors.white),
                      label: Text(
                        'Update Profile',
                      ),
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.red)),
                      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                      onPressed: () {
                        updateUser();
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ))),
    ));
  }

  void updateUser() async {
    try {
      // int _userId = int.parse("${userId.text}");
      int _userId = SignInPageState.userId;

      UserHelper userHelper = new UserHelper();
      Users user = Users.byId(
          _userId,
          _userName,
          _userPassword,
          _userFullName,
          _userDayOfBirth.toString(),
          _userPhoneNumber,
          _userEmail,
          _userGender,
          _userPhoto,
          _userStatus.toString());

      await userHelper.updateUser(user);
    } catch (e) {
      e.toString();
    }
  }
}
