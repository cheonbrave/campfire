import 'dart:io';
import 'dart:math';
import 'package:campfire/pages/tap_pages/tap_page.dart';
import 'package:campfire/util/dbio/dbio.dart';
import 'package:campfire/util/language/Translations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:campfire/consts/common_values.dart';
import 'package:flutter/services.dart';
import 'package:campfire/util/global.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:flutter_image_compress/flutter_image_compress.dart';

class TeamPage extends StatefulWidget {
  static const routeName = '/team_page';

  @override
  _TeamPageState createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {

  List<Map<String,String>> ti_members;
  int ti_count;
  String ti_date_type;
  String ti_area;
  String ti_place;
  List<String> ti_intro_img_list = ['','',''];
  List<String> ti_tags;
  String ti_is_view;
  String ti_up_time;
  String ti_gender;

  String dropdownValue_memberCnt =  '2';
  String dropdownValue_type =  null;
  String dropdownValue_city =  null;

  double _image_width = 0.0;
  double _height10 = 0.0;

  final List<Widget> w_tag_list = [];
  final List<Widget> w_profile_img_list = [];
  final List<Widget> w_intro_img_list = [];

  final txtCodeController = TextEditingController();
  FocusNode txtCodeFocusNode;

  final txtPlaceController = TextEditingController();
  FocusNode txtPlaceFocusNode;

  final txtTagController = TextEditingController();

  final List<String> member_cnt_list = new List();
  final List<String> date_type_list = new List();

  DBIO dbio = new DBIO();

  Map<String, dynamic> _data;

  void setTeamInfo(List<Map<String,String>> members, int count, String date_type, String area, String place, List<String> intro_img_list, List<String> tags, String is_view, String up_time, String gender){
    setState(() {
      ti_members = members;
      ti_count = count;
      ti_date_type = date_type;
      ti_area = area;
      ti_place = place;
      ti_intro_img_list = intro_img_list;
      ti_tags = tags;
      ti_is_view = is_view;
      ti_up_time = up_time;
      ti_gender = gender;
    });
  }

  void clearTeamInfo(){
    setState(() {
      ti_members = [];
      ti_count = 0;
      ti_date_type = '';
      ti_area = '';
      ti_place = '';
      ti_intro_img_list = ['','',''];
      ti_tags = [];
      ti_is_view = '';
      ti_up_time = '';
      ti_gender = '';
    });
  }

  @override
  void initState() {
    super.initState();
    txtCodeFocusNode = FocusNode();
    txtPlaceFocusNode = FocusNode();

    /* 인원선택 드랍다운 */
    for(int i=2; i < 16; i++){
      member_cnt_list.add(i.toString());
    }

    /* 데이트유형 드랍다운 */
    date_type_list.add('같이 결정해요');
    date_type_list.add('오늘밤에 만나요');

    /* 초대코드 값이 있을때만 팀 데이터 로딩 */
    if(g_invitation_code != null && g_invitation_code != ''){
      dbio.find_useDocName(collection_teams, g_invitation_code).then((DocumentSnapshot ds){

        List<dynamic> temp_list = ds.data['members'];
        List<Map<String,String>> members_list = [];
        Map<String,String> temp_map;
        for(int i=0; i < temp_list.length; i++){
          temp_map = {
            'email' : temp_list[i]['email'],
            'nickname' : temp_list[i]['nickname'],
            'profile_img' : temp_list[i]['profile_img'],
          };
          members_list.add(temp_map);
        }

        List<dynamic> dynamicList2;
        List<String> strList_introImgs = [];
        List<String> strList_tags = [];

        dynamicList2 = ds.data['intro_img_list'];
        for(int i = 0; i < dynamicList2.length; i++){
          strList_introImgs.add(dynamicList2[i]);
        }

        dynamicList2 = ds.data['tags'];
        for(int i = 0; i < dynamicList2.length; i++){
          strList_tags.add(dynamicList2[i]);
        }
        setTeamInfo(members_list,
            ds.data['count'],
            ds.data['date_type'],
            ds.data['area'],
            ds.data['place'],
            strList_introImgs,
            strList_tags,
            ds.data['is_view'],
            ds.data['up_time'],
            ds.data['gender']);
      });
    }
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
    if(g_invitation_code == null || g_invitation_code == "") {
      return _makePage_init();
    }else{
      return _makePage_team();
    }
  }

  buildTagRow(String str) {

    if(str.isEmpty) {
      return; // 빈 텍스트 무시
    }

    if(w_tag_list.length == 10) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("더 이상 추가할 수 없습니다", style: TextStyle(fontSize: txtSizeMidStr),),
        duration: Duration(seconds: 2),
      ));
      return; // 최대 10개
    }

    str = '#' + str;
    ti_tags.add(str);

    w_tag_list.add(
      Card(
        key: Key(str),
        child: ListTile(
          title: Center(child: Text(str, style: TextStyle(fontSize: txtSizeMidStr),)),
          trailing: IconButton(
            icon: Icon(Icons.remove_circle_outline),
            onPressed: () {
              setState(() {
                ti_tags.remove(str);
                debugPrint('ti_tags : ${ti_tags.toString()}');
                w_tag_list.removeWhere((item) => item.key == Key(str));
              });
            },
          ),
        )
      ),
    );

    _data = {
      'tags':ti_tags,
    };
    dbio.update(collection_teams, g_invitation_code, _data);

    debugPrint('ti_tags : ${ti_tags.toString()}');
  }

  Widget _makePage_team() {

    debugPrint('_makePage_team called');

    var height10 = MediaQuery.of(context).size.height * 0.10;
    _height10 = height10;

    var image_width = (MediaQuery.of(context).size.width - padding50 - padding50) / 3;
    _image_width = image_width;

    var listHeight = MediaQuery.of(context).size.height * 0.10 + 50.0;

    var paddingRL = MediaQuery.of(context).size.width * 0.1;

    setProfileImageList();

    setIntroImageList();

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
                          g_invitation_code = '';
                          g_prefs.setString('invitation_code', '');
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
                        height: listHeight,
                        child: ListView.builder(
                            padding: EdgeInsets.only(left: 5.0),
                            scrollDirection: Axis.horizontal,
                            itemCount: w_profile_img_list.length,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return w_profile_img_list[index];
                            }
                        )
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: paddingRL, right: paddingRL, top: padding15, bottom: padding15),
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
                                child: Text("친구 초대하기 (${w_profile_img_list.length}/${dropdownValue_memberCnt})", style: TextStyle(fontSize: txtSizeMidStr)),
                                onPressed: () async {

                                  debugPrint('초대 클릭');

                                  KakaoContext.clientId = "8a859e5bd31345db3d2afaac61111a91";
                                  KakaoContext.javascriptClientId = "6a46541295b0c6578cf168632da58cab";

                                  Uri uri = await LinkClient.instance.customWithTalk(24325, templateArgs: {
                                    "code":"1234",
                                  });
                                  //defaultWithTalk(, serverCallbackArgs: null);
                                  //custom(16761, templateArgs: {"key1": "value1"});
                                  await LinkClient.instance.launchKakaoTalk(uri);

                                },
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              alignment: Alignment.centerRight,
                              child: Text("초대코드 : ${g_invitation_code.substring(0,4)} ${g_invitation_code.substring(4,8)}", style: TextStyle(fontSize: txtSizeSmlStr)),
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
                              value: dropdownValue_memberCnt,
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

                                if(int.parse(newValue) < ti_members.length){
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text("합류한 멤버 수 보다 작은 값은 선택할 수 없습니다", style: TextStyle(fontSize: txtSizeMidStr),),
                                    duration: Duration(seconds: 2),
                                  ));
                                  return;
                                }

                                setState(() {
                                  dropdownValue_memberCnt = newValue;
                                  debugPrint("dropdownValue_memberCnt : ${dropdownValue_memberCnt}");
                                  ti_count = int.parse(dropdownValue_memberCnt);

                                  _data = {
                                    'count':ti_count,
                                  };
                                  dbio.update(collection_teams, g_invitation_code, _data);

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

                                  if(dropdownValue_type == '오늘밤에 만나요'){
                                    ti_date_type = 'tonight';
                                  }else if(dropdownValue_type == '같이 결정해요'){
                                    ti_date_type = 'notyet';
                                  }

                                  _data = {
                                    'date_type':ti_date_type,
                                  };

                                  dbio.update(collection_teams, g_invitation_code, _data);
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

                                  ti_area = dropdownValue_city;

                                  _data = {
                                    'area':ti_area,
                                  };

                                  dbio.update(collection_teams, g_invitation_code, _data);
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
                              focusNode: txtPlaceFocusNode,
                              controller: txtPlaceController,
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
                            Container(
                                height: _image_width,
                                child: ListView.builder(
                                    padding: EdgeInsets.only(left: 5.0),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: w_intro_img_list.length,
                                    itemBuilder: (BuildContext ctxt, int index) {
                                      return w_intro_img_list[index];
                                    }
                                )
                            ),
                            Padding(
                              padding: EdgeInsets.all(padding15),
                            ),
                            Text("매력 포인트", style: TextStyle(fontSize: txtSizeMidStr, fontWeight: FontWeight.w500),),
                            Column(children: w_tag_list),
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
                                onPressed: () {

                                  if(ti_date_type == null || ti_date_type == ''){
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text("데이트 시기를 선택하세요", style: TextStyle(fontSize: txtSizeMidStr),),
                                      duration: Duration(seconds: 2),
                                    ));
                                    return;
                                  }

                                  if(ti_area == null || ti_area == ''){
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text("지역을 선택하세요", style: TextStyle(fontSize: txtSizeMidStr),),
                                      duration: Duration(seconds: 2),
                                    ));
                                    return;
                                  }

                                  if(ti_place == null || ti_place == ''){
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text("장소를 입력하세요", style: TextStyle(fontSize: txtSizeMidStr),),
                                      duration: Duration(seconds: 2),
                                    ));
                                    return;
                                  }

                                  if(ti_intro_img_list == null || ti_intro_img_list.length == 0){
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text("사진을 최소 1장 이상 등록해주세요", style: TextStyle(fontSize: txtSizeMidStr),),
                                      duration: Duration(seconds: 2),
                                    ));
                                    return;
                                  }

                                  if(ti_tags == null || ti_tags.length < 3){
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text("매력 포인트를 3개 이상 입력해주세요", style: TextStyle(fontSize: txtSizeMidStr),),
                                      duration: Duration(seconds: 2),
                                    ));
                                    return;
                                  }

                                  if(ti_members.length != ti_count){
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text("팀원이 모두 합류한 후에 매칭을 시작할 수 있습니다", style: TextStyle(fontSize: txtSizeMidStr),),
                                      duration: Duration(seconds: 2),
                                    ));
                                    return;
                                  }

                                  _data = {
                                    'is_view' : 'Y',
                                  };

                                  dbio.update(collection_teams, g_invitation_code, _data);

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

    var paddingRL = MediaQuery.of(context).size.width * 0.1;

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
                  padding: EdgeInsets.only(left: paddingRL, right: paddingRL, top: padding25, bottom: padding50),
                  /* UI 작성 - START */

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
                          onPressed: () {
                            // g_invitation_code 생성, DB 초기값 insert
                            make_invitation_code();
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(padding25),
                      ),
                      Divider(color: Colors.black),
                      Padding(
                        padding: EdgeInsets.all(padding25),
                      ),
                      Text(Translations.of(context).trans('invitation_code_input_explain'), style: TextStyle(fontSize: txtSizeBigStr, fontWeight: FontWeight.w500, color: Colors.black87),),
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

                            String txtCode = txtCodeController.text;
                            txtCode = txtCode.replaceAll(new RegExp(r' '), '');
                            debugPrint('txtCode : ${txtCode}');

                            // 입력받은 초대코드 확인
                            if(txtCode != null &&
                                txtCode != '' &&
                                txtCode.length == 8 ){

                              // 초대코드에 해당하는 팀이 있는지 확인
                              dbio.find_useDocName(collection_teams, txtCode).then((DocumentSnapshot ds){

                                // 입력한 초대코드가 동일하고, 팀개설자의 성별과 초대코드 입력자의 성별이 같을때만 팀에 합류
                                if( ds.data != null && ds.data['gender'] == g_ui_gender ){

                                  List<Map<String,String>> _members = ds.data['members'];

                                  /* 이미 합류했던 사람인지 확인 */
                                  bool joined = false;
                                  for(int i=0; i < _members.length; i++){
                                    if(_members[i]['email'] == g_ui_email){
                                      joined = true;
                                      break;
                                    }
                                  }

                                  if(joined){
                                    setState(() {
                                      g_invitation_code = txtCode;
                                      g_prefs.setString('invitation_code', g_invitation_code);
                                    });
                                  }else{

                                    Map<String,String> map_item = {
                                      'email':g_ui_email,
                                      'nickname':g_ui_nickname,
                                      'profile_img':g_ui_profile_img,
                                    };

                                    _members.add(map_item);

                                    if(ds.data['members'].length > ds.data['count']){
                                      // 최대 합류 인원을 초과했다는 경고
                                      debugPrint("최대 인원 초과");
                                      return;
                                    }

                                    _data = {
                                      'members':_members,
                                    };

                                    dbio.update(collection_teams, txtCode, _data).then((onValue){
                                      setState(() {
                                        g_invitation_code = txtCode;
                                        g_prefs.setString('invitation_code', g_invitation_code);
                                      });
                                    });
                                  }
                                } else{
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text("초대코드를 확인하고 다시 입력하세요", style: TextStyle(fontSize: txtSizeMidStr),),
                                    duration: Duration(seconds: 2),
                                  ));
                                  txtCodeFocusNode.requestFocus();
                                }
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

  void setProfileImageList() {

    debugPrint('setProfileImageList called');

    w_profile_img_list.clear();

    w_profile_img_list.add(
        Container(
          padding: EdgeInsets.all(padding5),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(padding3),
              ),
              Stack(
                children: <Widget>[
                  SizedBox(
                      width: _height10,
                      height: _height10,
                      child: CircleAvatar(
                        backgroundColor: Color(pointColor),
                        backgroundImage: NetworkImage(
                            (ti_members == null) ? '' : ti_members[0]['profile_img']
                        ),
                      )
                  ),
                ],
              ),
              Container(
                width: _height10,
                child: Text(
                  (ti_members == null) ? '' : ti_members[0]['nicknames'],
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: txtSizeSmlStr),
                ),
              ),
            ],
          ),
        )
    );

    for(int i=0; i < (int.parse(dropdownValue_memberCnt)-1); i++){

      w_profile_img_list.add(
          Container(
            padding: EdgeInsets.all(padding5),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(padding3),
                ),
                Stack(
                  children: <Widget>[
                    SizedBox(
                        width: _height10,
                        height: _height10,
                        child: CircleAvatar(
                          child: Text('wait', overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: txtSizeMidStr, fontWeight: FontWeight.w700),),
                          backgroundColor: Color(pointColor),
                        )
                    ),
                  ],
                ),
              ],
            ),
          )
      );
    }
  }

  void setIntroImageList() {
    w_intro_img_list.clear();

    // db에서 리스트 로딩


    for (int i = 0; i < 3; i++) {
      //debugPrint('intro_img_list[${i}] : ${intro_img_list[i]}');
      // 리스트 길이만큼 그리고, 모자라면 더미를 그림
      w_intro_img_list.add(
        Container(
          width: _image_width,
          height: _image_width,
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: (ti_intro_img_list[i] != null && ti_intro_img_list[i] != '') ? NetworkImage(ti_intro_img_list[i]) : AssetImage('lib/assets/images/back_img.png'),
              //fit:BoxFit.cover,
            ),
          ),
          child: Stack(
              children: <Widget>[
                SizedBox(
                  width: _image_width,
                  height: _image_width,
                  child: IconButton(
                    icon: Icon(
                      Icons.add_circle_outline,
                      color: (ti_intro_img_list[i] != null && ti_intro_img_list[i] != '') ? Colors.white : Color(pointColor),
                    ),
                    onPressed: () {
                      _getImage(i);
                    },
                  ),
                )
              ]
          ),
        ),
      );

    }
  }

  /* 프로필 이미지 업로드 */
  void uploadImage(File compressImgFile, int index) {

    final fs = FirebaseStorage.instance.ref().child('teams').child(g_invitation_code).child('intro_img_${index}.jpg');
    final task = fs.putFile(compressImgFile, StorageMetadata(contentType: 'image/jpg'));
    task.onComplete.then((onValue) {
      var url = onValue.ref.getDownloadURL();
      url.then((onValue){
        debugPrint('upload success url : ${onValue}');
        // 화면 반영
        setState(() {
          ti_intro_img_list[index] = onValue;

        });
        // DB 반영
        _data = {
          'intro_img_list':ti_intro_img_list,
        };

        dbio.update(collection_teams, g_invitation_code, _data);

        setIntroImageList();

      });
    });
  }

  Future<File> compressAndGetFile(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 50,
    );

    print(file.lengthSync());
    print(result.lengthSync());

    return result;
  }

  void _cropImage(File _origin, int index) async {

    File croppedFile = await ImageCropper.cropImage(
        sourcePath: _origin.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Edit Pictures',
            toolbarColor: Colors.white,
            toolbarWidgetColor: Color(pointColor),
            activeControlsWidgetColor: Color(pointColor),
            activeWidgetColor: Color(pointColor),
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          title: 'Edit Pictures',
          minimumAspectRatio: 1.0,
        )
    );

    final dir = await path_provider.getTemporaryDirectory();
    final targetPath = dir.absolute.path + "/temp.jpg";
    final compressImgFile = await compressAndGetFile(croppedFile, targetPath);

    uploadImage(compressImgFile, index);

  }

  void _getImage(int index) {
    ImagePicker.pickImage(source: ImageSource.gallery).then((onValue){
      _cropImage(onValue, index);
    });
  }

  make_invitation_code() {
    String sCode = '';
    int iCode = 0;
    int len = 0;
    int min = 1;
    int max = 99999999;

    final _random = new Random();
    iCode = min + _random.nextInt( max - min );

    sCode = iCode.toString();
    len = sCode.length;
    if(len < 8){
      for(int i=0; i < (8-len); i++){
        sCode = '0' + sCode;
      }
    }

    debugPrint('sCode [${sCode}] find');

    dbio.find_useDocName(collection_teams, sCode).then((DocumentSnapshot ds){
      if(ds.data == null){
        debugPrint('sCode [${sCode}] is not exist');
        Map<String,String> map_item = {
          'email':g_ui_email,
          'nickname':g_ui_nickname,
          'profile_img':g_ui_profile_img,
        };
        List<Map<String,String>> tempMemList =[map_item];
        List<String> tempImgList = [];
        List<String> tempTagList = [];
        _data = {
          'members':tempMemList,
          'count':2,
          'date_type':'',
          'area':'',
          'place':'',
          'intro_img_list':['','',''],
          'tags':[],
          'is_view':'N',
          'up_time':'',
          'gender':g_ui_gender,   // 이곳은 팀을 개설하려는 사람의 성별을 기준으로 입력되어야야 함
        };

        dbio.upsert(collection_teams, sCode, _data).then((onValue){
          setState(() {
            g_invitation_code = sCode;
            g_prefs.setString('invitation_code', g_invitation_code);
          });
          setTeamInfo(tempMemList, 2, "", "", "", tempImgList, tempTagList, "n", "", g_ui_gender);
        });

      }else{
        debugPrint('sCode [${sCode}] is exist');
        // 랜덤숫자가 이미 다른 팀에서 사용중인 초대코드일경우 재귀함수 호출 형태로 재수행
        make_invitation_code();
      }
    });
  }

}
