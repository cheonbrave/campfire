import 'package:flutter/material.dart';
import 'package:campfire/consts/common_values.dart';

class MatchingPage extends StatefulWidget {
  static const routeName = '/matching_page';
  @override
  _MatchingPageState createState() => _MatchingPageState();
}

class _MatchingPageState extends State<MatchingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("MATCHING", style: TextStyle(fontSize: txtSizeTopTitle),),
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
