import 'package:campfire/pages/join/input_profile_page.dart';
import 'package:campfire/util/language/Translations.dart';
import 'package:flutter/material.dart';
import 'package:campfire/consts/common_values.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  // Android 에서 Back 버튼 사용하면 감지해서 팝업다이얼로그 발생시키는 함수
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // will pop scope는 화면이 pop가 발생할때 즉 화면이 distory될때를 감안한 이벤트를 줄수있으며 android의 back버튼 클릭이벤트라고 생각하면된다
      onWillPop: _willPopCallback,
      child: Scaffold(
        body: _makeBody(),
        backgroundColor: Colors.white,
      ),
    );
  }

  Widget _makeBody() {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(paddingAll),
        child: SafeArea( // 아이폰 노치 디자인 대응
          /* UI 작성 - START */
          child: Container(
            child: Align(
              alignment: Alignment.centerRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(paddingItem),
                  ),
                  Padding(
                    padding: EdgeInsets.all(paddingItem),
                  ),
                  Padding(
                    padding: EdgeInsets.all(paddingItem),
                  ),
                  InkWell(
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text('GOOGLE', style: TextStyle(inherit: true, fontSize: txtSizeTopTitle, fontWeight: FontWeight.w700),),
                          Text(' ', style: TextStyle(inherit: true, fontSize: txtSizeTopTitle, fontWeight: FontWeight.w700),),
                          Text('LOGIN', style: TextStyle(inherit: true, fontSize: txtSizeTopTitle, fontWeight: FontWeight.w700, color: Color(pointColor)),),
                        ],
                    ),
                    //onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => InputProfilePage())),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => InputProfilePage())),
                  ),
                  Padding(
                    padding: EdgeInsets.all(paddingItem),
                  ),
                  Text('Your first', style: TextStyle(inherit: true, fontSize: txtSizeBigStr, fontWeight: FontWeight.w700),),
                  Text('Blind date', style: TextStyle(inherit: true, fontSize: txtSizeBigStr, fontWeight: FontWeight.w700),),
                  Padding(
                    padding: EdgeInsets.all(paddingItem),
                  ),
                  Text('CAMPFIRE', style: TextStyle(inherit: true, fontSize: txtSizeMainTitle, fontWeight: FontWeight.w700, color: Color(pointColor)),),
                ],
              ),
            ),
          ),
          /* UI 작성 - END */

        ),
      ),
    );
  }
}
