import 'package:flutter/material.dart';
import 'package:campfire/consts/common_values.dart';

class SamplePage3 extends StatefulWidget {
  @override
  _SamplePage3State createState() => _SamplePage3State();
}

/*
_willPopCallback 이 없는, 즉 안드로이드 백버튼 이벤트 발생 안시킬곳에서 사용할 화면 구조
*/

class _SamplePage3State extends State<SamplePage3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CAMPFIRE', style: TextStyle(fontSize: txtSizeTopTitle, fontWeight: FontWeight.w700),),
        elevation: 0.0,
      ),
      body: _makeBody(),
      backgroundColor: Colors.white,
    );
  }

  Widget _makeBody() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea( // 아이폰 노치 디자인 대응

        // 스크롤뷰가 화면을 넘치지 않을때 컨텐츠를 화면 중앙에 오게 하고싶을 경우
        // Center + Stack로 감싸면 된다고함
        child: Center(
          child: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child:Padding(
                  padding: EdgeInsets.all(padding25),
                  /* UI 작성 - START */

                  child: Container(
                    child: Text("여기에 UI 만들면됨"),
                  ),

                  /* UI 작성 - END */
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
