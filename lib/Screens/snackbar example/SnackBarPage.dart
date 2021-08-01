import 'package:flutter/material.dart';

class SnackBarPage extends StatefulWidget {
  SnackBarPage({Key key}) : super(key: key);

  @override
  _SnackBarPageState createState() => _SnackBarPageState();
}

class _SnackBarPageState extends State<SnackBarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            margin: EdgeInsets.all(50),
            child: Builder(
                builder: (context) => FlatButton(
                      child: Text("Tıkla"),
                      onPressed: () {
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text("Snacbarrrr")));
                        print("tiklaniyor");
                      },
                    ))));
  }
}
