import 'package:campfire/pages/common/root_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:campfire/consts/common_values.dart';

void main() => runApp(MyApp());

/*
main.dart
각종 기본셋팅
  - 화면전환
  - 언어
  - 테마 (디자인)
  - 홈 페이지 설정
*/

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CAMPFIRE',

      /* 화면전환 */
      initialRoute: '/',
      routes: {
        // 여기에 '/' 에 해당하는 경로는 들어올 수 없다
        //'/root_Page': (BuildContext context) => RootPage(),
        //'/tap_page': (BuildContext context) => TapPage(),
      },

      /* 언어 */
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate, // if it's a RTL language
      ],
      supportedLocales: [
        const Locale('ko', 'KR'), // include country code too
        //const Locale('en', 'US'), // include country code too
      ],

      /* 테마 */
      theme: ThemeData(
        primarySwatch: Colors.red,
        primaryColor: Colors.white,
        backgroundColor: Colors.white,
        primaryTextTheme: TextTheme(
            title: TextStyle(
              color: Color(pointColor),
              fontSize: txtSizeMainTitle,
            )
        ),
        accentColor: Color(pointColor),
        fontFamily: 'bmjua'),

      /* 홈 페이지 설정 */
      home: RootPage(),

    );
  }
}