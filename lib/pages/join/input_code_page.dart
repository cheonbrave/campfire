import 'package:campfire/pages/tap_pages/campfire_page.dart';
import 'package:campfire/pages/tap_pages/tap_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:campfire/consts/common_values.dart';
import 'package:campfire/util/language/Translations.dart';
import 'package:flutter/services.dart';

class InputCodePage extends StatefulWidget {
  static const routeName = '/input_code_page';

  @override
  _InputCodePageState createState() => _InputCodePageState();
}

class _InputCodePageState extends State<InputCodePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translations.of(context).trans('app_title'), style: TextStyle(fontSize: txtSizeTopTitle, fontWeight: FontWeight.w500),),
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
        child: SingleChildScrollView(
          child:Padding(
            padding: EdgeInsets.all(paddingAllx2),
            /* UI 작성 - START */

            child:Column(
              /* UI 작성 - START */
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(Translations.of(context).trans('question_code'), style: TextStyle(fontSize: txtSizeBigStr, fontWeight: FontWeight.w500, color: Colors.black87),),
                  Padding(
                    padding: EdgeInsets.all(paddingItem),
                  ),
                  Padding(
                    padding: EdgeInsets.all(paddingItem),
                  ),
                  TextField(
                    maxLines : 1,
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.center,
                    style : TextStyle(fontSize: txtSizeBigStr),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                      hintText: Translations.of(context).trans('input_code'),
                      hintStyle: TextStyle(fontSize: txtSizeBigStr, color: Colors.black54),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(pointColor))),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black87)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(paddingItem),
                  ),
                  Padding(
                    padding: EdgeInsets.all(paddingItem),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.all(15.0),
                      //textColor: Color(pointColor),
                      textColor: Colors.white,
                      //color: Colors.white,
                      color: Colors.black87,
                      //splashColor: Color(pointColor2),
                      splashColor: Colors.black87,
                      child: Text(Translations.of(context).trans('code_none'), style: TextStyle(fontSize: txtSizeBigStr)),

                      //pushAndRemoveUntil 함수는 3번째 파라미터인 modalroute.withName에 할당된 페이지까지에 화면이동 히스토리를 지우는 기능
                      onPressed: () => Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => TapPage(tapIndex: 1)), ModalRoute.withName(TapPage.routeName)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(paddingItem),
                  ),
                  Padding(
                    padding: EdgeInsets.all(paddingItem),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.all(15.0),
                      //textColor: Color(pointColor),
                      textColor: Colors.white,
                      //color: Colors.white,
                      color: Colors.black87,
                      //splashColor: Color(pointColor2),
                      splashColor: Colors.black87,
                      child: Text(Translations.of(context).trans('code_check'), style: TextStyle(fontSize: txtSizeBigStr)),
                      onPressed: () => Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => TapPage(tapIndex: 0)), ModalRoute.withName(TapPage.routeName)),
                      
                    ),
                  ),
                ]
            )

            /* UI 작성 - END */
          ),
        ),
      ),
    );
  }
}
