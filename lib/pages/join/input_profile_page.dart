import 'package:flutter/material.dart';
import 'package:campfire/consts/common_values.dart';

class InputProfilePage extends StatefulWidget {
  @override
  _InputProfilePageState createState() => _InputProfilePageState();
}

class _InputProfilePageState extends State<InputProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CAMPFIRE', style: TextStyle(inherit: true, fontSize: txtSizeTopTitle, fontWeight: FontWeight.w500),),
        elevation: 0.0,
      ),
      body: _makeBody(),
      backgroundColor: Colors.white,
    );
  }

  Widget _makeBody() {

    // 화면 전체높이에 20%
    var height20 = MediaQuery.of(context).size.height * 0.20;
    var mini_circle = height20/5.0;
    debugPrint("Circle >>> height20 : ${height20}, mini_circle : ${mini_circle}");

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(paddingAll),
        child: SafeArea( // 아이폰 노치 디자인 대응

          /* UI 작성 - START */
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('기본 정보를 등록해주세요', style: TextStyle(inherit: true, fontSize: txtSizeBigStr, fontWeight: FontWeight.w500),),
                Padding(
                  padding: EdgeInsets.all(paddingItem),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        SizedBox(
                            width: height20,
                            height: height20,
                            child: CircleAvatar(
                              backgroundColor: Color(pointColor),
                              backgroundImage: NetworkImage(
                                  'https://pds.joins.com/news/component/htmlphoto_mmdata/201911/25/5400f271-49e2-4061-ad1a-5efc68ef2ec3.jpg'
                              ),
                            )
                        ),
                        Container(
                          width: height20,
                          height: height20,
                          alignment: Alignment.bottomRight,
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              SizedBox(
                                  width: mini_circle,
                                  height: mini_circle,
                                  /*
                              형제 레벨에 floatingActionButton이 여러게일경우
                              heroTag가 구분되지 않으면
                              There are multiple heroes that share the same tag within a subtree
                              라는 오류가 남
                              */
                                  child: FloatingActionButton(
                                    heroTag: 'btnBackground',
                                    onPressed: null,
                                    backgroundColor: Color(pointColor),
                                  )
                              ),
                              SizedBox(
                                  width: mini_circle,
                                  height: mini_circle,
                                  child: FloatingActionButton(
                                    heroTag: 'btnEditImage',
                                    onPressed: null,
                                    backgroundColor: Color(pointColor),
                                    child: Icon(Icons.edit),
                                  )
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(paddingItem),
                ),
                TextField(
                  maxLines : 1,
                  textAlignVertical: TextAlignVertical.center,
                  textAlign: TextAlign.center,
                  style : TextStyle(inherit: true, fontSize: txtSizeBigStr),
                  decoration: InputDecoration(hintText: '닉네임을 입력하세요', hintStyle: TextStyle(inherit: true, fontSize: txtSizeBigStr), focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(pointColor)))),
                ),
              ],
            ),
          )
          /* UI 작성 - END */

        ),
      ),
    );
  }
}
