import 'package:flutter/material.dart';
import 'package:campfire/consts/common_values.dart';

class InputProfilePage extends StatefulWidget {
  @override
  _InputProfilePageState createState() => _InputProfilePageState();
}

class _InputProfilePageState extends State<InputProfilePage> {

  DateTime today = DateTime.now();
  DateTime year_20age = null;
  String dropdownValue =  '태어난 해';
  // dropdownValue는 DropdownButton에서 현재값을 가리키는 변수이며
  // 선택할때마다 값을 갱신하기위해 setState를 사용한다
  // setState에 의해 변경된 값이 화면에 반영되기 위해선 dropdownValue 변수는 PageState 하위에 선언되어있어야 한다

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CAMPFIRE', style: TextStyle(fontSize: txtSizeTopTitle, fontWeight: FontWeight.w500),),
        elevation: 0.0,
      ),
      body: _makeBody(),
      backgroundColor: Colors.white,
    );
  }

  Widget _makeBody() {

    // 화면 전체높이에 20%
    var height20 = MediaQuery.of(context).size.height * 0.20;
    var mini_circle = height20/5.0;

    DateTime today = DateTime.now();
    year_20age = DateTime(today.year - 19); // 빠른생일따윈 이제 없으니 19살 무시, 20살부터만 사용하는걸로!
    int num_year = year_20age.year;
    List<String> year_list = new List();
    year_list.add('태어난 해');
    for(int i=0; i < 31; i++){
      year_list.add(num_year.toString());
      num_year--;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea( // 아이폰 노치 디자인 대응
        /* UI 작성 - START */
          child: SingleChildScrollView(
              child: Padding(
                    padding: EdgeInsets.all(paddingAllx2),
                // 패딩을 주고.. 그 안에 스크롤뷰를 넣으니까 패딩 안에서 스크롤이 발생함 이건 좀 바꿀필요가있겠음
                // 스크롤뷰가 있고 그 안에서 패딩을 주는게 맞을듯
                child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('기본 정보를 등록해주세요', style: TextStyle(fontSize: txtSizeBigStr, fontWeight: FontWeight.w500, color: Colors.black87),),
                  Padding(
                    padding: EdgeInsets.all(paddingItem),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          SizedBox(
                              width: height20,
                              height: height20,
                              child: CircleAvatar(
                                backgroundColor: Color(pointColor),
                                backgroundImage: NetworkImage(
                                    'https://pds.joins.com/news/component/htmlphoto_mmdata/201911/25/5400f271-49e2-4061-ad1a-5efc68ef2ec3.jpg'
                                ),
                              )
                          ),
                          Container(
                            width: height20,
                            height: height20,
                            alignment: Alignment.bottomRight,
                            child: Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                SizedBox(
                                    width: mini_circle,
                                    height: mini_circle,
                                    /*
                                형제 레벨에 floatingActionButton이 여러게일경우
                                heroTag가 구분되지 않으면
                                There are multiple heroes that share the same tag within a subtree
                                라는 오류가 남
                                */
                                    child: FloatingActionButton(
                                      heroTag: 'btnBackground',
                                      onPressed: null,
                                      backgroundColor: Color(pointColor),
                                    )
                                ),
                                SizedBox(
                                    width: mini_circle,
                                    height: mini_circle,
                                    child: FloatingActionButton(
                                      heroTag: 'btnEditImage',
                                      onPressed: null,
                                      backgroundColor: Color(pointColor),
                                      child: Icon(Icons.edit),
                                    )
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(paddingItem),
                  ),
                  TextField(
                    maxLines : 1,
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.center,
                    style : TextStyle(fontSize: txtSizeBigStr),
                    decoration: InputDecoration(
                      hintText: '닉네임을 입력하세요',
                      hintStyle: TextStyle(fontSize: txtSizeBigStr, color: Colors.black87),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(pointColor))),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black87)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(paddingItem),
                  ),
                  DropdownButton<String>(
                    isExpanded: true,
                    value: dropdownValue,
                    icon: Icon(Icons.arrow_drop_down, color: Color(pointColor)),
                    iconSize: txtSizeTopTitle,
                    elevation:16, // 1,2,3,4,6,8,9,12,16,24
                    style: TextStyle(
                        fontSize: txtSizeBigStr,
                        color: Colors.black87
                    ),
                    underline: Container(
                        height: 1,
                        color: Colors.black87
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: year_list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Center(
                            child: Text(value, style: TextStyle(
                                fontSize: txtSizeBigStr,
                                color: Colors.black87
                            ),
                            )
                        ),
                      );
                    }).toList(),
                  ),
                  Padding(
                    padding: EdgeInsets.all(paddingItem),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                      padding: const EdgeInsets.all(15.0),
                      textColor: Color(pointColor),
                      color: Colors.white,
                      splashColor: Color(pointColor2),
                      child: Text('WOMAN', style: TextStyle(fontSize: txtSizeBigStr)),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
            )
            /* UI 작성 - END */
          ),
      )
    );
  }
}
