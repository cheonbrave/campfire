import 'package:campfire/pages/join/input_code_page.dart';
import 'package:campfire/pages/join/input_profile_page.dart';
import 'package:campfire/pages/join/login_page.dart';
import 'package:campfire/pages/sub_pages/campfire_filter_page.dart';
import 'package:campfire/pages/tap_pages/campfire_page.dart';
import 'package:campfire/pages/tap_pages/matching_page.dart';
import 'package:campfire/pages/tap_pages/notification_page.dart';
import 'package:campfire/pages/tap_pages/setting_page.dart';
import 'package:campfire/pages/tap_pages/tap_page.dart';
import 'package:campfire/pages/tap_pages/team_page.dart';
import 'package:campfire/util/dbio/dbio.dart';
import 'package:campfire/util/global.dart';
import 'package:campfire/util/language/TranslationsDelegate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:campfire/consts/common_values.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

/*
main.dart
각종 기본셋팅
  - 페이지 라우팅
  - 언어 : 한국어, 일본어 개별관리
  - 테마 (디자인)
  - 홈 페이지 설정
*/

FirebaseAnalytics analytics = FirebaseAnalytics();

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  String email;

  @override
  void initState() {
    super.initState();
    _loadEmail();
  }

  void _loadEmail() async {
    // SharedPreferences의 인스턴스를 필드에 저장
    g_prefs = await SharedPreferences.getInstance();
    setState(() {
      email = (g_prefs.getString('email') ?? '');
      g_ui['email'] = email;

      g_invitation_code = (g_prefs.getString('invitation_code') ?? '');

      if (email != '' && email != null){
        DBIO dbio = new DBIO();
        dbio.find_useDocName(collection_accounts, email).then((DocumentSnapshot ds) {
          g_ui['profile_img'] = ds.data['profile_img'];
          g_ui['nickname'] = ds.data['nickname'];
          g_ui['birth_year'] = ds.data['birth_year'];
          g_ui['gender'] = ds.data['gender'];
          debugPrint('g_ui : ${g_ui.toString()}');
        });
      }
    });
    return;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CAMPFIRE',

      /* 페이지 라우팅 일단 만들어는 뒀는데 쓰이느곳은 없는상태 ~ */
      initialRoute: '/',
      routes: {
        // 여기에 '/' 에 해당하는 경로는 들어올 수 없다

        // join
        InputCodePage.routeName: (BuildContext context) =>InputCodePage(),
        InputProfilePage.routeName: (BuildContext context) =>InputProfilePage(),
        LoginPage.routeName: (BuildContext context) =>LoginPage(),

        // tap_pages
        CampfirePage.routeName: (BuildContext context) => CampfirePage(),
        MatchingPage.routeName: (BuildContext context) => MatchingPage(),
        NotificationPage.routeName: (BuildContext context) =>NotificationPage(),
        SettingPage.routeName: (BuildContext context) =>SettingPage(),
        TapPage.routeName: (BuildContext context) => TapPage(),
        TeamPage.routeName: (BuildContext context) => TeamPage(),

        // sub_pages
        CampfireFilterPage.routeName: (BuildContext context) =>CampfireFilterPage(),

      },

      /* 언어 */
      supportedLocales: [
        const Locale('ko', 'KR'), // include country code too
        const Locale('en', 'US'), // include country code too
        const Locale('ja', 'JP'), // include country code too
      ],
      localizationsDelegates: [
        const TranslationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate, // if it's a RTL language
      ],
      localeResolutionCallback: (Locale locale, Iterable<Locale> supportedLocales) {
        if (locale == null) {
          debugPrint("*language locale is null!!!");
          return supportedLocales.first;
        }
        for (Locale supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode ||
              supportedLocale.countryCode == locale.countryCode) {
            debugPrint("*language ok $supportedLocale");
            return supportedLocale;
          }
        }
        debugPrint("*language to fallback ${supportedLocales.first}");
        return supportedLocales.first;
      },


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
        fontFamily: 'Noto Sans KR', // 폰트
        // Android, IOS 모두 쿠퍼티노디자인(아이폰)의 화면전환 에니메이션을 따르도록 적용
        pageTransitionsTheme: PageTransitionsTheme(builders: {TargetPlatform.android: CupertinoPageTransitionsBuilder(),}),
      ),

      /* 홈 페이지 설정 */
      home: (email != null && email != '') ? TapPage(tapIndex: 1,) : LoginPage(), // root page에서 로그인 상태 체크

      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],

    );
  }
}