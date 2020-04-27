import 'package:campfire/pages/join/login_page.dart';
import 'package:campfire/util/language/Translations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:campfire/consts/common_values.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SettingPage extends StatefulWidget {
  static const routeName = '/setting_page';
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final GoogleSignIn _gsi = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("SETTING", style: TextStyle(fontSize: txtSizeTopTitle),),
        elevation: 1.0,
        actions: <Widget>[
          /* 임시로 이곳에 로그아웃버튼 추가 */
          IconButton(
            icon: Icon(Icons.exit_to_app), onPressed: (){

            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  //Translations.of(context).trans('main_center_text')
                  title: Text("로그아웃 하시겠습니까?"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text(Translations.of(context).trans('response_yes')),
                      onPressed: () {
                        setState(() {
                          FirebaseAuth.instance.signOut();
                          _gsi.signOut();
                          Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => LoginPage()));
                        });
                      },
                    ),
                    FlatButton(
                      child: Text(Translations.of(context).trans('response_no')),
                      onPressed: () => Navigator.pop(context, false),
                    ),
                  ],
                ));
            },
          ),
        ],
      ),
    );
  }
}
