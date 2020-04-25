import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:campfire/consts/common_values.dart';

class CampfireDetailPage extends StatefulWidget {
  static const routeName = '/campfire_detail_page';
  @override
  _CampfireDetailPageState createState() => _CampfireDetailPageState();
}

class _CampfireDetailPageState extends State<CampfireDetailPage> {

  final List<Widget> w_profile_img_list = [];
  final List<Widget> w_intro_img_list = [];

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

    w_intro_img_list.clear();
    w_profile_img_list.clear();

    for(int i=0; i<3; i++){
      w_intro_img_list.add(
        Container(
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
      );
    }

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
              Container(
                height: width_img_slide,
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: w_intro_img_list
                ),
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
