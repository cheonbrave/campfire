import 'package:campfire/pages/sub_pages/campfire_detail_page.dart';
import 'package:campfire/pages/sub_pages/campfire_filter_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:campfire/consts/common_values.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:campfire/util/dbio/dbio.dart';


class CampfirePage extends StatefulWidget {
  static const routeName = '/campfire_page';
  @override
  _CampfirePageState createState() => _CampfirePageState();
}

class _CampfirePageState extends State<CampfirePage> {

  DBIO dbio = new DBIO();
  Map<String, dynamic> _data;

  /* 매칭상대 리스트 */
  final List<Widget> w_team_list = [];

  /* 소개이미지 리스트 */
  final List<String> imgList = [];
  int _current = 0;

  /* 태그 리스트 */
  final List<Widget> w_w_tag_list = [];

  clearLists(){
    /* 매칭상대 리스트 */
    w_team_list.clear();


    /* 태그 리스트 */
    w_w_tag_list.clear();
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

    var paddingRL = MediaQuery.of(context).size.width * 0.035;

    var height_profile_img = 40.0;
    var width_img_slide = MediaQuery.of(context).size.width;
    var height_img_slide = MediaQuery.of(context).size.height * 0.2;

    /* 매칭상대 리스트 */
    w_team_list.clear();

    /* 태그 리스트 */
    w_w_tag_list.clear();

    imgList.clear();

    imgList.add('https://pds.joins.com/news/component/htmlphoto_mmdata/201911/25/5400f271-49e2-4061-ad1a-5efc68ef2ec3.jpg');

    if(imgList.length > 0){
      WidgetsBinding.instance.addPostFrameCallback((_) {
        imgList.forEach((imageUrl) {
          precacheImage(NetworkImage(imageUrl), context);
        });
      });
    }

    /* 태그 리스트 */
    for(int i=0; i < 1; i++){
      w_w_tag_list.add(
          Text('#어깨깡패')
        );
        w_w_tag_list.add(
            Text('#20학번')
        );
        w_w_tag_list.add(
            Text('#서울대학교')
        );
        w_w_tag_list.add(
            Text('#법학과')
        );
        w_w_tag_list.add(
            Text('#맥주보다소주')
        );
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
                  Text('[오늘밤] 서울특별시, 홍대 어디든, 4명 (20살)',
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
                  Text('1분 전', style: TextStyle(fontSize: txtSizeExplain),),
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
