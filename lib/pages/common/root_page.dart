import 'package:flutter/material.dart';
import 'package:campfire/pages/join/login_page.dart';

class RootPage extends StatelessWidget {

  static const routeName = '/root_page';

  @override
  Widget build(BuildContext context) {

    // 로그인 상태 체크

    // 메인화면으로 보내거나, 로그인화면으로 보내는 처리 수행

    // 일단은 로그인페이지로 전환
    return LoginPage();
  }
}
