//*********************************************************************//
// 1,2,3번 체크리스트 통계창 세팅화면의 기본틀을 보여주는 항목이다.
//
//
//
//*********************************************************************//

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'b_checklist_page.dart';
import 'c_statics_page.dart';
import 'd_setting_page.dart';
// import 'package:sqflite/sqflite.dart'; // 내부 sqllite database 생성

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MainPage();
  }
}

class DataController extends GetxController{

  final String userId;
  final String _databaseURL = 'https://reborn-with-corona-default-rtdb.firebaseio.com/';

  FirebaseDatabase? database;
  DataController(this.userId);

  @override
  Future<void> onInit() async {
    super.onInit();
    database = FirebaseDatabase(databaseURL: _databaseURL);
  }

}

class _MainPage extends State<MainPage> with SingleTickerProviderStateMixin {
  // single?
  TabController? controller; // 탭으로 나눔
  String? id;

  // 위젯이 생성될 때 호출
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this); // 3개의 탭창
    final HealthController healthController = Get.put(HealthController());

    /// 탭바 컨트롤러에 제출을 하지 않았다면 다른 탭으로 이동하지 못하게 listener 추가 및 다이얼로그 생성
    controller!.addListener(() {
      if(controller!.indexIsChanging){
        if(!healthController.isSubmitted.value){
          if(healthController.showDialog.value){
            healthController.showDialog.value = false;
            showDialog(
              barrierDismissible: false,
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    content: SizedBox(
                      height: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("증상 진단을 제출해 주세요."),
                          SizedBox(
                            width: 100,
                            height: 50,
                            child: TextButton(
                                onPressed: (){
                                  healthController.showDialog.value = true;
                                  Navigator.pop(context);
                                },
                                child: Text("확인")
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }
          controller!.animateTo(0);
        }
      }
    });
    /////////////////////////////////////////
  }

  // 위젯이 완전히 종료될때 호출
  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final LocationController locationController = Get.put(LocationController());
    // 로그인때 사용한 아이디 가져오기
    return Scaffold(
        body: TabBarView(
          children: <Widget>[
            // TabBarView에 채울 위젯들
            CheckListPage(),
            StatisticsPage(),
            SettingPage()
          ],
          controller: controller,
        ),
        bottomNavigationBar: TabBar(
          tabs: const <Tab>[
            Tab(
              icon: Icon(Icons.check_box),
              text: "증상",
            ),
            Tab(
              icon: Icon(Icons.view_agenda),
              text: "장소",
            ),
            Tab(
              icon: Icon(Icons.settings),
              text: "설정",
            )
          ],
          labelColor: const Color(0xFF616161),//0xffE6C800
          indicatorColor: Colors.orangeAccent,
          controller: controller,
        ));
  }
}
