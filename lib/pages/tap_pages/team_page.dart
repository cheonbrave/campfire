import 'dart:convert';

import 'package:campfire/pages/tap_pages/tap_page.dart';
import 'package:campfire/util/language/Translations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:campfire/consts/common_values.dart';
import 'package:flutter/services.dart';
import 'package:campfire/util/global.dart';


class TeamPage extends StatefulWidget {
  static const routeName = '/team_page';

  @override
  _TeamPageState createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {

  String dropdownValue_cnt =  null;
  String dropdownValue_type =  null;
  String dropdownValue_city =  null;

  final List<Widget> tag_list = [];

  final txtCodeController = TextEditingController();
  final txtTagController = TextEditingController();
  FocusNode txtCodeFocusNode;

  @override
  void initState() {
    super.initState();
    txtCodeFocusNode = FocusNode();
  }

  @override
  void dispose() {
    txtTagController.dispose();
    txtCodeFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //초대코드 유무에 따라 표시할 화면 분기
    debugPrint("team_code : ${team_code}");
    if(team_code == null || team_code == "") {
      return _makePage_init();
    }else{
      return _makePage_team();
    }
  }

  buildTagRow(String str) {

    if(str.isEmpty) {
      return; // 빈 텍스트 무시
    }
    if(tag_list.length == 10) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("더 이상 추가할 수 없습니다", style: TextStyle(fontSize: txtSizeMidStr),),
        duration: Duration(seconds: 2),
      ));
      return; // 최대 10개
    }
    str = '#' + str;
    tag_list.add(
      Card(
        key: Key(str),
        child: ListTile(
          title: Center(child: Text(str, style: TextStyle(fontSize: txtSizeMidStr),)),
          trailing: IconButton(
            icon: Icon(Icons.remove_circle_outline),
            onPressed: () {
              setState(() {
                tag_list.removeWhere((item) => item.key == Key(str));
              });
            },
          ),
        )
      ),
    );
  }

  Widget _makePage_team() {

    var height10 = MediaQuery.of(context).size.height * 0.10;

    var image_width = (MediaQuery.of(context).size.width - padding50 - padding50) / 3;

    /* 인원선택 드랍다운 */
    List<String> member_cnt_list = new List();
    for(int i=2; i < 16; i++){
      member_cnt_list.add(i.toString());
    }

    /* 데이트유형 드랍다운 */
    List<String> date_type_list = new List();
    date_type_list.add('같이 결정해요');
    date_type_list.add('오늘밤에 만나요');

    /* 지역 드랍다운 */
    List<String> city_list = Translations.of(context).trans('city').split(",");

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("TEAM", style: TextStyle(fontSize: txtSizeTopTitle),),
        elevation: 1.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app), onPressed: (){

            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  //Translations.of(context).trans('main_center_text')
                  title: Text("팀에서 나가시겠습니까?"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text(Translations.of(context).trans('response_yes')),
                      onPressed: () {
                        setState(() {
                          team_code = "";
                          txtCodeController.text = '';
                        });
                        Navigator.pop(context, true);
                      },
                    ),
                    FlatButton(
                      child: Text(Translations.of(context).trans('response_no')),
                      onPressed: () => Navigator.pop(context, false),
                    ),
                  ],
                ));


          },
          ),
        ],
      ),
      body: SafeArea( // 아이폰 노치 디자인 대응
        child:Center(
          child: Stack(
            children: <Widget>[
              SingleChildScrollView(
                /* UI 작성 - START */
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: height10,
                        child: ListView(
                          padding: EdgeInsets.only(left: 5.0),
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(padding10),
                              width: height10,
                              child: Stack(
                                children: <Widget>[
                                  SizedBox(
                                      width: height10,
                                      height: height10,
                                      child: CircleAvatar(
                                        backgroundColor: Color(pointColor),
                                        backgroundImage: NetworkImage(
                                            'https://pds.joins.com/news/component/htmlphoto_mmdata/201911/25/5400f271-49e2-4061-ad1a-5efc68ef2ec3.jpg'
                                        ),
                                      )
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(padding10),
                              width: height10,
                              child: Stack(
                                children: <Widget>[
                                  SizedBox(
                                      width: height10,
                                      height: height10,
                                      child: CircleAvatar(
                                        backgroundColor: Color(pointColor),
                                        backgroundImage: NetworkImage(
                                            'https://pds.joins.com/news/component/htmlphoto_mmdata/201911/25/5400f271-49e2-4061-ad1a-5efc68ef2ec3.jpg'
                                        ),
                                      )
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(padding10),
                              width: height10,
                              child: Stack(
                                children: <Widget>[
                                  SizedBox(
                                      width: height10,
                                      height: height10,
                                      child: CircleAvatar(
                                        child: Text('wait', style: TextStyle(fontSize: txtSizeSmlStr, fontWeight: FontWeight.w700),),
                                        backgroundColor: Color(pointColor),
                                      )
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(padding10),
                              width: height10,
                              child: Stack(
                                children: <Widget>[
                                  SizedBox(
                                      width: height10,
                                      height: height10,
                                      child: CircleAvatar(
                                        child: Text('wait', style: TextStyle(fontSize: txtSizeSmlStr, fontWeight: FontWeight.w700),),
                                        backgroundColor: Color(pointColor),
                                      )
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(padding10),
                              width: height10,
                              child: Stack(
                                children: <Widget>[
                                  SizedBox(
                                      width: height10,
                                      height: height10,
                                      child: CircleAvatar(
                                        child: Text('wait', style: TextStyle(fontSize: txtSizeSmlStr, fontWeight: FontWeight.w700),),
                                        backgroundColor: Color(pointColor),
                                      )
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(padding10),
                              width: height10,
                              child: Stack(
                                children: <Widget>[
                                  SizedBox(
                                      width: height10,
                                      height: height10,
                                      child: CircleAvatar(
                                        child: Text('wait', style: TextStyle(fontSize: txtSizeSmlStr, fontWeight: FontWeight.w700),),
                                        backgroundColor: Color(pointColor),
                                      )
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(padding10),
                              width: height10,
                              child: Stack(
                                children: <Widget>[
                                  SizedBox(
                                      width: height10,
                                      height: height10,
                                      child: CircleAvatar(
                                        child: Text('wait', style: TextStyle(fontSize: txtSizeSmlStr, fontWeight: FontWeight.w700),),
                                        backgroundColor: Color(pointColor),
                                      )
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(padding10),
                              width: height10,
                              child: Stack(
                                children: <Widget>[
                                  SizedBox(
                                      width: height10,
                                      height: height10,
                                      child: CircleAvatar(
                                        child: Text('wait', style: TextStyle(fontSize: txtSizeSmlStr, fontWeight: FontWeight.w700),),
                                        backgroundColor: Color(pointColor),
                                      )
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(padding10),
                              width: height10,
                              child: Stack(
                                children: <Widget>[
                                  SizedBox(
                                      width: height10,
                                      height: height10,
                                      child: CircleAvatar(
                                        child: Text('wait', style: TextStyle(fontSize: txtSizeSmlStr, fontWeight: FontWeight.w700),),
                                        backgroundColor: Color(pointColor),
                                      )
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(padding10),
                              width: height10,
                              child: Stack(
                                children: <Widget>[
                                  SizedBox(
                                      width: height10,
                                      height: height10,
                                      child: CircleAvatar(
                                        child: Text('wait', style: TextStyle(fontSize: txtSizeSmlStr, fontWeight: FontWeight.w700),),
                                        backgroundColor: Color(pointColor),
                                      )
                                  ),
                                ],
                              ),
                            ),


                            /*
                      Container(
                        padding: EdgeInsets.all(paddingImg),
                        width: height10,
                        height: height10,
                        child: SizedBox(
                            width: height10,
                            height: height10,
                            child: FloatingActionButton(
                              heroTag: 'btnAddImage',
                              onPressed: null,
                              backgroundColor: Color(pointColor),
                              child: Icon(Icons.person_add),
                            )
                        )
                      )
                       */
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: padding50, right: padding50, top: padding15, bottom: padding15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
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
                                child: Text("친구 초대하기 (2/10)", style: TextStyle(fontSize: txtSizeMidStr)),

                                //pushAndRemoveUntil 함수는 3번째 파라미터인 modalroute.withName에 할당된 페이지까지에 화면이동 히스토리를 지우는 기능
                                onPressed: () => Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => TapPage(tapIndex: 0)), ModalRoute.withName(TapPage.routeName)),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              alignment: Alignment.centerRight,
                              child: Text("초대코드 : 0000", style: TextStyle(fontSize: txtSizeSmlStr)),
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
                            Text("장소", style: TextStyle(fontSize: txtSizeMidStr, fontWeight: FontWeight.w500)),
                            TextField(
                              //controller: widget.input_place,
                              maxLines : 1,
                              maxLength: 20,
                              textAlignVertical: TextAlignVertical.center,
                              textAlign: TextAlign.center,
                              style : TextStyle(fontSize: txtSizeMidStr),
                              decoration: InputDecoration(
                                hintText: '만나고 싶은 장소를 알려주세요',
                                hintStyle: TextStyle(fontSize: txtSizeMidStr, color: Colors.black54),
                                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(pointColor))),
                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black87)),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(padding15),
                            ),
                            Text("사진", style: TextStyle(fontSize: txtSizeMidStr, fontWeight: FontWeight.w500)),
                            Padding(
                              padding: EdgeInsets.all(padding3),
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  width: image_width,
                                  height: image_width,
                                  decoration: BoxDecoration(
                                    color: Colors.black87,
                                    image: DecorationImage(
                                      image:NetworkImage('https://pds.joins.com/news/component/htmlphoto_mmdata/201911/25/5400f271-49e2-4061-ad1a-5efc68ef2ec3.jpg'),
                                      fit:BoxFit.cover,
                                    ),
                                  ),
                                  child: Stack(
                                    children: <Widget>[
                                      SizedBox(
                                          width: image_width,
                                          height: image_width,
                                          child: Icon(
                                            Icons.add_circle_outline,
                                            color: Colors.white,
                                            //size: image_width/4,
                                          )
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: image_width,
                                  height: image_width,
                                  decoration: BoxDecoration(
                                    color: Colors.black87,
                                    image: DecorationImage(
                                      image:NetworkImage('https://ww.namu.la/s/df6823100023af724c38aecf72153b741d12f8e8bc21707d1265a79b0bea9f597083fbab05c4a4d6b4f4068f447b4fb8fd3c8184c2ec21638ffae1b7230175ba911e49566a63b5aee47b64e873a5b9ff2122d2f52b5219782e454f2fd03db743274510fc76e20cdde8d0175de4f92323'),
                                      fit:BoxFit.cover,
                                    ),
                                    border: Border.all(
                                      color: Colors.black38,
                                    ),
                                  ),
                                  child: Stack(
                                    children: <Widget>[
                                      SizedBox(
                                          width: image_width,
                                          height: image_width,
                                          child: Icon(
                                            Icons.add_circle_outline,
                                            color: Colors.white,
                                            //size: image_width/4,
                                          )
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: image_width,
                                  height: image_width,
                                  decoration: BoxDecoration(
                                    color: Colors.black87,
                                    image: DecorationImage(
                                      image:NetworkImage('http://cdn.bizwatch.co.kr/news/photo/2019/10/11/f3120682b1ea7d5f10428bb7a50a9b6d.jpg'),
                                      fit:BoxFit.cover,
                                    ),
                                  ),
                                  child: Stack(
                                    children: <Widget>[
                                      SizedBox(
                                          width: image_width,
                                          height: image_width,
                                          child: Icon(
                                            Icons.add_circle_outline,
                                            color: Colors.white,
                                            //size: image_width/4,
                                          )
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.all(padding15),
                            ),
                            Text("매력 포인트", style: TextStyle(fontSize: txtSizeMidStr, fontWeight: FontWeight.w500),),
                            Column(children: tag_list),
                            TextField(
                              controller: txtTagController,
                              onSubmitted: (input_str){
                                setState(() {
                                  buildTagRow(input_str);
                                  txtTagController.text = '';
                                });
                              },
                              maxLines : 1,
                              maxLength: 10,
                              textAlignVertical: TextAlignVertical.center,
                              textAlign: TextAlign.center,
                              style : TextStyle(fontSize: txtSizeMidStr),
                              decoration: InputDecoration(
                                hintText: '우리팀의 매력 포인트는?',
                                hintStyle: TextStyle(fontSize: txtSizeMidStr, color: Colors.black54),
                                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(pointColor))),
                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black87)),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.add_circle_outline, color: Color(pointColor)),
                                  onPressed: () {
                                    setState(() {
                                      buildTagRow(txtTagController.text);
                                      txtTagController.text = '';
                                    });
                                  },
                                ),
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
                                child: Text("매칭 시작", style: TextStyle(fontSize: txtSizeMidStr)),

                                //pushAndRemoveUntil 함수는 3번째 파라미터인 modalroute.withName에 할당된 페이지까지에 화면이동 히스토리를 지우는 기능
                                onPressed: () => Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => TapPage(tapIndex: 0)), ModalRoute.withName(TapPage.routeName)),

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
                                child: Text("우리팀 UP 하기", style: TextStyle(fontSize: txtSizeMidStr)),

                                //pushAndRemoveUntil 함수는 3번째 파라미터인 modalroute.withName에 할당된 페이지까지에 화면이동 히스토리를 지우는 기능
                                onPressed: () => Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => TapPage(tapIndex: 0)), ModalRoute.withName(TapPage.routeName)),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(padding3),
                            ),
                            Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              child: Text("현재 우리팀 노출순위 : 100번째", style: TextStyle(fontSize: txtSizeSmlStr)),
                            ),
                            Padding(
                              padding: EdgeInsets.all(padding15),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                /* UI 작성 - END */
              ),
            ],
          ),
        ),

      ),
      backgroundColor: Colors.white,
    );
  }

  Widget _makePage_init() {

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("TEAM", style: TextStyle(fontSize: txtSizeTopTitle),),
        elevation: 1.0,
      ),
      body: SafeArea( // 아이폰 노치 디자인 대응
        child: Center(
          child: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: padding50, right: padding50, top: padding25, bottom: padding50),
                  /* UI 작성 - START */
                  /*
            "team_code_input_explain" : "코드를 입력하고 팀에 합류 하세요",
            "team_code_input_hint" : "초대코드를 입력하세요",
            "code_check": "초대코드 확인",
            "team_make_explain" : "팀을 만들어야 매칭을 시작할 수 있어요",
            "team_make" : "팀 만들기",
  */
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(Translations.of(context).trans('team_make_explain'), style: TextStyle(fontSize: txtSizeBigStr, fontWeight: FontWeight.w500, color: Colors.black87),),
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
                          child: Text(Translations.of(context).trans('team_make'), style: TextStyle(fontSize: txtSizeBigStr)),

                          //pushAndRemoveUntil 함수는 3번째 파라미터인 modalroute.withName에 할당된 페이지까지에 화면이동 히스토리를 지우는 기능
                          onPressed: () => Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => TapPage(tapIndex: 0)), ModalRoute.withName(TapPage.routeName)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(padding25),
                      ),
                      Divider(color: Colors.black),
                      Padding(
                        padding: EdgeInsets.all(padding25),
                      ),
                      Text(Translations.of(context).trans('team_code_input_explain'), style: TextStyle(fontSize: txtSizeBigStr, fontWeight: FontWeight.w500, color: Colors.black87),),
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
                          child: Text(Translations.of(context).trans('code_check'), style: TextStyle(fontSize: txtSizeBigStr)),

                          //pushAndRemoveUntil 함수는 3번째 파라미터인 modalroute.withName에 할당된 페이지까지에 화면이동 히스토리를 지우는 기능
                          //onPressed: () => Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => TapPage(tapIndex: 0)), ModalRoute.withName(TapPage.routeName)),
                          onPressed: (){
                            if(txtCodeController.text != null && txtCodeController.text != ''){
                              setState(() {
                                team_code = txtCodeController.text;
                              });

                            }else{
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text("초대 코드를 입력하세요", style: TextStyle(fontSize: txtSizeMidStr),),
                                duration: Duration(seconds: 2),
                              ));
                              txtCodeFocusNode.requestFocus();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  /* UI 작성 - END */
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
