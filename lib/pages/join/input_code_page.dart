import 'package:campfire/pages/tap_pages/campfire_page.dart';
import 'package:campfire/pages/tap_pages/tap_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:campfire/consts/common_values.dart';
import 'package:campfire/util/language/Translations.dart';
import 'package:flutter/services.dart';
import 'package:campfire/util/global.dart';

class InputCodePage extends StatefulWidget {
  static const routeName = '/input_code_page';

  @override
  _InputCodePageState createState() => _InputCodePageState();
}

class _InputCodePageState extends State<InputCodePage> {

  TextEditingController txtCodeController;
  FocusNode txtCodeFocusNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    txtCodeController = TextEditingController();
    txtCodeFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    txtCodeController.dispose();
    txtCodeFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translations.of(context).trans('app_title'), style: TextStyle(fontSize: txtSizeTopTitle, fontWeight: FontWeight.w500),),
        elevation: 0.0,
        centerTitle: false,
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
              padding: EdgeInsets.only(left: padding50, right: padding50, top: padding25, bottom: padding50),
            /* UI 작성 - START */

            child:Column(
              /* UI 작성 - START */
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(Translations.of(context).trans('question_code'), style: TextStyle(fontSize: txtSizeBigStr, fontWeight: FontWeight.w500, color: Colors.black87),),
                  Padding(
                    padding: EdgeInsets.all(padding15),
                  ),
                  Padding(
                    padding: EdgeInsets.all(padding15),
                  ),
                  TextField(
                    focusNode: txtCodeFocusNode,
                    controller: txtCodeController,
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
                    onChanged: (text) {
                      if(text.length == 8){
                        /* 사용중인 포커스를 다른곳으로 옮겨줌에따라 키보드가 사라지게 된다 */
                        FocusScope.of(context).requestFocus(FocusNode());
                      }
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(padding15),
                  ),
                  Padding(
                    padding: EdgeInsets.all(padding15),
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
                    padding: EdgeInsets.all(padding15),
                  ),
                  Padding(
                    padding: EdgeInsets.all(padding15),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Builder(
                      builder: (context) {
                        return FlatButton(
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
                          onPressed: () {
                            if(txtCodeController.text != null && txtCodeController.text != ''){

                              g_invitation_code = txtCodeController.text;
                              g_prefs.setString('invitation_code', g_invitation_code);

                              Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => TapPage(tapIndex: 0)), ModalRoute.withName(TapPage.routeName));
                            }else{
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text("초대 코드를 입력하세요", style: TextStyle(fontSize: txtSizeMidStr),),
                                duration: Duration(seconds: 2),
                              ));
                              txtCodeFocusNode.requestFocus();
                            }
                          },
                        );
                      },
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
