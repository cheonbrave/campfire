import 'package:campfire/pages/sub_pages/campfire_detail_page.dart';
import 'package:campfire/pages/sub_pages/campfire_filter_page.dart';
import 'package:campfire/pages/sub_pages/chatting_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:campfire/consts/common_values.dart';
import 'package:campfire/util/dbio/dbio.dart';


class MatchingPage extends StatefulWidget {
  static const routeName = '/matching_page';
  @override
  _MatchingPageState createState() => _MatchingPageState();
}

class _MatchingPageState extends State<MatchingPage> {

  DBIO dbio = new DBIO();
  Map<String, dynamic> _data;

  /* 매칭상대 리스트 */
  final List<Widget> w_team_list = [];

  /* 소개이미지 리스트 */
  final List<String> imgList = [];
  int _current = 0;

  clearLists(){
    /* 매칭상대 리스트 */
    w_team_list.clear();

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("MATCHING", style: TextStyle(fontSize: txtSizeTopTitle),),
        elevation: 1.0,
      ),
      body: _makeBody(),
      backgroundColor: Colors.white,
    );
  }

  Widget _makeBody() {

    var paddingRL = MediaQuery.of(context).size.width * 0.035;

    var height_profile_img = 40.0;
    var width_img_slide = MediaQuery.of(context).size.width;
    var height_img_slide = MediaQuery.of(context).size.height * 0.2;

    // 일단 개발은 했는데.. 스트림빌더로 땡겨오면 계속 땡김
    // 틴더나 아만다처럼 해야할까..
    return StreamBuilder(
      stream: Firestore.instance
          .collection(collection_teams)
          .where('is_view', isEqualTo: 'Y')
          .orderBy("up_time", descending: true)
          .snapshots()
      ,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(!snapshot.hasData){
          debugPrint("has no data");
          return Center(child: CircularProgressIndicator());
        }

        /* 매칭상대 리스트 */
        w_team_list.clear();

        for(int idx=0; idx < snapshot.data.documents.length; idx++){

          /* 태그 리스트 */
          List<Widget> w_w_tag_list = [];
          imgList.clear();

          debugPrint("has data");
          debugPrint(snapshot.data.documents[idx]['area']);

          String area = snapshot.data.documents[idx]['area'];
          int count = snapshot.data.documents[idx]['count'];
          String date_type = snapshot.data.documents[idx]['date_type'];
          String date_type_str = "";
          String gender = snapshot.data.documents[idx]['gender'];
          List intro_img_list = snapshot.data.documents[idx]['intro_img_list'];
          String is_view = snapshot.data.documents[idx]['is_view'];
          List members = snapshot.data.documents[idx]['members'];
          String place = snapshot.data.documents[idx]['place'];
          List tags = snapshot.data.documents[idx]['tags'];
          String up_time = snapshot.data.documents[idx]['up_time'];

          var up_date = DateTime.parse(up_time);  // 8:18pm
          var now_date = new DateTime.now();
          int diffMinutes = now_date.difference(up_date).inMinutes;
          String postfixStr = "";
          if(diffMinutes >= 1 && diffMinutes <= 59){
            postfixStr = "${diffMinutes}분 전";
          }else if(diffMinutes >= 60 && diffMinutes <= 1439){
            postfixStr = "${now_date.difference(up_date).inHours}시간 전";
          }else if(diffMinutes >= 1440 && diffMinutes <= 10079){
            postfixStr = "${now_date.difference(up_date).inDays}일 전";
          }else if(diffMinutes >= 10080 && diffMinutes <= 43199){
            postfixStr = "${now_date.difference(up_date).inDays/7}주 전";
          }else if(diffMinutes >= 43200 && diffMinutes <= 518399){
            postfixStr = "${now_date.difference(up_date).inDays/30}개월 전";
          }else if(diffMinutes >= 518400){
            postfixStr = "${now_date.difference(up_date).inDays/365}년 전";
          }else{
            postfixStr = "지금 막";
          }

          if(date_type == "tonight") {
            date_type_str = '[오늘밤]  ';
          }else{
            date_type_str = '';
          }

          int birth_year = 0;
          int now_year = 0;
          int age = 0;
          int min_age = 0;
          int max_age = 0;

          for(int i=0; i < members.length; i++){
            birth_year = int.parse(members[i]['birth_year']);
            now_year =  now_date.year;
            age = now_year - birth_year + 1;
            if(min_age == 0){
              min_age = age;
              max_age = age;
            }else{
              if(age < min_age){
                min_age = age;
              }
              if(age > max_age){
                max_age = age;
              }
            }
          }

          String item_title = "${date_type_str}[${count}:${count}] ${area} / ${place}  (${min_age}~${max_age})";

          if(max_age == min_age){
            item_title = "${date_type_str}[${count}:${count}] ${area} / ${place}  (${min_age})";
          }

          debugPrint("intro_img_list : ${intro_img_list}");
          debugPrint("members : ${members}");
          debugPrint("tags : ${tags}");
          debugPrint("up_time : ${up_time}");
          debugPrint("diffMinutes : ${diffMinutes}");

          if(intro_img_list.length > 0){
            for(int i=0; i < intro_img_list.length; i++){
              imgList.add(intro_img_list[i]);
            }
          }

          if(imgList.length > 0){
            WidgetsBinding.instance.addPostFrameCallback((_) {
              imgList.forEach((imageUrl) {
                precacheImage(NetworkImage(imageUrl), context);
              });
            });
          }

          /* 태그 리스트 */
          if(tags.length > 0){
            for(int i=0; i < tags.length; i++){
              w_w_tag_list.add(
                  Text(tags[i])
              );
            }
          }

          // initState에서 화면에 뿌려질 리스트를 수신받아서 리스트 구성
          w_team_list.add(
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: paddingRL, right: paddingRL, top: padding5, bottom: padding5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(item_title,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: txtSizeMidStr, fontWeight: FontWeight.w500),),
                        Padding(
                          padding: EdgeInsets.all(padding3),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                      child: Image.network(imgList[0], fit: BoxFit.contain, width: width_img_slide, height: width_img_slide,),
                      onTap: () {
                        setState(() {
                          clearLists();
                        });
                        Navigator.push(context, CupertinoPageRoute(builder: (context) => CampfireDetailPage()));
                      }),
                  Padding(
                    padding: EdgeInsets.all(padding3),
                  ),
                  /*
                  Padding(
                      padding: EdgeInsets.only(left: paddingRL, right: paddingRL, top: padding5, bottom: padding5),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Wrap(
                              spacing: 7.0,
                              children: w_w_tag_list,
                            ),
                            Padding(
                              padding: EdgeInsets.all(padding3),
                            ),
                            Text(postfixStr, style: TextStyle(fontSize: txtSizeXSmlStr),),
                          ]
                      )
                  ),
                  Padding(
                    padding: EdgeInsets.all(padding3),
                  ),*/
                  Padding(
                      padding: EdgeInsets.only(left: paddingRL, right: paddingRL, top: padding5, bottom: padding5),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Wrap(
                              spacing: 7.0,
                              children: w_w_tag_list,
                            ),
                            Padding(
                              padding: EdgeInsets.all(padding10),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black87),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              width: double.infinity,
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                padding: const EdgeInsets.all(13.0),
                                //textColor: Color(pointColor),
                                textColor: Colors.black87,
                                //color: Colors.white,
                                color: Colors.white,
                                //splashColor: Color(pointColor2),
                                splashColor: Colors.black12,
                                //child: Text(Translations.of(context).trans('team_make'), style: TextStyle(fontSize: txtSizeBigStr)),
                                child: Text("아직 미팅신청을 확인하지 못했어요", style: TextStyle(fontSize: txtSizeMidStr)),
                                onPressed: () {
                                  Navigator.push(context, CupertinoPageRoute(builder: (context) => ChattingPage()));
                                },

                              ),
                            ),
                          ]
                      )
                  ),
                  Padding(
                    padding: EdgeInsets.all(paddingRL),
                  ),
                ],
              ),
            ),
          );
        }

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea( // 아이폰 노치 디자인 대응

            child: SingleChildScrollView(
              child: Column(children: w_team_list),
              /* UI 작성 - END */
            ),
          ),
        );
      },
    );
  }
}
