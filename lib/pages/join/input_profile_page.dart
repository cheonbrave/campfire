import 'package:campfire/pages/join/input_code_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:campfire/consts/common_values.dart';
import 'package:campfire/util/language/Translations.dart';
import 'package:flutter/services.dart';

enum Genders { man, woman }

class InputProfilePage extends StatefulWidget {
  static const routeName = '/input_profile_page';

  @override
  _InputProfilePageState createState() => _InputProfilePageState();
}

class _InputProfilePageState extends State<InputProfilePage> {

  Genders _gender = null;

  /*
  DateTime today = DateTime.now();
  DateTime year_20age = null;
  String dropdownValue =  null;
  */
  // dropdownValue - null 로 설정해두면 hint값으로 표시됨

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translations.of(context).trans('app_title'), style: TextStyle(fontSize: txtSizeTopTitle, fontWeight: FontWeight.w500),),
        elevation: 0.0,
      ),
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: _makeBody(),
      backgroundColor: Colors.white,
    );
  }

  Widget _makeBody() {

    // 화면 전체높이에 20%
    var height20 = MediaQuery.of(context).size.height * 0.20;
    var mini_circle = height20/5.0;

    /*
    DateTime today = DateTime.now();
    year_20age = DateTime(today.year - 19); // 빠른생일따윈 이제 없으니 19살 무시, 20살부터만 사용하는걸로!
    int num_year = year_20age.year;
    List<String> year_list = new List();
    for(int i=0; i < 31; i++){
      year_list.add(num_year.toString());
      num_year--;
    }
    */

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea( // 아이폰 노치 디자인 대응
          child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: paddingAllx2, right: paddingAllx2, top: paddingAll, bottom: paddingAllx2),
                child:Column(

                  /* UI 작성 - START */
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(Translations.of(context).trans('input_default_info'), style: TextStyle(fontSize: txtSizeBigStr, fontWeight: FontWeight.w500, color: Colors.black87),),
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
                    style : TextStyle(fontSize: txtSizeBigStr),
                    decoration: InputDecoration(
                      hintText: Translations.of(context).trans('input_nick'),
                      hintStyle: TextStyle(fontSize: txtSizeBigStr, color: Colors.black54),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(pointColor))),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black87)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(paddingItem),
                  ),
                  TextField(
                    maxLines : 1,
                    maxLength: 4,
                    maxLengthEnforced: true,
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.center,
                    style : TextStyle(fontSize: txtSizeBigStr),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                      hintText: Translations.of(context).trans('birth_year'),
                      hintStyle: TextStyle(fontSize: txtSizeBigStr, color: Colors.black54),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(pointColor))),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black87)),
                    ),
                  ),
                  /*
                  DropdownButton<String>(
                    hint: Center(
                        child: Text(
                          Translations.of(context).trans("birth_year"),
                          style: TextStyle(fontSize: txtSizeBigStr),
                        )
                    ),
                    isExpanded: true,
                    value: dropdownValue,
                    icon: Icon(Icons.arrow_drop_down, color: Color(pointColor)),
                    iconSize: txtSizeTopTitle,
                    elevation:16, // 1,2,3,4,6,8,9,12,16,24
                    style: TextStyle(
                        fontSize: txtSizeBigStr,
                        color: Colors.black87
                    ),
                    underline: Container(
                        height: 1,
                        color: Colors.black87
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                        debugPrint("dropdownValue : ${dropdownValue}");
                      });
                    },
                    items: year_list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Center(
                            child: Text(value, style: TextStyle(
                                fontSize: txtSizeBigStr,
                                color: Colors.black87
                            ),
                            )
                        ),
                      );
                    }).toList(),
                  ),
                  */
                  Padding(
                    padding: EdgeInsets.all(paddingItem),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                          flex: 1,
                          child: Container(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Radio(
                                    value: Genders.man,
                                    groupValue: _gender,
                                    onChanged: (Genders value) {
                                      setState(() { _gender = value; });
                                    },
                                  ),
                                  Text(Translations.of(context).trans('man'),style: TextStyle(fontSize: txtSizeBigStr)),
                                ],
                              )
                          )
                      ),
                      Expanded(
                          flex: 1,
                          child: Container(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Radio(
                                    value: Genders.woman,
                                    groupValue: _gender,
                                    onChanged: (Genders value) {
                                      setState(() { _gender = value; });
                                    },
                                  ),
                                  Text(Translations.of(context).trans('woman'),style: TextStyle(fontSize: txtSizeBigStr)),
                                ],
                              )
                          )
                      ),
                    ],
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
                      child: Text(Translations.of(context).trans('next'), style: TextStyle(fontSize: txtSizeBigStr)),
                      //onPressed: () => Navigator.pop(context),
                      onPressed: () => Navigator.push(context, CupertinoPageRoute(builder: (context) => InputCodePage())),
                    ),
                  ),
                ],
                  /* UI 작성 - END */
              ),
            )
          ),
      )
    );
  }
}
