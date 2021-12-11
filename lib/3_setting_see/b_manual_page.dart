//*********************************************************************//
//
//
//
//
//*********************************************************************//

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ManualPage extends StatefulWidget {
  const ManualPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ManualPage();
  }
}

class _ManualPage extends State<ManualPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('사용법'),
        backgroundColor: Colors.amber,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), //모서리를 둥글게
                    border: Border.all(color: Colors.lime, width: 2)),
                //테두리

                child: const Text(
                    '                       *   사용 방법 안내   *             \n\n'
                    '회원가입을 하고 로그인을 한 뒤 체크리스트 항목으로 가서 현재 나의 증상을 체크합니다.\n'
                    '증상을 체크하고 제출버튼을 누르면 증상을 점수화하여 위험도를 산정합니다.\n'
                        '사용자는 이제 위치 지정탭으로 이동하여 오른쪽 플로팅버튼을 눌러 위치지정 팝업을 엽니다.\n'
                        '그리고 오늘 가야할 위치의 장소를 찾아 오전 오후로 나뉜 체크버튼을 눌러 확인을 누릅니다.\n'
                        '그러면 위치 지정탭에 오늘의 코로나위험도를 장소, 위험도, 퍼센트, 체크인원 순으로 보여줍니다.\n'
                        '설정탭으로 들어가면 12시에 체크를 하라는 푸쉬 알림을 끄고 킬수있습니다.\n'
                        '또한 회원탈퇴와 로그아웃을 진행 할수있고 우리 앱의 정보보호법령과 사용법을 확인할 수 있습니다.\n'
                        '본 앱을 이용해주시는 모든 분들에게 감사드립니다. 코로나를 이겨내는 그 날까지 화이팅!!'),
                width: 300,
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },

                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5), //모서리
                    side: const BorderSide(
                        color: Colors.black26, width: 1)), //테두리
                child: const Text('뒤로가기', style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
