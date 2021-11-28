//*********************************************************************//
//
//
//
//
//*********************************************************************//

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reborn_with_corona/2_main_see/b_checklist_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  final DatabaseReference? databaseReference;
  final String? id;

  //메인페이지 작성후 변경하기

  //const SettingPage({Key? key,}) : super(key: key);
  const SettingPage({Key? key, this.databaseReference, this.id})
      : super(key: key);

  //메인페이지 작성후 변경하기

  @override
  State<StatefulWidget> createState() {
    return _SettingPage();
  }
}

class _SettingPage extends State<SettingPage> {
  bool pushCheck = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('설정하기'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Text(
                    '푸시 알림',
                    style: TextStyle(fontSize: 20),
                  ),
                  Switch(
                      value: pushCheck,
                      onChanged: (value) {
                        setState(() {
                          pushCheck = value;
                        });
                        _setData(value);
                      })
                ],
                mainAxisAlignment: MainAxisAlignment.spaceAround,
              ),
              const SizedBox(
                height: 50,
              ),
              MaterialButton(
                onPressed: () {
                  // 네비게이터의 모든 스택을 지우고 홈으로 이동
                  final HealthController healthController = Get.find();
                  healthController.reset();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/', (Route<dynamic> route) => false);
                },
                child: const Text('로그아웃', style: TextStyle(fontSize: 20)),
              ),
              const SizedBox(
                height: 50,
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/privacy');
                },
                child: const Text('개인정보 보호', style: TextStyle(fontSize: 20)),
              ),
              const SizedBox(
                height: 50,
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/made');
                },
                child: const Text('만든이', style: TextStyle(fontSize: 20)),
              ),
              const SizedBox(
                height: 50,
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/manual');
                },
                child: const Text('사용법', style: TextStyle(fontSize: 20)),
              ),
              const SizedBox(
                height: 50,
              ),
              MaterialButton(
                onPressed: () {
                  AlertDialog dialog = AlertDialog(
                    title: const Text('아이디 삭제'),
                    content: const Text('아이디를 삭제하시겠습니까?'),
                    actions: <Widget>[
                      MaterialButton(
                          onPressed: () {
                            print(widget.id);
                            widget.databaseReference!
                                .child('user')
                                .child(widget.id!)
                                .remove();
                            // 네비게이터의 모든 스택을 지우고 홈으로 이동
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/', (Route<dynamic> route) => false);
                          },
                          child: const Text('예')),
                      MaterialButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('아니요')),
                    ],
                  );
                  showDialog(
                      context: context,
                      builder: (context) {
                        return dialog;
                      });
                },
                child: const Text('회원 탈퇴', style: TextStyle(fontSize: 20)),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
    );
  }

  void _setData(bool value) async {
    var key = "push";
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(key, value);
  }

  void _loadData() async {
    var key = "push";
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      var value = pref.getBool(key);
      if (value == null) {
        setState(() {
          pushCheck = true;
        });
      } else {
        setState(() {
          pushCheck = value;
        });
      }
    });
  }
}