import 'package:shared_preferences/shared_preferences.dart';

String g_invitation_code;

SharedPreferences g_prefs;

Map<String, dynamic> g_ui = {
  'profile_img' : '',
  'nickname' : '',
  'birth_year' : '',
  'gender' : '',
  'email' : '',
};

Map<String, dynamic> g_team_info = {
  'members':[],
  'count':2,
  'date_type':'',
  'area':'',
  'place':'',
  'intro_img_list':['','',''],
  'tags':[],
  'is_view':'n',
  'up_time':'',
  'gender':'',   // 이곳은 팀을 개설하려는 사람의 성별을 기준으로 입력되어야야 함
};