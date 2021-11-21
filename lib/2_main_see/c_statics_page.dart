//*********************************************************************//
//
//
//
//
//*********************************************************************//

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatisticsPage extends StatefulWidget {
  final DatabaseReference? databaseReference; // 실시간 데이터베이스 변수
  final String? id; // 로그인한 아이디

   const StatisticsPage({Key? key, this.databaseReference, this.id})
      : super(key: key);

  // createState() 함수는 페이지를 생성하는 함수
  @override
  State<StatefulWidget> createState() {
    return _StatisticsPage();
  }
}



class _StatisticsPage extends State<StatisticsPage> {
  @override
  void initState() {
    super.initState();
  }
/////////////////////////////////////////////////여기부터
  static const menuLocation = <String>[
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

  static const menuTime = <String>[
    '오전',
    '오후',
  ];

// 드랍다운 메뉴 선택 창
  final List<DropdownMenuItem<String>> time = menuTime
      .map(
        (String value) => DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    ),
  )
      .toList();

// 팝업 메뉴 선택 창
  final List<DropdownMenuItem<String>> location = menuLocation
      .map(
        (String value) => DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    ),
  )
      .toList();

  // popupMenu Button
  String? _location;
  String? _time;
///////////////////////////////////////////////////////////////여기까지





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('위치 지정'),
        backgroundColor: Colors.amber,
        leading: const Icon(Icons.location_city),
      ),

      body: const Center(child: Text('Press the button below!')),


      floatingActionButton: FloatingActionButton(
        onPressed: () {


          addDialog("장소 지정하기");
          //makeCard(_location!,_time!);
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void addDialog(String text) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(text),
            content: SizedBox(
              width: 280,
              height: 300,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(children: <Widget>[
                      ListTile(
                        title:  const Text('시간을 선택해 주세요 :'),
                        trailing: DropdownButton(
                          value: _time,
                          hint: const Text('선택'),
                          onChanged: (String? newValue) {
                            setState(() {
                              _time = newValue;
                            });
                          },
                          items: time,
                        ),
                      ),
                      const Divider(),
                      ListTile(
                        title: const Text("장소를 선택해 주세요 :"),
                        trailing: DropdownButton(
                          value: _location,
                          hint: const Text('선택'),
                          onChanged: (String? newValue) {
                            setState(() {
                              _location = newValue;
                            });
                          },
                          items: location,
                        ),

                      ),
                    ]),
                  ),
                ),
              ),
            ),
            actions: [
              TextButton(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/statistics');
                    Navigator.of(context).push(
                        makeCard(_location!,_time!)
                    );
                  }),
              //카드에 정보 넘겨주기

              TextButton(
                  child: const Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop("canceled");
                  }),
            ],
          );
        });
  }

  makeCard (String block,String time){
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.album),
                    title: Text(block),
                    subtitle: Text(time),
                  ),
                  /* Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child: const Text('BUY TICKETS'),
                    onPressed: () { /* ... */ },
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    child: const Text('LISTEN'),
                    onPressed: () { /* ... */ },
                  ),
                  const SizedBox(width: 8),
                ],
              ),*/
                ],
              ),
            ),
          );
        });

  }


}




