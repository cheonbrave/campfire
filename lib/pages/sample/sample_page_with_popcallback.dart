import 'package:flutter/material.dart';
import 'package:campfire/consts/common_values.dart';

class SamplePage extends StatefulWidget {
  static const routeName = '/sample_page';
  @override
  _SamplePageState createState() => _SamplePageState();
}

class _SamplePageState extends State<SamplePage> {

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
          title: Text('CAMPFIRE', style: TextStyle(fontSize: txtSizeTopTitle, fontWeight: FontWeight.w700),),
          elevation: 1.0,
        ),
        body: _makeBody(),
        backgroundColor: Colors.white,
      ),
    );
  }

  Widget _makeBody() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea( // 아이폰 노치 디자인 대응
        child: Padding(
          padding: EdgeInsets.all(padding25),
          /* UI 작성 - START */

          child: Container(
            child: Text("여기에 UI 만들면됨"),
          ),

          /* UI 작성 - END */
        ),
      ),
    );
  }
}
