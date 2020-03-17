import 'package:flutter/material.dart';
import 'package:campfire/consts/common_values.dart';

class CampfirePage extends StatefulWidget {
  @override
  _CampfirePageState createState() => _CampfirePageState();
}

class _CampfirePageState extends State<CampfirePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("CAMPFIRE", style: TextStyle(fontSize: txtSizeTopTitle),),
        elevation: 1.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.filter_list), onPressed: (){},
          ),
        ],
      ),
    );
  }
}
