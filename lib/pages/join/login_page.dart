import 'package:campfire/pages/join/input_profile_page.dart';
import 'package:campfire/pages/tap_pages/tap_page.dart';
import 'package:campfire/util/language/Translations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:campfire/consts/common_values.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;

class LoginPage extends StatefulWidget {
  static const routeName = '/login_page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool isClicked = false;

  // Android 에서 Back 버튼 사용하면 감지해서 팝업다이얼로그 발생시키는 함수
  Future<bool> _willPopCallback() async {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          //Translations.of(context).trans('main_center_text')
          title: Text(Translations.of(context).trans('question_exit')),
          actions: <Widget>[
            FlatButton(
              child: Text(Translations.of(context).trans('response_yes')),
              onPressed: () => SystemNavigator.pop(),
            ),
            FlatButton(
              child: Text(Translations.of(context).trans('response_no')),
              onPressed: () => Navigator.pop(context, false),
            ),
          ],
        )) ??
        false;
  }

  Future<FirebaseUser> _handleSignIn() async {

    /* 반복 터치 방지 */
    if(isClicked){
      return null;
    }else{
      isClicked = true;
    }

    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    /* 구글 로그인정보를 사용해서 credential 생성 */
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    /* credential를 사용해서 파이어베이스 로그인 */
    final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
    debugPrint("_handleSignIn signed in " + user.displayName);

    isClicked = false;

    /* 파이어베이스에 기록한 사용자정보 반환 */
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // will pop scope는 화면이 pop가 발생할때 즉 화면이 distory될때를 감안한 이벤트를 줄수있으며 android의 back버튼 클릭이벤트라고 생각하면된다
      onWillPop: _willPopCallback,
      child: Scaffold(
        body: _makeBody(),
        backgroundColor: Colors.white,
      ),
    );
  }

  Widget _makeBody() {
    return Scaffold(
      body: SafeArea( // 아이폰 노치 디자인 대응
          /* UI 작성 - START */
        child:Padding(
          padding: EdgeInsets.all(padding25),
          child:Container(
            child: Align(
              alignment: Alignment.centerRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(padding15),
                  ),
                  Padding(
                    padding: EdgeInsets.all(padding15),
                  ),
                  Padding(
                    padding: EdgeInsets.all(padding15),
                  ),
                  Padding(
                    padding: EdgeInsets.all(padding15),
                  ),
                  GestureDetector(
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text('APPLE', style: TextStyle(fontSize: txtSizeTopTitle, fontWeight: FontWeight.w700),),
                        Text(' ', style: TextStyle(fontSize: txtSizeTopTitle, fontWeight: FontWeight.w700),),
                        Text('LOGIN', style: TextStyle(fontSize: txtSizeTopTitle, fontWeight: FontWeight.w700, color: Color(pointColor)),),
                      ],
                    ),
                    onTap: () {
                      debugPrint('clicked apple login');
                      //Navigator.push(context, CupertinoPageRoute(builder: (context) => InputProfilePage()));
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(padding15),
                  ),
                  GestureDetector(
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text('GOOGLE', style: TextStyle(fontSize: txtSizeTopTitle, fontWeight: FontWeight.w700),),
                          Text(' ', style: TextStyle(fontSize: txtSizeTopTitle, fontWeight: FontWeight.w700),),
                          Text('LOGIN', style: TextStyle(fontSize: txtSizeTopTitle, fontWeight: FontWeight.w700, color: Color(pointColor)),),
                        ],
                    ),
                    onTap: () => _handleSignIn().then((FirebaseUser user) {
                      if(user == null) {
                        debugPrint("_handleSignIn return is null");
                        return;
                      }
                      else {
                        /* 로그인 성공 */
                        debugPrint("_handleSignIn return user.displayName : " + user.displayName);
                        debugPrint("_handleSignIn return user.uid : " + user.uid);
                        debugPrint("_handleSignIn return user.email : " + user.email);
                        debugPrint("_handleSignIn return user.photoUrl : " + user.photoUrl);

                        /* accounts 컬렉션에서 기존 가입정보가 있는지 조회 */
                        /* 사용자의 이메일주소를 key로 갖는 document를 탐색 */

                        var fdb = Firestore.instance.collection(collection_accounts);

                        fdb.document(user.email).get().then((DocumentSnapshot ds){
                          if( ds.data == null ||
                              ds.data['profile_img'] == null ||
                              ds.data['nickname'] == null ||
                              ds.data['birth_year'] == null ||
                              ds.data['gender'] == null){
                            //debugPrint('기존 가입정보 없음~~~');
                            Navigator.push(context, CupertinoPageRoute(builder: (context) => InputProfilePage(user: user,)));
                          }else{
                            //debugPrint('기존 가입정보 있음!!!');
                            Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => TapPage(tapIndex: 1)), ModalRoute.withName(TapPage.routeName));
                          }
                        });

                      }

                    }),
                  ),
                  Padding(
                    padding: EdgeInsets.all(padding20),
                  ),
                  Text(Translations.of(context).trans('intro_1'), style: TextStyle(fontSize: txtSizeAppBarTitle, fontWeight: FontWeight.w700),),
                  Text(Translations.of(context).trans('intro_2'), style: TextStyle(fontSize: txtSizeAppBarTitle, fontWeight: FontWeight.w700),),
                  Padding(
                    padding: EdgeInsets.all(padding20),
                  ),
                  Text(Translations.of(context).trans('app_title'), style: TextStyle(fontSize: txtSizeMainTitle, fontWeight: FontWeight.w700, color: Color(pointColor)),),
                ],
              ),
            ),
          ),
          /* UI 작성 - END */
        )
      )
    );
  }
}
