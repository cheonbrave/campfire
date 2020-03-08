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
        title: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            //Padding(padding: EdgeInsets.all(paddingAll)),
            Text('CAMPFIRE', style: TextStyle(inherit: true, fontSize: txtSizeTopTitle, fontWeight: FontWeight.w700),),
          ],
        ),
        elevation: 0.0,
      ),
      body: _makeBody(),
      backgroundColor: Colors.white,
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
              alignment: Alignment.topCenter,
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
                        Text('2', style: TextStyle(inherit: true, fontSize: txtSizeTopTitle, fontWeight: FontWeight.w700),),
                        Text(' ', style: TextStyle(inherit: true, fontSize: txtSizeTopTitle, fontWeight: FontWeight.w700),),
                        Text('page', style: TextStyle(inherit: true, fontSize: txtSizeTopTitle, fontWeight: FontWeight.w700, color: Color(pointColor)),),
                      ],
                    ),
                    //onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => InputInfoPage())),
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
