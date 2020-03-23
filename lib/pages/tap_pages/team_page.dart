import 'package:campfire/pages/tap_pages/tap_page.dart';
import 'package:campfire/util/language/Translations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:campfire/consts/common_values.dart';
import 'package:flutter/services.dart';

class TeamPage extends StatefulWidget {
  static const routeName = '/team_page';

  @override
  _TeamPageState createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  @override
  Widget build(BuildContext context) {
    /*
    초대코드 유무에 따라 표시할 화면 분기
    if() {
      return _makePage_init();
    }else{
      return _makePage_team();
    }
     */

    return _makePage_init();
  }

  Widget _makePage_init() {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("TEAM", style: TextStyle(fontSize: txtSizeTopTitle),),
        elevation: 1.0,
      ),
      body: SafeArea( // 아이폰 노치 디자인 대응
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: paddingAllx2, right: paddingAllx2, top: paddingAll, bottom: paddingAllx2),
            /* UI 작성 - START */
  /*
            "team_code_input_explain" : "코드를 입력하고 팀에 합류 하세요",
            "team_code_input_hint" : "초대코드를 입력하세요",
            "code_check": "초대코드 확인",
            "team_make_explain" : "팀을 만들어야 블라인드 데이트를 시작할 수 있어요",
            "team_make" : "팀 만들기",
  */
            child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(Translations.of(context).trans('team_code_input_explain'), style: TextStyle(fontSize: txtSizeBigStr, fontWeight: FontWeight.w500, color: Colors.black87),),
                  Padding(
                    padding: EdgeInsets.all(paddingItem),
                  ),
                  TextField(
                    maxLines : 1,
                    maxLength: 8,
                    maxLengthEnforced: true,
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.center,
                    style : TextStyle(fontSize: txtSizeBigStr),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly,
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

                      //pushAndRemoveUntil 함수는 3번째 파라미터인 modalroute.withName에 할당된 페이지까지에 화면이동 히스토리를 지우는 기능
                      onPressed: () => Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => TapPage(tapIndex: 1)), ModalRoute.withName(TapPage.routeName)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(paddingItem),
                  ),
                  Divider(color: Colors.black87),
                  Padding(
                    padding: EdgeInsets.all(paddingItem),
                  ),
                  Text(Translations.of(context).trans('team_make_explain'), style: TextStyle(fontSize: txtSizeBigStr, fontWeight: FontWeight.w500, color: Colors.black87),),
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
                      child: Text(Translations.of(context).trans('team_make'), style: TextStyle(fontSize: txtSizeBigStr)),

                      //pushAndRemoveUntil 함수는 3번째 파라미터인 modalroute.withName에 할당된 페이지까지에 화면이동 히스토리를 지우는 기능
                      onPressed: () => Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => TapPage(tapIndex: 1)), ModalRoute.withName(TapPage.routeName)),
                    ),
                  ),
                ],
            ),

            /* UI 작성 - END */
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget _makePage_team() {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("TEAM", style: TextStyle(fontSize: txtSizeTopTitle),),
        elevation: 1.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app), onPressed: (){},
          ),
        ],
      ),
      body: SafeArea( // 아이폰 노치 디자인 대응
        child: Padding(
          padding: EdgeInsets.all(paddingAll),
          /* UI 작성 - START */

          child: Container(
            child: Text("여기에 UI 만들면됨"),
          ),

          /* UI 작성 - END */
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
