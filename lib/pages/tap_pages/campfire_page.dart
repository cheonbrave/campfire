import 'package:campfire/pages/sub_pages/campfire_detail_page.dart';
import 'package:campfire/pages/sub_pages/campfire_filter_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  List<DocumentSnapshot> documentList;

  /* document의 이름에 해당하는것 find */
  Future<QuerySnapshot>  find_campFireTargets(String collection_name){
    var fdb = Firestore.instance.collection(collection_name);
    return fdb.where('is_view', isEqualTo: 'Y')
        .orderBy("up_time", descending: true)
        .limit(2)
        .getDocuments();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    find_campFireTargets(collection_teams).then((QuerySnapshot qs){
      for(int i=0; i < qs.documents.length; i++){
        documentList = qs.documents;
        var data = documentList[i].data;
        debugPrint("data : ${data.toString()}");
      }
    });

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea( // 아이폰 노치 디자인 대응

        // 스크롤뷰가 화면을 넘치지 않을때 컨텐츠를 화면 중앙에 오게 하고싶을 경우
        // Center + Stack로 감싸면 된다고함
        child: Center(
          child: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child:Padding(
                  padding: EdgeInsets.all(padding25),
                  /* UI 작성 - START */

                  child: Container(
                    child: Text("여기에 UI 만들면됨"),
                  ),

                  /* UI 작성 - END */
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
