//*********************************************************************//
//
//
//
//
//*********************************************************************//

import 'package:firebase_database/firebase_database.dart';

class User {
  String id; // 아이디
  String pw; // 패스워드 (암호화)
  String createTime; // 생성시각

  User(
      this.id,
      this.pw,
      this.createTime);

// firebase DB에 저장하는 코드
  User.fromSnapshot(DataSnapshot snapshot)
      : id = snapshot.value['id'],
        pw = snapshot.value['pw'],
        createTime = snapshot.value['createTime'
        ];


// firebase에서 처리된 데이터를 JSON 파일로 불러오는 코드
  toJson() {
    return {
      'id': id,
      'pw': pw,
      'createTime': createTime,
    };
  }
}
