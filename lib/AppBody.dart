import 'package:flutter/material.dart';
import 'navdrawer.dart';

class AppBody extends StatelessWidget {
  final Widget body ; 
 final String appName="Ozzy Schedule App";

  const AppBody({Key key, this.body}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
  
    return Container(
      child: Scaffold(
          appBar: AppBar(title: Text(appName),
          backgroundColor: Colors.red
        ),
        drawer: NavDrawer(),
        body:  this.body,
      )
    );
  }
}