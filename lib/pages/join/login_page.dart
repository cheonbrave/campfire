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
          title: Text("종료 하시겠습니까?"),
          actions: <Widget>[
            FlatButton(
              child: Text("네"),
              onPressed: () => Navigator.pop(context, true),
            ),
            FlatButton(
              child: Text("아니요"),
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
        appBar: AppBar(
          title: Text("CAMPFIRE"),
          elevation: 0.0,
        ),
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
          child: Column(
            children: <Widget>[
              Text("여기에 UI 만들면됨, 폰트는 어울리는걸 찾아서 적용해보자\n일단 리멤버 만들때 사용던 배달의민족 폰트 적용해봄\n"),

              Text("lib/pages/sample 아래에 샘플 페이지 만들어뒀으니..\n대부분 페이지는 이 포맷을 가지고 개발하면 됨\n")
            ],
          ),


          /* UI 작성 - END */

        ),
      ),
    );
  }
}
