import 'package:flutter/material.dart';
import 'package:campfire/consts/common_values.dart';

class TeamPage extends StatefulWidget {
  static const routeName = '/team_page';
  @override
  _TeamPageState createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("TEAM", style: TextStyle(fontSize: txtSizeTopTitle),),
        elevation: 1.0,
        /*
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search), onPressed: (){},
          ),
        ],
         */
      ),
    );
  }
}
