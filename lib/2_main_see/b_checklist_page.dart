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
import 'package:reborn_with_corona/0_database/a_user_list.dart';

/// 증상 점수를 관리하는 컨트롤러
class HealthController extends GetxController{
  var totalHealthValue = 0.obs;

  var checkList = <bool>[].obs;

  var isSubmitted = false.obs;
  var showDialog = true.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    for(int i = 0 ; i<12 ; i++){
      checkList.add(false);
    }
  }

  void resetData(){
    for(int i = 0 ; i <12 ; i++){
      checkList[i] = false;
    }
    totalHealthValue.value = 0;
    isSubmitted.value = false;
  }

}

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

class _CheckListPage extends State<CheckListPage> {

  @override
  Widget build(BuildContext context) {
    ///증상 점수를 관리하는 컨트롤러
    final HealthController healthController = Get.find();
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
                value: healthController.checkList[0],
                tileColor: Colors.yellow,
                onChanged: (bool? value) {
                  if(value!){
                    healthController.totalHealthValue.value += 15;
                  }
                  else{
                    healthController.totalHealthValue.value -= 15;
                  }
                  setState(() {
                    healthController.checkList[0] = value;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('기침을 하나요?'),
                value: healthController.checkList[1],
                tileColor: Colors.yellow,
                onChanged: (bool? value) {
                  if(value!){
                    healthController.totalHealthValue.value += 15;
                  }
                  else{
                    healthController.totalHealthValue.value -= 15;
                  }
                  setState(() {
                    healthController.checkList[1] = value;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('피로감이 있나요?'),
                value: healthController.checkList[2],
                tileColor: Colors.yellow,
                onChanged: (bool? value) {
                  if(value!){
                    healthController.totalHealthValue.value += 12;
                  }
                  else{
                    healthController.totalHealthValue.value -= 12;
                  }
                  setState(() {
                    healthController.checkList[2] = value;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('미각이나 후각의 상실이 있나요?'),
                value: healthController.checkList[3],
                tileColor: Colors.yellow,
                onChanged: (bool? value) {
                  if(value!){
                    healthController.totalHealthValue.value += 2;
                  }
                  else{
                    healthController.totalHealthValue.value -= 2;
                  }
                  setState(() {
                    healthController.checkList[3] = value;
                  });
                },
              ),
              const ListTile(
                title: Text('가벼운 증상'),
                tileColor: Colors.cyan,
              ),
              CheckboxListTile(
                title: const Text('인후통이 있나요?'),
                value: healthController.checkList[4],
                tileColor: Colors.yellow,
                onChanged: (bool? value) {
                  if(value!){
                    healthController.totalHealthValue.value += 4;
                  }
                  else{
                    healthController.totalHealthValue.value -= 4;
                  }
                  setState(() {
                    healthController.checkList[4] = value;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('두통이 있나요?'),
                value: healthController.checkList[5],
                tileColor: Colors.yellow,
                onChanged: (bool? value) {
                  if(value!){
                    healthController.totalHealthValue.value += 4;
                  }
                  else{
                    healthController.totalHealthValue.value -= 4;
                  }
                  setState(() {
                    healthController.checkList[5] = value;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('몸살이 있나요?'),
                value: healthController.checkList[6],
                tileColor: Colors.yellow,
                onChanged: (bool? value) {
                  if(value!){
                    healthController.totalHealthValue.value += 14;
                  }
                  else{
                    healthController.totalHealthValue.value -= 14;
                  }
                  setState(() {
                    healthController.checkList[6] = value;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('설사를 하나요?'),
                value: healthController.checkList[7],
                tileColor: Colors.yellow,
                onChanged: (bool? value) {
                  if(value!){
                    healthController.totalHealthValue.value += 8;
                  }
                  else{
                    healthController.totalHealthValue.value -= 8;
                  }
                  setState(() {
                    healthController.checkList[7]= value;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('눈에 충혈이 있나요?'),
                value: healthController.checkList[8],
                tileColor: Colors.yellow,
                onChanged: (bool? value) {
                  if(value!){
                    healthController.totalHealthValue.value += 2;
                  }
                  else{
                    healthController.totalHealthValue.value -= 2;
                  }
                  setState(() {
                    healthController.checkList[8] = value;
                  });
                },
              ),
              const ListTile(
                title: Text('심각한 증상'),
                tileColor: Colors.cyan,
              ),
              CheckboxListTile(
                title: const Text('호흡곤란이나 숨가쁨이 있나요?'),
                value: healthController.checkList[9],
                tileColor: Colors.yellow,
                onChanged: (bool? value) {
                  if(value!){
                    healthController.totalHealthValue.value += 14;
                  }
                  else{
                    healthController.totalHealthValue.value -= 14;
                  }
                  setState(() {
                    healthController.checkList[9] = value;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('언어장애가 있나요?'),
                value: healthController.checkList[10],
                tileColor: Colors.yellow,
                onChanged: (bool? value) {
                  if(value!){
                    healthController.totalHealthValue.value += 2;
                  }
                  else{
                    healthController.totalHealthValue.value -= 2;
                  }
                  setState(() {
                    healthController.checkList[10] = value;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('가슴 통증이 있나요?'),
                value: healthController.checkList[11],
                tileColor: Colors.yellow,
                onChanged: (bool? value) {
                  if(value!){
                    healthController.totalHealthValue.value += 8;
                  }
                  else{
                    healthController.totalHealthValue.value -= 8;
                  }
                  setState(() {
                    healthController.checkList[11] = value;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      healthController.isSubmitted.value = true;
                    },
                    icon: const Icon(Icons.add, size: 13),
                    label: const Text('제출'),
                  ),
                  SizedBox(width: 20,),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/manual');
                    },
                    icon: const Icon(Icons.flag, size: 13),
                    label: const Text('사용법'),
                  ),
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}
