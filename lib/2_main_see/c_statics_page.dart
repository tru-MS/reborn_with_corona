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
import 'package:reborn_with_corona/0_database/history.dart';
import 'package:reborn_with_corona/2_main_see/a_main_page.dart';
import 'package:reborn_with_corona/2_main_see/b_checklist_page.dart';

/// 장소들 및 장소들에 대한 정보를 관리하는 컨트롤러
class LocationController extends GetxController{
  final menuLocation = <String>[ // 오전 9개 , 오후 9개 순서대로 ex: 장공관(본관) 오전 == 0 , 장공관(본관) 오후 == 1
    '장공관(본관)',
    '필헌관(대학원)',
    '장준화통일관(구 18관)',
    '경삼관(도서관/대학일자리센터)',
    '늦봄관',
    '만우관',
    '소통관(교수동)',
    '성빈학사',
    '송암관',
    '임마누엘관',
    '한울관',
    '해오름관',
    '샬롬채플관',
    '실습동(창업지원관)',
  ];
  var totalStudentNumber = <int>[].obs;
  var totalHealthNumber = <int>[].obs;
  var totalDangerInfo = <int>[].obs;

  var locationCheckList = <bool>[].obs;

  var locationList = <int>[].obs;

  var historyList = <History>[].obs;

  bool flag = false;
  int timeStamp = DateTime.now().year*10000+DateTime.now().month*100+DateTime.now().day;

  @override
  Future<void> onInit() async {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {

    final DataController dataController = Get.find();
    final historyReference = dataController.database!.reference().child("history");

    final userReference = dataController.database!.reference().child("userList");
    final userSnapshot = await userReference.get();
    List<String> userList = [];

    for(String string in userSnapshot.value['userList']){
      userList.add(string);
    }
    totalStudentNumber = <int>[].obs;
    totalHealthNumber = <int>[].obs;
    totalDangerInfo = <int>[].obs;

    for(int i = 0 ; i<18 ; i++){
      totalStudentNumber.add(0);
      totalHealthNumber.add(0);
      totalDangerInfo.add(0);
    }

    ///모든 유저들의 history 정보를 불러와서 장소에 대한 정보를 업데이트 ( ex : 제출 점수 총합 , 학생 수 총합 , 위험도 )
    for(String userId in userList){
      await historyReference.child(userId).once().then(
              (DataSnapshot dataSnapshot){
            if(dataSnapshot.value !=null){
              History history = History.fromJson(dataSnapshot.value);
              for(int i = 0 ; i<18 ; i++){
                if(history.checkList[i] && history.timeStamp == timeStamp){
                  totalHealthNumber[i] += history.health;
                  totalStudentNumber[i] ++;
                }
              }
            }
          }
      );
    }

    ///학생 총 수와 총 제출 정보로 위험도 업데이트
    for(int i = 0 ; i<18 ; i++){
      double danger = totalHealthNumber[i]/totalStudentNumber[i];
      if(danger<10){totalDangerInfo[i]=0;}
      else if(totalStudentNumber[i]==0){totalDangerInfo[i]=0;}
      else if(10<=danger && danger<20){totalDangerInfo[i]=1;}
      else{totalDangerInfo[i]=2;}
      print("[QWER] total health $i :${totalHealthNumber[i]} , total student ${totalStudentNumber[i]} , totalDander : ${totalDangerInfo[i]}");
    }



    ///이전 장소 제출 정보 load
    ///만약 제출 정보의 timeStamp 가 같다면 load ( timeStamp 날짜 )
    ///아니라면 history 정보 삭제
    historyReference.child(dataController.userId).once().then(
            (DataSnapshot dataSnapshot){
          if(dataSnapshot.value != null){
            History history = History.fromJson(dataSnapshot.value);
            if(history.timeStamp == timeStamp){
              locationList.value = history.locationList;
              locationCheckList.value = history.checkList;
            }
            else{
              historyReference.child(dataController.userId).remove();
              for(int i = 0 ; i<18 ; i++){
                locationCheckList.add(false);
              }
            }
          }
          else{
            for(int i = 0 ; i<18 ; i++){
              locationCheckList.add(false);
            }
          }
        }

    );
    for(int i = 0 ; i<locationList.length ; i++){
      print("[QWER] location : ${locationList[i]}");
    }
    update();
  }

  void reset(){
    for(int i = 0 ; i<18 ; i++){
      locationCheckList[i] = false;
    }
  }
}

class StatisticsPage extends StatefulWidget {

  // createState() 함수는 페이지를 생성하는 함수
  @override
  State<StatefulWidget> createState() {
    return _StatisticsPage();
  }
}

class _StatisticsPage extends State<StatisticsPage> {

  @override
  Widget build(BuildContext context) {

    /// 장소들 및 장소들에 대한 정보를 관리하는 컨트롤러
    final LocationController locationController = Get.find();

    ///플로팅 버튼을 통해 장소들을 추가한 후 OK를 눌렀을 때 장소들의 정보를 업데이트 하는 함수
    Future<void> updateLocationList() async {

      final DataController dataController = Get.find();

      final historyReference = dataController.database!.reference().child("history");
      final HealthController healthController = Get.find();

      /// 장소 순서대로 정렬
      for(int i = 0 ; i<locationController.locationList.length ; i++){
        for(int j = i +1 ; j<locationController.locationList.length ; j++){
          if(locationController.locationList[i] > locationController.locationList[j]){
            int temp = locationController.locationList[i];
            locationController.locationList[i] = locationController.locationList[j];
            locationController.locationList[j] = temp;
          }
        }
      }

      print("[QWER] location list :${locationController.locationList.toString()}");

      /// 이미 장소를 정한적이 있다면 업데이트, 없다면 장소선택에 대한 정보를 DB 에 업데이트
      historyReference.child(dataController.userId).once().then(
          (DataSnapshot dataSnapshot){
            if(dataSnapshot.value == null){
              historyReference.child(dataController.userId).set({
                "health": healthController.totalHealthValue.value,
                "timeStamp" : locationController.timeStamp,
                "locationList" : locationController.locationList,
                "checkList" : locationController.locationCheckList
              });
            }
            else{
              historyReference.child(dataController.userId).update(
                  {
                    "health": healthController.totalHealthValue.value,
                    "timeStamp" : locationController.timeStamp,
                    "locationList" : locationController.locationList,
                    "checkList" : locationController.locationCheckList
                  }
              );
            }
          }
      );

      /// 업데이트 된 정보를 reload
      await locationController.loadData();

      setState(() {
        locationController.flag = !locationController.flag;
      });
    }

    ///플로팅 버튼 눌렀을 때 장소 추가하는 UI
    void addDialog(String text) {
      showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(
                builder: (context , setState){
                  return AlertDialog(
                    title: Text(text),
                    content: SizedBox(
                        width: 280,
                        height: 350,
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              child: Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children: List.generate( 9, (position){
                                  return Container(
                                      width: 250,
                                      height: 100,
                                      color: Color(0xffeeeeee),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 250,
                                            height: 40,
                                            color: Color(0xffdddddd),
                                            child:Text(locationController.menuLocation[position]),
                                          ),
                                          Row(
                                            children: [
                                              Text("오전"),
                                              Checkbox(
                                                  value: locationController.locationCheckList[position*2],
                                                  onChanged: (value){
                                                    if(value!){
                                                      if(!locationController.locationList.contains(position))
                                                        {
                                                          locationController.locationList.add(position);
                                                        }
                                                    }
                                                    else{
                                                      if(locationController.locationCheckList[position*2+1]==false){
                                                        locationController.locationList.remove(position);
                                                      }
                                                    }
                                                    setState(() {
                                                      locationController.locationCheckList[position*2] = value;
                                                    });

                                                  }
                                              ),
                                              Text("오후"),
                                              Checkbox(
                                                  value: locationController.locationCheckList[position*2+1],
                                                  onChanged: (value){
                                                    if(value!){
                                                      if(!locationController.locationList.contains(position))
                                                        {
                                                          locationController.locationList.add(position);
                                                        }
                                                    }
                                                    else{
                                                      if(locationController.locationCheckList[position*2]==false){
                                                        locationController.locationList.remove(position);
                                                      }
                                                    }
                                                    setState(() {
                                                      locationController.locationCheckList[position*2+1] = value;
                                                    });
                                                  }
                                              )
                                            ],
                                          ),
                                        ],
                                      )
                                  );
                                },
                                ),
                              ),
                            ))
                    ),
                    actions: [
                      TextButton(
                          child: const Text("OK"),
                          onPressed: () {
                            updateLocationList();
                            Navigator.pop(context);
                          }),
                      //카드에 정보 넘겨주기

                      TextButton(
                          child: const Text("Cancel"),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    ],
                  );
                }
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('위치 지정'),
        backgroundColor: Colors.amber,
        leading: const Icon(Icons.location_city),
      ),
      /// 선택한 장소 정보 없을 때 / 있을 때 UI 분리
      body: locationController.locationList.isEmpty? const Center(child: Text('오른쪽 아래 버튼을 눌러 장소를 추가해 주세요!'))
          :
          /// 위험도가 표시되는 UI
          ListView.separated(
            scrollDirection: Axis.vertical,
            itemCount: locationController.locationList.length,
              separatorBuilder: (context , idx){
                return SizedBox(
                  height: 30,
                );
              },
              itemBuilder: (context , index){
              print("[QWER] s : ${locationController.locationList[index]*2} , index : $index");
              print("[QWER] check :${locationController.totalDangerInfo[locationController.locationList[index]*2]} , ${locationController.locationCheckList[locationController.locationList[index]*2+1]}");
                return Container(
                  height: 80,
                  color: Colors.grey,
                  child: Row(
                    children: [
                      SizedBox(width: 15,),
                      Text(locationController.menuLocation[locationController.locationList[index]]),
                      SizedBox(width: 15,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          /// 오전 UI
                          (locationController.locationCheckList[locationController.locationList[index]*2])?
                          Row(
                            children: [
                              Text("오전"),
                              SizedBox(width: 15,),
                              Text("위험도 : ${
                                  locationController.totalDangerInfo[locationController.locationList[index]*2]==0?"안전":
                                  locationController.totalDangerInfo[locationController.locationList[index]*2]==1?"주의":"위험"}"),
                              SizedBox(width: 15,),
                              Text("${locationController.totalHealthNumber[locationController.locationList[index]*2]/locationController.totalStudentNumber[locationController.locationList[index]*2]} 점")
                            ],
                          ):Container(),
                          /// 오후 UI
                          (locationController.locationCheckList[locationController.locationList[index]*2+1])?
                          Row(
                            children: [
                              Text("오후"),
                              SizedBox(width: 15,),
                              Text("위험도 : ${
                                  locationController.totalDangerInfo[locationController.locationList[index]*2+1]==0?"안전":
                                  locationController.totalDangerInfo[locationController.locationList[index]*2+1]==1?"주의":"위험"}"),
                              SizedBox(width: 15,),
                              Text("${locationController.totalHealthNumber[locationController.locationList[index]*2+1]/locationController.totalStudentNumber[locationController.locationList[index]*2+1]} 점")
                            ],
                          ):Container()
                        ],
                      )
                    ],
                  ),
                );
              }
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addDialog("장소 지정하기");
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }


}
