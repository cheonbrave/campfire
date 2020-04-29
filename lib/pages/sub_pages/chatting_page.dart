import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:campfire/consts/common_values.dart';

class ChattingPage extends StatefulWidget {
  static const routeName = '/chatting_page';
  @override
  _ChattingPageState createState() => _ChattingPageState();
}

class _ChattingPageState extends State<ChattingPage> {

  // 입력한 메시지를 저장하는 리스트
  final List<ChatMessage> _message = <ChatMessage>[];

  // 텍스트필드 제어용 컨트롤러
  final TextEditingController _textController = TextEditingController();

  // 텍스트필드에 입력된 데이터의 존재 여부
  bool _isComposing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CHATTING', style: TextStyle(fontSize: txtSizeTopTitle)),
        elevation: 1.0,
      ),
      endDrawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('대화상대', style: TextStyle(fontSize: txtSizeMidStr, fontWeight: FontWeight.w700, color: Color(pointColor)),),
              onTap: () {
                // Update the state of the app.
              },
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Color(pointColor),
                backgroundImage: NetworkImage(
                    'https://pds.joins.com/news/component/htmlphoto_mmdata/201911/25/5400f271-49e2-4061-ad1a-5efc68ef2ec3.jpg'
                ),
              ),
              title: Text('나', style: TextStyle(fontSize: txtSizeMidStr, color: Colors.black87),),
              onTap: () {
                // Update the state of the app.
              },
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Color(pointColor),
                backgroundImage: NetworkImage(
                    'https://pds.joins.com/news/component/htmlphoto_mmdata/201911/25/5400f271-49e2-4061-ad1a-5efc68ef2ec3.jpg'
                ),
              ),
              title: Text('천용기', style: TextStyle(fontSize: txtSizeMidStr, color: Colors.black87),),
              onTap: () {
                // Update the state of the app.
              },
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Color(pointColor),
                backgroundImage: NetworkImage(
                    'https://pds.joins.com/news/component/htmlphoto_mmdata/201911/25/5400f271-49e2-4061-ad1a-5efc68ef2ec3.jpg'
                ),
              ),
              title: Text('손민수', style: TextStyle(fontSize: txtSizeMidStr, color: Colors.black87),),
              onTap: () {
                // Update the state of the app.
              },
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Color(pointColor),
                backgroundImage: NetworkImage(
                    'https://pds.joins.com/news/component/htmlphoto_mmdata/201911/25/5400f271-49e2-4061-ad1a-5efc68ef2ec3.jpg'
                ),
              ),
              title: Text('고범진', style: TextStyle(fontSize: txtSizeMidStr, color: Colors.black87),),
              onTap: () {
                // Update the state of the app.
              },
            ),
          ],
        ),
      ),
      body: _makeBody(),
      backgroundColor: Colors.white,
    );
  }

  Widget _makeBody() {

    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        child: SafeArea( // 아이폰 노치 디자인 대응
          child: Column(
            children: <Widget>[
              // 리스트뷰를 Flexible로 추가.
              Flexible(
                // 리스트뷰 추가
                child: ListView.builder(
                  padding: const EdgeInsets.all(padding20),
                  // 리스트뷰의 스크롤 방향을 반대로 변경. 최신 메시지가 하단에 추가됨
                  reverse: true,
                  itemCount: _message.length,
                  itemBuilder: (_, index) => _message[index],
                ),
              ),
              // 구분선
              Divider(height: 1.0),
              // 메시지 입력을 받은 위젯(_buildTextCompose)추가
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                ),
                child: _buildTextComposer(),
              )
            ],
          ),
        ),
        onTap: (){
          // 화면 터치를 통해 키보드 제거
          FocusScope.of(context).requestFocus(FocusNode());
        },
      )
    );
  }

  // 사용자로부터 메시지를 입력받는 위젯 선언
  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme
          .of(context)
          .accentColor),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // 텍스트 입력 필드
            Flexible(
              child: TextField(
                controller: _textController,
                // 입력된 텍스트에 변화가 있을 때 마다
                onChanged: (text) {
                  setState(() {
                    _isComposing = text.length > 0;
                  });
                },
                // 키보드상에서 확인을 누를 경우. 입력값이 있을 때에만 _handleSubmitted 호출
                onSubmitted: _isComposing ? _handleSubmitted : null,
                // 텍스트 필드에 힌트 텍스트 추가
                style : TextStyle(fontSize: txtSizeBigStr),
                /*
                keyboardType: TextInputType.multiline,
                maxLines: null,
                 */
                decoration: InputDecoration(
                  hintText: "Send a message",
                  hintStyle: TextStyle(fontSize: txtSizeMidStr, color: Colors.black54),
                  contentPadding: const EdgeInsets.all(padding20),
                ),
              ),
            ),
            // 전송 버튼
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              // 플랫폼 종류에 따라 적당한 버튼 추가
              child: IconButton(
                // 아이콘 버튼에 전송 아이콘 추가
                splashColor: Colors.white,
                icon: Icon(Icons.send),
                // 입력된 텍스트가 존재할 경우에만 _handleSubmitted 호출
                onPressed: _isComposing
                    ? () => _handleSubmitted(_textController.text)
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 메시지 전송 버튼이 클릭될 때 호출
  void _handleSubmitted(String text) {
    // 텍스트 필드의 내용 삭제
    _textController.clear();
    // _isComposing을 false로 설정
    setState(() {
      _isComposing = false;
    });
    // 입력받은 텍스트를 이용해서 리스트에 추가할 메시지 생성
    ChatMessage message = ChatMessage(
      text: text,
      isMe: true,
      name: "my_name",
    );
    // 리스트에 메시지 추가
    setState(() {
      _message.insert(0, message);
    });

    ChatMessage message2 = ChatMessage(
      text: text,
      isMe: false,
      name: "상대방",
    );
    // 리스트에 메시지 추가
    setState(() {
      _message.insert(0, message2);
    });

  }

  @override
  void dispose() {
    super.dispose();
  }
}

// 리스브뷰에 추가될 메시지 위젯
class ChatMessage extends StatelessWidget {


  final String text; // 출력할 메시지
  final bool isMe; // 출력할 메시지
  final String name; // 출력할 메시지

  ChatMessage({this.text, this.isMe, this.name});

  @override
  Widget build(BuildContext context) {

    Widget w_chat;

    if(isMe){
      w_chat = Container(
        margin: const EdgeInsets.symmetric(vertical: padding10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              // 컬럼 추가
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  /*Text(name, style: TextStyle(fontSize: txtSizeMidStr, fontWeight: FontWeight.w500)),*/
                  // 입력받은 메시지 출력
                  Row(
                     mainAxisAlignment: MainAxisAlignment.end,
                     children: <Widget>[
                       Container(
                         margin: const EdgeInsets.only(top: padding15, right: padding5),
                         child: Text('PM 1:30',style: TextStyle(fontSize: txtSizeExplain, color: Colors.black45)),
                       ),
                       Container(
                         margin: const EdgeInsets.only(top: padding5),
                         child: Text(text, style: TextStyle(fontSize: txtSizeMidStr)),
                         padding: const EdgeInsets.only(left: padding10, right: padding10, top: padding5, bottom: padding5),
                         decoration: BoxDecoration(
                            color: Colors.yellow,
                            border: Border.all(width: 1.0, color: Colors.yellow),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            )
                         ),
                       ),
                     ],
                  )
                ],
              ),
            ),
            /*Container(
              margin: const EdgeInsets.only(left: padding15),
              // 사용자명의 첫번째 글자를 서클 아바타로 표시
              child: CircleAvatar(child: Text(name[0], style: TextStyle(fontSize: txtSizeMidStr),)),
            ),*/
          ],
        ),
      );
    }else{
      w_chat = Container(
        margin: const EdgeInsets.symmetric(vertical: padding10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: padding5),
                ),
                Container(
                  margin: const EdgeInsets.only(right: padding15),
                  // 사용자명의 첫번째 글자를 서클 아바타로 표시
                  child: CircleAvatar(
                    backgroundColor: Color(pointColor),
                    backgroundImage: NetworkImage(
                        'https://pds.joins.com/news/component/htmlphoto_mmdata/201911/25/5400f271-49e2-4061-ad1a-5efc68ef2ec3.jpg'
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              // 컬럼 추가
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(name, style: TextStyle(fontSize: txtSizeSmlStr)),
                  // 입력받은 메시지 출력
                  Row(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: padding5),
                        child: Text(text, style: TextStyle(fontSize: txtSizeMidStr)),
                        padding: const EdgeInsets.only(left: padding10, right: padding10, top: padding5, bottom: padding5),
                        decoration: BoxDecoration(
                            color: Color(pointColor2),
                            border: Border.all(width: 1.0, color: Color(pointColor2)),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            )
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: padding15, left: padding5),
                        child: Text('PM 1:30',style: TextStyle(fontSize: txtSizeExplain, color: Colors.black45)),
                      ),

                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }

    return w_chat;
  }
}