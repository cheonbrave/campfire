import 'package:flutter/material.dart';
import 'package:campfire/consts/common_values.dart';

class SamplePage2 extends StatefulWidget {
  static const routeName = '/sample_page2';
  @override
  _SamplePage2State createState() => _SamplePage2State();
}

/*
_willPopCallback 이 없는, 즉 안드로이드 백버튼 이벤트 발생 안시킬곳에서 사용할 화면 구조
*/

class _SamplePage2State extends State<SamplePage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CAMPFIRE', style: TextStyle(fontSize: txtSizeTopTitle, fontWeight: FontWeight.w700),),
        elevation: 1.0,
      ),
      body: _makeBody(),
      backgroundColor: Colors.white,
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
