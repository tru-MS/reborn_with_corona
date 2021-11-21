//*********************************************************************//
// 1,2,3번 체크리스트 통계창 세팅화면의 기본틀을 보여주는 항목이다.
//
//
//
//*********************************************************************//

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'b_checklist_page.dart';
import 'c_statics_page.dart';
import 'd_setting_page.dart';
// import 'package:sqflite/sqflite.dart'; // 내부 sqllite database 생성

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  // final Future<Database> database;
  // MainPage(this.database);

  @override
  State<StatefulWidget> createState() {
    return _MainPage();
  }
}

class _MainPage extends State<MainPage> with SingleTickerProviderStateMixin {
  // single?
  TabController? controller; // 탭으로 나눔
  FirebaseDatabase? _database;
  DatabaseReference? reference;
  final String _databaseURL =
      'https://reborn-with-corona-default-rtdb.firebaseio.com/';
  String? id;

  bool pushCheck = true;

  // 위젯이 생성될 때 호출
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this); // 3개의 탭창
    _database = FirebaseDatabase(databaseURL: _databaseURL);
    reference = _database!.reference().child('view');
  }

  // 위젯이 완전히 종료될때 호출
  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 로그인때 사용한 아이디 가져오기
    id = ModalRoute.of(context)!.settings.arguments as String?;
    return Scaffold(
        body: TabBarView(
          children: <Widget>[
            // TabBarView에 채울 위젯들
            CheckListPage(
              databaseReference: reference,
              id: id,
            ),
            StatisticsPage(
              databaseReference: reference,
              id: id,
            ),
            SettingPage(
              databaseReference: reference,
              id: id,
            )
          ],
          controller: controller,
        ),
        bottomNavigationBar: TabBar(
          tabs: const <Tab>[
            Tab(
              icon: Icon(Icons.check_box),
            ),
            Tab(
              icon: Icon(Icons.view_agenda),
            ),
            Tab(
              icon: Icon(Icons.settings),
            )
          ],
          labelColor: Colors.amber,
          indicatorColor: Colors.deepOrangeAccent,
          controller: controller,
        ));
  }
}
