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

  final List<Widget> team_list = [];

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

    var height55 = 55.0;

    final List<Widget> profiles = [];
    for(int i=0; i < 4; i++){
      profiles.add(
          Container(
            padding: EdgeInsets.only(right: 5.0, top: 5.0),
            width: height55,
            child: SizedBox(
                width: height55,
                height: height55,
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
    team_list.add(
      Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('[오늘밤] 서울특별시, 홍대 어디든, 4명 (20살)', style: TextStyle(fontSize: txtSizeMidStr, fontWeight: FontWeight.w500),),
            Container(
              height: height55,
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: profiles
              ),
            ),
            Padding(
              padding: EdgeInsets.all(padding5),
            ),
            Wrap(
              children: <Widget>[
                Chip(
                  backgroundColor: Color(pointColor2),
                  label: Text('#20학번'),
                ),
                Padding(
                  padding: EdgeInsets.only(right: padding5),
                ),
              ],
            ),
            Text('1분 전', style: TextStyle(fontSize: txtSizeExplain),),

            Padding(
              padding: EdgeInsets.all(padding15),
            ),



          ],
        ),
      ),
    );

    team_list.add(team_list.first);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea( // 아이폰 노치 디자인 대응

        child: SingleChildScrollView(
          child:Padding(
            padding: EdgeInsets.only(left: padding15, right: padding15, top: padding5, bottom: padding5),
            /* UI 작성 - START */

            child: Column(children: team_list),

            /* UI 작성 - END */
          ),
        ),
      ),
    );
  }
}
