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
                    border: Border.all(color: Colors.lime, width: 2)),
                //테두리

                child: const Text(
                    '                       *   사용 방법 안내   *             \n\n'
                    '회원가입을 하고 로그인을 한 뒤 체크리스트 항목으로 가서 현재 나의 증상을 체크합니다.\n'
                    '증상을 제출한뒤 본인이 가려는 위치를 체크하면 그곳의 위험도를 알수있습니다'),
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
