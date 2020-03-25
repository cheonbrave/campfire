import 'package:flutter/material.dart';
import 'package:campfire/pages/join/login_page.dart';

class RootPage extends StatelessWidget {

  static const routeName = '/root_page';

  @override
  Widget build(BuildContext context) {

    // 로그인 상태 체크
    // 인프런에서 보면.. 여기서 스트림빌더로 로그인상태를 감시하는데 그거 하지말자
    // 스트림으로 인식해서 화면을 분기쳤더니 화면 라우팅이 골아파짐

    // 메인화면으로 보내거나, 로그인화면으로 보내는 처리 수행

    // 일단은 로그인페이지로 전환
    return LoginPage();
  }
}
