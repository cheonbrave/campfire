import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences g_prefs;

String g_ui_profile_img;
String g_ui_nickname;
String g_ui_birth_year;
String g_ui_gender;
String g_ui_email;

String g_invitation_code;

void g_setInfo(String profile_img, String nickname, String birth_year, String gender, String email){

  /* 자동로그인을 위한 email정보 저장 */
  g_prefs.setString('email', email);

  g_ui_profile_img = profile_img;
  g_ui_nickname = nickname;
  g_ui_birth_year = birth_year;
  g_ui_gender = gender;
  g_ui_email = email;
}

void g_clearInfo(){

  g_prefs.setString('email', '');

  g_ui_profile_img = '';
  g_ui_nickname = '';
  g_ui_birth_year = '';
  g_ui_gender = '';
  g_ui_email = '';
}