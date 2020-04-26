import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:campfire/consts/common_values.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CampfireDetailPage extends StatefulWidget {
  static const routeName = '/campfire_detail_page';
  @override
  _CampfireDetailPageState createState() => _CampfireDetailPageState();
}

class _CampfireDetailPageState extends State<CampfireDetailPage> {

  final List<Widget> w_profile_img_list = [];

  final List<String> imgList = [];
  int _current = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    imgList.add('https://pds.joins.com/news/component/htmlphoto_mmdata/201911/25/5400f271-49e2-4061-ad1a-5efc68ef2ec3.jpg');
    imgList.add('https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80');
    imgList.add('https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80');

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CAMPFIRE', style: TextStyle(fontSize: txtSizeTopTitle, fontWeight: FontWeight.w700),),
        elevation: 1.0,
      ),
      body: _makeBody(),
      backgroundColor: Colors.white,
    );
  }

  Widget _makeBody() {

    var height10 = MediaQuery.of(context).size.height * 0.10;
    var listHeight = MediaQuery.of(context).size.height * 0.10 + 50.0;

    var width_img_slide = MediaQuery.of(context).size.width;
    var height_img_slide = MediaQuery.of(context).size.height * 0.2;

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
              Container(
                width: height10,
                child: Text('cheonbrave123123123',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: txtSizeSmlStr),
                ),
              ),
            ],
          ),
        )
    );

    w_profile_img_list.add(w_profile_img_list[0]);
    w_profile_img_list.add(w_profile_img_list[0]);
    w_profile_img_list.add(w_profile_img_list[0]);
    w_profile_img_list.add(w_profile_img_list[0]);
    w_profile_img_list.add(w_profile_img_list[0]);
    w_profile_img_list.add(w_profile_img_list[0]);
    w_profile_img_list.add(w_profile_img_list[0]);
    w_profile_img_list.add(w_profile_img_list[0]);
    w_profile_img_list.add(w_profile_img_list[0]);
    w_profile_img_list.add(w_profile_img_list[0]);
    w_profile_img_list.add(w_profile_img_list[0]);
    w_profile_img_list.add(w_profile_img_list[0]);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea( // 아이폰 노치 디자인 대응
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: listHeight,
                child: ListView(
                  padding: EdgeInsets.only(left: padding10, right: padding10),
                  scrollDirection: Axis.horizontal,
                  children: w_profile_img_list,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: padding15, right: padding15, top: padding5, bottom: padding5),
                child: Column(
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
                    items: imgList.map((item) => Container(
                      child: Center(
                          child: Image.network(item, fit: BoxFit.cover, width: width_img_slide)
                      ),
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
                padding: EdgeInsets.all(padding5),
              ),
              Padding(
                padding: EdgeInsets.only(left: padding50, right: padding50, top: padding15, bottom: padding15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('~~~~~~~~~~~',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: txtSizeMidStr, fontWeight: FontWeight.w500),),
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
                        child: Text("매칭 신청", style: TextStyle(fontSize: txtSizeMidStr)),

                        //pushAndRemoveUntil 함수는 3번째 파라미터인 modalroute.withName에 할당된 페이지까지에 화면이동 히스토리를 지우는 기능
                        onPressed: () {
                          debugPrint('on pressed');
                        },

                      ),
                    ),
                  ],
                ),
              ),
            ]
          ),


        ),
      ),
    );
  }
}
