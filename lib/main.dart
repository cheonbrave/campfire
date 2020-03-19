import 'package:campfire/pages/common/root_page.dart';
import 'package:campfire/pages/join/input_code_page.dart';
import 'package:campfire/pages/join/input_profile_page.dart';
import 'package:campfire/pages/join/login_page.dart';
import 'package:campfire/pages/tap_pages/campfire_page.dart';
import 'package:campfire/pages/tap_pages/matching_page.dart';
import 'package:campfire/pages/tap_pages/notification_page.dart';
import 'package:campfire/pages/tap_pages/setting_page.dart';
import 'package:campfire/pages/tap_pages/tap_page.dart';
import 'package:campfire/pages/tap_pages/team_page.dart';
import 'package:campfire/util/language/TranslationsDelegate.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:campfire/consts/common_values.dart';

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

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CAMPFIRE',

      /* 페이지 라우팅 */
      initialRoute: '/',
      routes: {
        // 여기에 '/' 에 해당하는 경로는 들어올 수 없다
        RootPage.routeName: (BuildContext context) => RootPage(),

        InputCodePage.routeName: (BuildContext context) =>InputCodePage(),
        InputProfilePage.routeName: (BuildContext context) =>InputProfilePage(),
        LoginPage.routeName: (BuildContext context) =>LoginPage(),

        CampfirePage.routeName: (BuildContext context) => CampfirePage(),
        MatchingPage.routeName: (BuildContext context) => MatchingPage(),
        NotificationPage.routeName: (BuildContext context) =>NotificationPage(),
        SettingPage.routeName: (BuildContext context) =>SettingPage(),
        TapPage.routeName: (BuildContext context) => TapPage(),
        TeamPage.routeName: (BuildContext context) => TeamPage(),
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
      home: RootPage(), // root page에서 로그인 상태 체크

      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],

    );
  }
}