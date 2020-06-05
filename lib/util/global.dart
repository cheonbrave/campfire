import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences g_prefs;

// invitation_code
String g_invitation_code;

// profile
String g_ui_profile_img;
String g_ui_nickname;
String g_ui_birth_year;
String g_ui_gender;
String g_ui_email;

// team info
List<Map<String,String>> g_members;
int g_count;
String g_date_type;
String g_area;
String g_place;
List<String> g_intro_img_list;
List<String> g_tags;
String g_is_view;
String g_up_time;
String g_gender;

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

void g_setTeamInfo(List<Map<String,String>> members, int count, String date_type, String area, String place, List<String> intro_img_list, List<String> tags, String is_view, String up_time, String gender){
  g_members = members;
  g_count = count;
  g_date_type = date_type;
  g_area = area;
  g_place = place;
  g_intro_img_list = intro_img_list;
  g_tags = tags;
  g_is_view = is_view;
  g_up_time = up_time;
  g_gender = gender;
}

void g_clearTeamInfo(){
  g_members = null;
  g_count = 0;
  g_date_type = "";
  g_area = "";
  g_place = "";
  g_intro_img_list = null;
  g_tags = null;
  g_is_view = "";
  g_up_time = "";
  g_gender = "";
  g_gender = "";
}