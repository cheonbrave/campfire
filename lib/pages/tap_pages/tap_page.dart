import 'package:campfire/util/language/Translations.dart';
import 'package:flutter/material.dart';
import 'package:campfire/consts/common_values.dart';
import 'package:campfire/pages/tap_pages/team_page.dart';
import 'package:campfire/pages/tap_pages/campfire_page.dart';
import 'package:campfire/pages/tap_pages/matching_page.dart';
import 'package:campfire/pages/tap_pages/notification_page.dart';
import 'package:campfire/pages/tap_pages/setting_page.dart';

class TapPage extends StatefulWidget {
  @override
  _TapPageState createState() => _TapPageState();
}

class _TapPageState extends State<TapPage> {
  // WillPopScope 에서 발생하는 onWillPop 이벤트에 의해 호출될 콜백함수
  Future<bool> _willPopCallback() async {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          //Translations.of(context).trans('main_center_text')
          title: Text(Translations.of(context).trans('question_exit')),
          actions: <Widget>[
            FlatButton(
              child: Text(Translations.of(context).trans('response_yes')),
              onPressed: () => Navigator.pop(context, true),
            ),
            FlatButton(
              child: Text(Translations.of(context).trans('response_no')),
              onPressed: () => Navigator.pop(context, false),
            ),
          ],
        )) ??
        false;
  }

  int _selectedIdx = 0;

  List _pages = [
    TeamPage(),
    CampfirePage(),
    MatchingPage(),
    NotificationPage(),
    SettingPage()
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // will pop scope는 화면이 pop가 발생할때 즉 화면이 distory될때를 감안한 이벤트를 줄수있으며 android의 back버튼 클릭이벤트라고 생각하면된다
        onWillPop: _willPopCallback,
        child: Scaffold(
            body: Center(
              child: _pages[_selectedIdx],
            ),
            bottomNavigationBar: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedItemColor: Color(pointColor),
              unselectedItemColor: Colors.black87,
              onTap: _onTapped,
              currentIndex: _selectedIdx,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(Icons.group_work), title: Text('TEAM', style: TextStyle(fontSize: txtSizeExplain))),
                BottomNavigationBarItem(
                    icon: Icon(Icons.whatshot), title: Text('CAMPFIRE', style: TextStyle(fontSize: txtSizeExplain))),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite_border), title: Text('MATCHING', style: TextStyle(fontSize: txtSizeExplain))),
                BottomNavigationBarItem(
                    icon: Icon(Icons.notifications_none), title: Text('NOTIFICATION', style: TextStyle(fontSize: txtSizeExplain))),
                BottomNavigationBarItem(
                    icon: Icon(Icons.info_outline), title: Text('SETTING', style: TextStyle(fontSize: txtSizeExplain))),
              ],
            )
        )
    );
  }

  void _onTapped(int idx) {
    setState(() {
      _selectedIdx = idx;
    });
  }
}
