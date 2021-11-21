

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';


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


  makeCard (String block,String time){
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
                ],
              ),
            ),
          );
        }
}


class _StatisticsPage extends State<StatisticsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('위치 지정'),
      ),
      body:  Center(child:SelectionButton()),
    );
  }
}


class SelectionButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        _navigateAndDisplaySelection(context);
      },
      child: const Icon(Icons.add),
      backgroundColor: Colors.blue,
    );
  }

  // SelectionScreen을 띄우고 navigator.pop으로부터 결과를 기다리는 메서드
  _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push는 Future를 반환합니다. Future는 선택 창에서
    // Navigator.pop이 호출된 이후 완료될 것입니다.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelectionScreen()),
    );

    // 선택 창으로부터 결과 값을 받은 후, 이전에 있던 snackbar는 숨기고 새로운 결과 값을
    // 보여줍니다.
    makeCard(_location!,_time!);
  }

  makeCard (String block,String time){
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
          ],
        ),
      ),
    );
  }
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

}







class SelectionScreen extends StatelessWidget {


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

  makeCard (String block,String time){
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
                ],
              ),
            ),
          );
        }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('장소지정'),
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
              Navigator.pop(context,makeCard(_location!,_time!));

            }),
        //카드에 정보 넘겨주기

        TextButton(
            child: const Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pushNamed('/statistics');
            }),
      ],
    );
  }

  void setState(VoidCallback fn) {
    assert(fn != null);
  }
}