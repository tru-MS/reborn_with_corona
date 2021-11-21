//*********************************************************************//
//
//
//
//
//*********************************************************************//

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reborn_with_corona/0_database/a_user_list.dart';

class CheckListPage extends StatefulWidget {
  final User? user;
  final DatabaseReference? databaseReference; // 실시간 데이터베이스 변수
  final String? id; // 로그인한 아이디

  const CheckListPage({Key? key, this.user, this.databaseReference, this.id})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CheckListPage();
  }
}

bool _ischecked = false;
bool _ischecked2 = false;
bool _ischecked3 = false;
bool _ischecked4 = false;
bool _ischecked5 = false;
bool _ischecked6 = false;
bool _ischecked7 = false;
bool _ischecked8 = false;
bool _ischecked9 = false;
bool _ischecked10 = false;
bool _ischecked11 = false;
bool _ischecked12 = false;

num value1 = 0;
num value2 = 0;
num sum =0;

// List<String> _symptoms = ["열이 있나요?"]; // listview 를 활용할 시 방법

class _CheckListPage extends State<CheckListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('증상 체크 리스트'),
        backgroundColor: Colors.green,
        leading: const Icon(Icons.content_paste_sharp),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              const ListTile(
                title: Text('공통적인 증상'),
                tileColor: Colors.cyan,
              ),
              CheckboxListTile(
                title: const Text('열이 있나요?'),
                value: _ischecked,
                tileColor: Colors.yellow,
                onChanged: (bool? value) {
                  setState(() {
                    _ischecked = value!;
                    value1 = value1+10;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('기침을 하나요?'),
                value: _ischecked2,
                tileColor: Colors.yellow,
                onChanged: (bool? value) {
                  setState(() {
                    _ischecked2 = value!;
                    value2 = value2+20;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('피로감이 있나요?'),
                value: _ischecked3,
                tileColor: Colors.yellow,
                onChanged: (bool? value) {
                  setState(() {
                    _ischecked3 = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('미각이나 후각의 상실이 있나요?'),
                value: _ischecked4,
                tileColor: Colors.yellow,
                onChanged: (bool? value) {
                  setState(() {
                    _ischecked4 = value!;
                  });
                },
              ),
              const ListTile(
                title: Text('가벼운 증상'),
                tileColor: Colors.cyan,
              ),
              CheckboxListTile(
                title: const Text('인후통이 있나요?'),
                value: _ischecked5,
                tileColor: Colors.yellow,
                onChanged: (bool? value) {
                  setState(() {
                    _ischecked5 = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('두통이 있나요?'),
                value: _ischecked6,
                tileColor: Colors.yellow,
                onChanged: (bool? value) {
                  setState(() {
                    _ischecked6 = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('몸살이 있나요?'),
                value: _ischecked7,
                tileColor: Colors.yellow,
                onChanged: (bool? value) {
                  setState(() {
                    _ischecked7 = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('설사를 하나요?'),
                value: _ischecked8,
                tileColor: Colors.yellow,
                onChanged: (bool? value) {
                  setState(() {
                    _ischecked8 = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('눈에 충혈이 있나요?'),
                value: _ischecked9,
                tileColor: Colors.yellow,
                onChanged: (bool? value) {
                  setState(() {
                    _ischecked9 = value!;
                  });
                },
              ),
              const ListTile(
                title: Text('심각한 증상'),
                tileColor: Colors.cyan,
              ),
              CheckboxListTile(
                title: const Text('호흡곤란이나 숨가쁨이 있나요?'),
                value: _ischecked10,
                tileColor: Colors.yellow,
                onChanged: (bool? value) {
                  setState(() {
                    _ischecked10 = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('언어장애가 있나요?'),
                value: _ischecked11,
                tileColor: Colors.yellow,
                onChanged: (bool? value) {
                  setState(() {
                    _ischecked11 = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('가슴 통증이 있나요?'),
                value: _ischecked12,
                tileColor: Colors.yellow,
                onChanged: (bool? value) {
                  setState(() {
                    _ischecked12 = value!;
                  });
                },
              ),
              ElevatedButton.icon(
                onPressed: () {

                  sum = value1 + value2;
                  //Navigator.of(context).pop(sum);
                },
                icon: const Icon(Icons.add, size: 13),
                label: const Text('제출'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
