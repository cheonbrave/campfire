import 'dart:io';
import 'package:campfire/pages/join/input_code_page.dart';
import 'package:campfire/util/dbio/dbio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:campfire/consts/common_values.dart';
import 'package:campfire/util/language/Translations.dart';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:flutter_image_compress/flutter_image_compress.dart';



enum Genders {
  man,
  woman
}

class InputProfilePage extends StatefulWidget {
  static const routeName = '/input_profile_page';

  final FirebaseUser user; // 탭화면 인덱스 수신
  InputProfilePage({Key key, @required this.user}) : super(key: key);

  @override
  _InputProfilePageState createState() => _InputProfilePageState();
}

class _InputProfilePageState extends State<InputProfilePage> {

  Genders _gender = null;
  String photoUrl = "";
  String nickname = "";

  TextEditingController input_nick;
  FocusNode inputNickFocusNode;

  TextEditingController input_birth;
  FocusNode inputBirthFocusNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    input_nick = TextEditingController();
    inputNickFocusNode = FocusNode();

    input_birth = TextEditingController();
    inputBirthFocusNode = FocusNode();

    photoUrl = widget.user.photoUrl;
    input_nick.text = widget.user.displayName;
  }

  @override
  void dispose() {
    // TODO: implement dispose

    input_nick.dispose();
    inputNickFocusNode.dispose();

    input_birth.dispose();
    inputBirthFocusNode.dispose();

    super.dispose();
  }

  /*
  DateTime today = DateTime.now();
  DateTime year_20age = null;
  String dropdownValue =  null;
  */
  // dropdownValue - null 로 설정해두면 hint값으로 표시됨

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translations.of(context).trans('app_title'), style: TextStyle(fontSize: txtSizeTopTitle, fontWeight: FontWeight.w500),),
        centerTitle: false,
        elevation: 0.0,
      ),
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: _makeBody(),
      backgroundColor: Colors.white,
    );
  }

  Widget _makeBody() {

    // 화면 전체높이에 20%
    var height20 = MediaQuery.of(context).size.height * 0.20;
    var mini_circle = height20/5.0;

    /*
    DateTime today = DateTime.now();
    year_20age = DateTime(today.year - 19); // 빠른생일따윈 이제 없으니 19살 무시, 20살부터만 사용하는걸로!
    int num_year = year_20age.year;
    List<String> year_list = new List();
    for(int i=0; i < 31; i++){
      year_list.add(num_year.toString());
      num_year--;
    }
    */

    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        child: SafeArea( // 아이폰 노치 디자인 대응
            child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: padding50, right: padding50, top: padding25, bottom: padding50),
                  child:Column(

                    /* UI 작성 - START */
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(Translations.of(context).trans('input_default_info'), style: TextStyle(fontSize: txtSizeBigStr, fontWeight: FontWeight.w500, color: Colors.black87),),
                    Padding(
                      padding: EdgeInsets.all(padding15),
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
                                  backgroundColor: Colors.black12,
                                  backgroundImage: NetworkImage(photoUrl),
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
                                        backgroundColor: Color(pointColor),
                                        child: Icon(Icons.edit),
                                        onPressed: _getImage,

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
                      padding: EdgeInsets.all(padding15),
                    ),
                    TextField(
                      controller: input_nick,
                      focusNode: inputNickFocusNode,
                      maxLines : 1,
                      maxLength: 20,
                      textAlignVertical: TextAlignVertical.center,
                      textAlign: TextAlign.center,
                      style : TextStyle(fontSize: txtSizeBigStr),
                      decoration: InputDecoration(
                        hintText: Translations.of(context).trans('input_nick'),
                        hintStyle: TextStyle(fontSize: txtSizeBigStr, color: Colors.black54),
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(pointColor))),
                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black87)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(padding15),
                    ),
                    TextField(
                      controller: input_birth,
                      focusNode: inputBirthFocusNode,
                      maxLines : 1,
                      maxLength: 4,
                      maxLengthEnforced: true,
                      textAlignVertical: TextAlignVertical.center,
                      textAlign: TextAlign.center,
                      style : TextStyle(fontSize: txtSizeBigStr),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                        hintText: Translations.of(context).trans('birth_year'),
                        hintStyle: TextStyle(fontSize: txtSizeBigStr, color: Colors.black54),
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(pointColor))),
                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black87)),
                      ),
                      onChanged: (text) {
                        if(text.length == 4){
                          /* 사용중인 포커스를 다른곳으로 옮겨줌에따라 키보드가 사라지게 된다 */
                          FocusScope.of(context).requestFocus(FocusNode());
                        }
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.all(padding15),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                            flex: 1,
                            child: Container(
                                alignment: Alignment.center,
                                child:RadioListTile<Genders>(
                                  title: Text(Translations.of(context).trans('man'),style: TextStyle(fontSize: txtSizeBigStr)),
                                  value: Genders.man,
                                  groupValue: _gender,
                                  onChanged: (Genders value) { setState(() { _gender = value; }); },
                                ),
                            )
                        ),
                        Expanded(
                            flex: 1,
                            child: Container(
                                alignment: Alignment.center,
                                child: RadioListTile<Genders>(
                                  title: Text(Translations.of(context).trans('woman'),style: TextStyle(fontSize: txtSizeBigStr)),
                                  value: Genders.woman,
                                  groupValue: _gender,
                                  onChanged: (Genders value) { setState(() { _gender = value; }); },
                                ),
                            )
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(padding15),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Builder(
                        builder: (context) {
                          return FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            padding: const EdgeInsets.all(15.0),
                            //textColor: Color(pointColor),
                            textColor: Colors.white,
                            //color: Colors.white,
                            color: Colors.black87,
                            //splashColor: Color(pointColor2),
                            splashColor: Colors.black87,
                            child: Text(Translations.of(context).trans('next'), style: TextStyle(fontSize: txtSizeBigStr)),
                            //onPressed: () => Navigator.pop(context),
                            onPressed: (){

                              if(photoUrl == '' || photoUrl == null){
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text("프로필 사진을 설정해주세요", style: TextStyle(fontSize: txtSizeMidStr),),
                                  duration: Duration(seconds: 2),
                                ));
                                return;
                              }

                              if(input_nick.text == '' || input_nick.text == null){
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text("닉네임을 입력해주세요", style: TextStyle(fontSize: txtSizeMidStr),),
                                  duration: Duration(seconds: 2),
                                ));
                                inputNickFocusNode.requestFocus();
                                return;
                              }

                              if(input_birth.text == '' || input_birth.text == null){
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text("태어난 해를 입력해주세요", style: TextStyle(fontSize: txtSizeMidStr),),
                                  duration: Duration(seconds: 2),
                                ));
                                inputBirthFocusNode.requestFocus();
                                return;
                              }

                              String _genderStr = '';
                              if(_gender == Genders.woman){
                                _genderStr = 'woman';
                              }else if(_gender == Genders.man){
                                _genderStr = 'man';
                              }else{
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text("성별을 선택해주세요", style: TextStyle(fontSize: txtSizeMidStr),),
                                  duration: Duration(seconds: 2),
                                ));
                                return;
                              }

                              Map<String, dynamic> data = {
                                'profile_img' : photoUrl,
                                'nickname' : input_nick.text,
                                'birth_year' : input_birth.text,
                                'gender' : _genderStr,
                              };

                              DBIO dbio = new DBIO();
                              dbio.upsert(collection_accounts, widget.user.email, data).then((onValue) {
                                Navigator.push(context, CupertinoPageRoute(builder: (context) => InputCodePage()));
                              });

                            },
                          );
                        },
                      ),
                    ),
                  ],
                    /* UI 작성 - END */
                ),
              )
            ),
        ),
        onTap: (){
          // 화면 터치를 통해 키보드 제거
          FocusScope.of(context).requestFocus(FocusNode());
        },
      )
    );
  }

  /* 프로필 이미지 업로드 */
  void uploadImage(File compressImgFile) {

    final fs = FirebaseStorage.instance.ref().child('accounts').child(widget.user.email).child('profile_img.jpg');
    final task = fs.putFile(compressImgFile, StorageMetadata(contentType: 'image/jpg'));
    task.onComplete.then((onValue) {
      var url = onValue.ref.getDownloadURL();
      url.then((onValue){
        setState(() {
          photoUrl = onValue;
        });
      });
    });
  }

  Future<File> compressAndGetFile(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 50,
    );

    print(file.lengthSync());
    print(result.lengthSync());

    return result;
  }

  void _cropImage(File _origin) async {

    File croppedFile = await ImageCropper.cropImage(
        sourcePath: _origin.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Edit Pictures',
            toolbarColor: Colors.white,
            toolbarWidgetColor: Color(pointColor),
            activeControlsWidgetColor: Color(pointColor),
            activeWidgetColor: Color(pointColor),
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          title: 'Edit Pictures',
          minimumAspectRatio: 1.0,
        )
    );

    setState(() {
      photoUrl = '';
    });

    final dir = await path_provider.getTemporaryDirectory();
    final targetPath = dir.absolute.path + "/temp.jpg";
    final compressImgFile = await compressAndGetFile(croppedFile, targetPath);

    uploadImage(compressImgFile);
    
  }

  void _getImage() {
    ImagePicker.pickImage(source: ImageSource.gallery).then((onValue){
      _cropImage(onValue);
    });
  }

}
