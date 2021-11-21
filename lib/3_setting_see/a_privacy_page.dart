//*********************************************************************//
//
//
//
//
//*********************************************************************//

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrivacyPage extends StatefulWidget {
  const PrivacyPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PrivacyPage();
  }
}

class _PrivacyPage extends State<PrivacyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('개인정보보호 이용'),
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
                    borderRadius: BorderRadius.circular(10), //모서리를 둥글게
                    border: Border.all(color: Colors.black38, width: 1) //테두리
                    ),
                child: const Text('개인정보의 수집 및 이용 동의서\n'
                    '위드코로나 앱은 「개인정보보호법」에 의거하여, 아래와 같은 내용으로 개인정보를 수집하고 있습니다.\n'
                    '귀하께서는 아래 내용을 자세히 읽어 보시고, 모든 내용을 이해하신 후에 동의 여부를 결정해 주시기 바랍니다.\n'
                    '이용자가 제공한 모든 정보는 다음의 목적을 위해 활용하며, 하기 목적 이외의 용도로는 사용되지 않습니다.\n'
                    '① 개인정보 수집 항목 및 수집·이용 목적\n'
                    '가) 수집 항목 (필수항목)\n'
                    '- 학번, 개인 의료정보, (본인이 지정한) 사용자 위치 정보\n'
                    '나) 수집 및 이용 목적\n'
                    '- 한신대 학생 자격확인\n'
                    '- 의료정보를 활용한 코로나 위험도 평가\n'
                    '- 위치정보를 활용하여 코로나 위험도 표시\n'
                    '② 개인정보 보유 및 이용기간\n'
                    '- 수집·이용 동의일로부터 개인정보의 수집·이용목적을 달성할 때까지\n'
                    '③ 동의거부관리\n'
                    '- 귀하께서는 본 안내에 따른 개인정보 수집, 이용에 대하여 동의를 거부하실 권리가 있습니다.\n'
                    '다만, 귀하가 개인정보의 수집/이용에 동의를 거부하시는 경우에 프로그램 사용에 있어 불이익이 발생할 수 있음을 알려드립니다.\n\n'
                    '본인은 위의 동의서 내용을 충분히 숙지하였으며, 개인정보 수집, 이용, 제공하는 것에 동의합니다.\n'
                    ''
                    '\n\n'
                    '위 동의서에 동의하지 않으시면 설정창의 회원 탈퇴를 눌러 탈퇴를 해주시길 바랍니다.'),
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
