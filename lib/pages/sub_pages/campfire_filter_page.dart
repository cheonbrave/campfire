import 'package:campfire/util/language/Translations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:campfire/consts/common_values.dart';

class _CampfireFilterPageState extends State<CampfireFilterPage> {

  String dropdownValue_cnt =  null;
  String dropdownValue_type =  null;
  String dropdownValue_city =  null;
  String dropdownValue_age =  null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FILTERING', style: TextStyle(fontSize: txtSizeTopTitle)),
        elevation: 1.0,
      ),
      body: _makeBody(),
      backgroundColor: Colors.white,
    );
  }

  Widget _makeBody() {

    /* 인원선택 드랍다운 */
    List<String> member_cnt_list = new List();
    for(int i=2; i < 16; i++){
      member_cnt_list.add(i.toString());
    }
    /* 나이선택 드랍다운 */
    List<String> member_age_list = new List();
    for(int i=20; i < 51; i++){
      member_age_list.add(i.toString());
    }

    /* 데이트유형 드랍다운 */
    List<String> date_type_list = new List();
    date_type_list.add('같이 결정해요');
    date_type_list.add('오늘밤에 만나요');

    /* 지역 드랍다운 */
    List<String> city_list = Translations.of(context).trans('city').split(",");

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea( // 아이폰 노치 디자인 대응

        child: Center(
          child: Stack(
            children: <Widget>[
            SingleChildScrollView(
              child:Padding(
                padding: EdgeInsets.only(left: padding50, right: padding50, top: padding15, bottom: padding15),
                /* UI 작성 - START */

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("데이트 시기", style: TextStyle(fontSize: txtSizeMidStr, fontWeight: FontWeight.w500)),
                    DropdownButton<String>(
                      hint: Center(
                          child: Text(
                            '선택',
                            style: TextStyle(fontSize: txtSizeMidStr),
                          )
                      ),
                      isExpanded: true,
                      value: dropdownValue_type,
                      icon: Icon(Icons.arrow_drop_down, color: Color(pointColor)),
                      iconSize: txtSizeTopTitle,
                      elevation:16, // 1,2,3,4,6,8,9,12,16,24
                      style: TextStyle(
                        fontSize: txtSizeMidStr,
                        color: Colors.black87,
                        fontFamily: 'Noto Sans KR', // 폰트
                      ),
                      underline: Container(
                          height: 1,
                          color: Colors.black87
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue_type = newValue;
                          debugPrint("dropdownValue_type : ${dropdownValue_type}");
                        });
                      },
                      items: date_type_list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Center(
                              child: Text(value, style: TextStyle(
                                  fontSize: txtSizeMidStr,
                                  color: Colors.black87
                              ),
                              )
                          ),
                        );
                      }).toList(),
                    ),
                    Padding(
                      padding: EdgeInsets.all(padding15),
                    ),
                    Text("지역", style: TextStyle(fontSize: txtSizeMidStr, fontWeight: FontWeight.w500)),
                    DropdownButton<String>(
                      hint: Center(
                          child: Text(
                            '선택',
                            style: TextStyle(fontSize: txtSizeMidStr),
                          )
                      ),
                      isExpanded: true,
                      value: dropdownValue_city,
                      icon: Icon(Icons.arrow_drop_down, color: Color(pointColor)),
                      iconSize: txtSizeTopTitle,
                      elevation:16, // 1,2,3,4,6,8,9,12,16,24
                      style: TextStyle(
                          fontSize: txtSizeMidStr,
                          fontFamily: 'Noto Sans KR', // 폰트
                          color: Colors.black87
                      ),
                      underline: Container(
                          height: 1,
                          color: Colors.black87
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue_city = newValue;
                          debugPrint("dropdownValue_city : ${dropdownValue_city}");
                        });
                      },
                      items: city_list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Center(
                              child: Text(value, style: TextStyle(
                                  fontSize: txtSizeMidStr,
                                  color: Colors.black87
                              ),
                              )
                          ),
                        );
                      }).toList(),
                    ),
                    Padding(
                      padding: EdgeInsets.all(padding15),
                    ),
                    Text("인원", style: TextStyle(fontSize: txtSizeMidStr, fontWeight: FontWeight.w500)),
                    DropdownButton<String>(
                      hint: Center(
                          child: Text(
                            '선택',
                            style: TextStyle(fontSize: txtSizeMidStr),
                          )
                      ),
                      isExpanded: true,
                      value: dropdownValue_cnt,
                      icon: Icon(Icons.arrow_drop_down, color: Color(pointColor)),
                      iconSize: txtSizeTopTitle,
                      elevation:16, // 1,2,3,4,6,8,9,12,16,24
                      style: TextStyle(
                          fontSize: txtSizeMidStr,
                          fontFamily: 'Noto Sans KR', // 폰트
                          color: Colors.black87
                      ),
                      underline: Container(
                          height: 1,
                          color: Colors.black87
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue_cnt = newValue;
                          debugPrint("dropdownValue_cnt : ${dropdownValue_cnt}");
                        });
                      },
                      items: member_cnt_list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Center(
                              child: Text(value, style: TextStyle(
                                  fontSize: txtSizeMidStr,
                                  color: Colors.black87
                              ),
                              )
                          ),
                        );
                      }).toList(),
                    ),
                    Padding(
                      padding: EdgeInsets.all(padding15),
                    ),
                    Text("나이", style: TextStyle(fontSize: txtSizeMidStr, fontWeight: FontWeight.w500)),
                    DropdownButton<String>(
                      hint: Center(
                          child: Text(
                            '선택',
                            style: TextStyle(fontSize: txtSizeMidStr),
                          )
                      ),
                      isExpanded: true,
                      value: dropdownValue_age,
                      icon: Icon(Icons.arrow_drop_down, color: Color(pointColor)),
                      iconSize: txtSizeTopTitle,
                      elevation:16, // 1,2,3,4,6,8,9,12,16,24
                      style: TextStyle(
                          fontSize: txtSizeMidStr,
                          fontFamily: 'Noto Sans KR', // 폰트
                          color: Colors.black87
                      ),
                      underline: Container(
                          height: 1,
                          color: Colors.black87
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue_age = newValue;
                          debugPrint("dropdownValue_age : ${dropdownValue_age}");
                        });
                      },
                      items: member_age_list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Center(
                              child: Text(value, style: TextStyle(
                                  fontSize: txtSizeMidStr,
                                  color: Colors.black87
                              ),
                              )
                          ),
                        );
                      }).toList(),
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
                        padding: const EdgeInsets.all(12.0),
                        //textColor: Color(pointColor),
                        textColor: Colors.white,
                        //color: Colors.white,
                        color: Colors.black87,
                        //splashColor: Color(pointColor2),
                        splashColor: Colors.black87,
                        //child: Text(Translations.of(context).trans('team_make'), style: TextStyle(fontSize: txtSizeBigStr)),
                        child: Text("초기화", style: TextStyle(fontSize: txtSizeMidStr)),
                        onPressed: () {
                          setState(() {
                            dropdownValue_cnt =  null;
                            dropdownValue_type =  null;
                            dropdownValue_city =  null;
                            dropdownValue_age =  null;
                          });
                        },
                      ),
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
                        padding: const EdgeInsets.all(12.0),
                        //textColor: Color(pointColor),
                        textColor: Colors.white,
                        //color: Colors.white,
                        color: Colors.black87,
                        //splashColor: Color(pointColor2),
                        splashColor: Colors.black87,
                        //child: Text(Translations.of(context).trans('team_make'), style: TextStyle(fontSize: txtSizeBigStr)),
                        child: Text("적용", style: TextStyle(fontSize: txtSizeMidStr)),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ],
                ),
                /* UI 작성 - END */
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class CampfireFilterPage extends StatefulWidget {
  static const routeName = '/campfire_filter_page';
  @override
  _CampfireFilterPageState createState() => _CampfireFilterPageState();
}
