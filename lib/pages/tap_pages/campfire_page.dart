import 'package:campfire/pages/sub_pages/campfire_detail_page.dart';
import 'package:campfire/pages/sub_pages/campfire_filter_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:campfire/consts/common_values.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
  final List<String> imgList = [];
  int _current = 0;

  /* 태그 리스트 */
  final List<Widget> w_tag_list = [];

  clearLists(){
    /* 매칭상대 리스트 */
    w_team_list.clear();

    /* 프로필이미지 리스트 */
    w_profile_img_list.clear();

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

    /* 태그 리스트 */
    w_tag_list.clear();

    imgList.clear();
    imgList.add('https://pds.joins.com/news/component/htmlphoto_mmdata/201911/25/5400f271-49e2-4061-ad1a-5efc68ef2ec3.jpg');
    imgList.add('https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80');
    imgList.add('https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80');

    WidgetsBinding.instance.addPostFrameCallback((_) {
      imgList.forEach((imageUrl) {
        precacheImage(NetworkImage(imageUrl), context);
      });
    });

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
    for(int i=0; i < 4; i++){
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
            Column(
              children: <Widget>[
                CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: false,
                    aspectRatio: 1/1, // 1/1, 4/3, 16/9
                    enlargeCenterPage: false,
                    viewportFraction: 1.0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    },
                  ),
                  items: imgList.map((item) => GestureDetector(
                    child: Container(
                      child: Center(
                          child: Image.network(item, fit: BoxFit.cover, width: width_img_slide)
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        clearLists();
                      });
                      Navigator.push(context, CupertinoPageRoute(builder: (context) => CampfireDetailPage()));
                    },
                  )).toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: imgList.map((url) {
                    int index = imgList.indexOf(url);
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _current == index
                            ? Color(pointColor)
                            : Colors.black26,
                      ),
                    );
                  }).toList(),
                ),
              ],
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
