import 'package:campfire/pages/sub_pages/campfire_detail_page.dart';
import 'package:campfire/pages/sub_pages/campfire_filter_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:campfire/consts/common_values.dart';


class CampfirePage extends StatefulWidget {
  static const routeName = '/campfire_page';
  @override
  _CampfirePageState createState() => _CampfirePageState();
}

class _CampfirePageState extends State<CampfirePage> {

  /* 매칭상대 리스트 */
  final List<Widget> w_team_list = [];

  /* 프로필이미지 리스트 */
  final List<Widget> w_profile_img_list = [];

  /* 소개이미지 리스트 */
  final List<Widget> w_intro_img_list = [];

  /* 태그 리스트 */
  final List<Widget> w_tag_list = [];

  clearLists(){
    /* 매칭상대 리스트 */
    w_team_list.clear();

    /* 프로필이미지 리스트 */
    w_profile_img_list.clear();

    /* 소개이미지 리스트 */
    w_intro_img_list.clear();

    /* 태그 리스트 */
    w_tag_list.clear();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("CAMPFIRE", style: TextStyle(fontSize: txtSizeTopTitle),),
        elevation: 1.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: (){
              setState(() {
                clearLists();
              });
              Navigator.push(context, CupertinoPageRoute(builder: (context) => CampfireFilterPage()));
            },
          ),
        ],
      ),
      body: _makeBody(),
      backgroundColor: Colors.white,
    );
  }

  Widget _makeBody() {

    var height_profile_img = 40.0;
    var width_img_slide = MediaQuery.of(context).size.width;
    var height_img_slide = MediaQuery.of(context).size.height * 0.2;

    /* 매칭상대 리스트 */
    w_team_list.clear();

    /* 프로필이미지 리스트 */
    w_profile_img_list.clear();

    /* 소개이미지 리스트 */
    w_intro_img_list.clear();

    /* 태그 리스트 */
    w_tag_list.clear();

    /* 태그 리스트 */
    for(int i=0; i < 1; i++){
      w_tag_list.add(
          Text('#어깨깡패')
        );
        w_tag_list.add(
            Text('#20학번')
        );
        w_tag_list.add(
            Text('#서울대학교')
        );
        w_tag_list.add(
            Text('#법학과')
        );
        w_tag_list.add(
            Text('#맥주보다소주')
        );
    }

    /* 프로필이미지 리스트 */
    for(int i=0; i < 10; i++){
      w_profile_img_list.add(
          Container(
            padding: EdgeInsets.only(right: 5.0, top: 5.0),
            width: height_profile_img,
            child: SizedBox(
                width: height_profile_img,
                height: height_profile_img,
                child: CircleAvatar(
                  backgroundColor: Color(pointColor),
                  backgroundImage: NetworkImage(
                      'https://pds.joins.com/news/component/htmlphoto_mmdata/201911/25/5400f271-49e2-4061-ad1a-5efc68ef2ec3.jpg'
                  ),
                )
            ),
          )
      );
    }

    for(int i=0; i<3; i++){
      w_intro_img_list.add(

        GestureDetector(
          child: Container(
            width: width_img_slide,
            height: height_img_slide,
            decoration: BoxDecoration(
              color: Colors.black87,
              image: DecorationImage(
                image:NetworkImage('https://pds.joins.com/news/component/htmlphoto_mmdata/201911/25/5400f271-49e2-4061-ad1a-5efc68ef2ec3.jpg'),
                fit:BoxFit.cover,
              ),
            ),
          ),
          onTap: () {
            setState(() {
              clearLists();
            });
            Navigator.push(context, CupertinoPageRoute(builder: (context) => CampfireDetailPage()));
          },
        )


      );
    }

    // initState에서 화면에 뿌려질 리스트를 수신받아서 리스트 구성
    w_team_list.add(
      Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: padding15, right: padding15, top: padding5, bottom: padding5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('[오늘밤] 서울특별시, 홍대 어디든, 4명 (20살)',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: txtSizeMidStr, fontWeight: FontWeight.w500),),
                  Padding(
                    padding: EdgeInsets.all(padding3),
                  ),
                  Container(
                    height: height_profile_img,
                    child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: w_profile_img_list,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(padding3),
                  ),
                ],
              ),
            ),
            Container(
              height: width_img_slide,
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: w_intro_img_list
              ),
            ),
            Padding(
              padding: EdgeInsets.all(padding3),
            ),
            Padding(
              padding: EdgeInsets.only(left: padding15, right: padding15, top: padding5, bottom: padding5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Wrap(
                    spacing: 7.0,
                    children: w_tag_list,
                  ),
                  Padding(
                    padding: EdgeInsets.all(padding3),
                  ),
                  Text('1분 전', style: TextStyle(fontSize: txtSizeExplain),),
                ]
              )
            ),
            Padding(
              padding: EdgeInsets.all(padding15),
            ),
          ],
        ),
      ),
    );

    w_team_list.add(w_team_list.first);
    w_team_list.add(w_team_list.first);
    w_team_list.add(w_team_list.first);
    w_team_list.add(w_team_list.first);
    w_team_list.add(w_team_list.first);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea( // 아이폰 노치 디자인 대응

        child: SingleChildScrollView(
          child: Column(children: w_team_list),
            /* UI 작성 - END */
        ),
      ),
    );
  }
}
