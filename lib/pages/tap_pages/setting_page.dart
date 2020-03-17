import 'package:flutter/material.dart';
import 'package:campfire/consts/common_values.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("SETTING", style: TextStyle(fontSize: txtSizeTopTitle),),
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
