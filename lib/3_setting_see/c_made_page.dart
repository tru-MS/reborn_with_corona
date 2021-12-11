//*********************************************************************//
//
//
//
//
//*********************************************************************//

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MadePage extends StatefulWidget {
  const MadePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MadePage();
  }
}

class _MadePage extends State<MadePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('만든 이'),
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
                    border: Border.all(color: Colors.blueGrey, width: 2)),
                child: const Text(
                  '    * 한신대학교 컴퓨터공학과 캡스톤 작품 *\n\n'
                  '- 팀장 : 201558065 김민성\n'
                  '- 메인 프로그래머 : 201758044 문예찬\n'
                  '- 메인 디자이너 : 201858017 김지혜\n'
                  '\n'
                  '저희 팀은 위드코로나시대에 앞서 학교에서 사용할 수 있는 간단한 증상체크앱을 만들고 싶었습니다.\n'
                  '이 앱으로 아직 끝나지 않은 코로나에 대한 경각심과 안전을 도모하는 기회가 되었으면 합니다.\n'
                  '감사합니다.\n'
                  '',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                width: 300,
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },

                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5), //모서리
                    side: const BorderSide(color: Colors.black26, width: 1)),
                //테두리
                child: const Text('뒤로가기', style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
