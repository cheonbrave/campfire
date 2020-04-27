import 'package:flutter/material.dart';
import 'package:campfire/consts/common_values.dart';

class NotificationPage extends StatefulWidget {
  static const routeName = '/notification_page';
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  final List<Widget> w_noti_list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("NOTIFICATION", style: TextStyle(fontSize: txtSizeTopTitle),),
        elevation: 1.0,
      ),
      body: _makeBody(),
      backgroundColor: Colors.white,
    );
  }

  Widget _makeBody() {

    var paddingRL = MediaQuery.of(context).size.width * 0.035;
    var paddingRL10 = MediaQuery.of(context).size.width * 0.10;

    w_noti_list.clear();
    w_noti_list.add(
      Padding(
        padding: EdgeInsets.only(bottom: padding20),
        child: Row(
          children: <Widget>[
            Container(
              width: paddingRL10,
              child: Icon(Icons.mail_outline, size: txtSizeTopTitle,),
            ),
            Padding(
              padding: EdgeInsets.only(right: padding10),
            ),
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        '매칭 신청을 받았습니다',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: txtSizeMidStr, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: padding3),
                    ),
                    Container(
                      child: Text(
                        '3월 1일, 오후 5시 30분',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: txtSizeSmlStr, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                )
            ),
            Padding(
              padding: EdgeInsets.only(left: padding10),
            ),
            Container(
              width: paddingRL10,
              child: Icon(Icons.keyboard_arrow_right, size: txtSizeTopTitle,),
            ),
          ],
        ),
      ),
    );

    w_noti_list.add(w_noti_list[0]);
    w_noti_list.add(w_noti_list[0]);
    w_noti_list.add(w_noti_list[0]);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea( // 아이폰 노치 디자인 대응

        // 스크롤뷰가 화면을 넘치지 않을때 컨텐츠를 화면 중앙에 오게 하고싶을 경우
        // Center + Stack로 감싸면 된다고함
        child: SingleChildScrollView(
          child:Padding(
            padding: EdgeInsets.all(paddingRL),
            /* UI 작성 - START */

            child: Column(
              children: w_noti_list,
            ),
            /* UI 작성 - END */
          ),
        ),
      ),
    );
  }
}