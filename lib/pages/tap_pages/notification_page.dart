import 'package:flutter/material.dart';
import 'package:campfire/consts/common_values.dart';

class NotificationPage extends StatefulWidget {
  static const routeName = '/notification_page';
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("NOTIFICATION", style: TextStyle(fontSize: txtSizeTopTitle),),
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
