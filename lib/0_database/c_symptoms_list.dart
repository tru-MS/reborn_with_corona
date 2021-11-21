//*********************************************************************//
//
//
//
//
//*********************************************************************//
import 'package:firebase_database/firebase_database.dart';

class Symptoms {
  //String id;
  // 공통적인 증상
  num fever; // 발열
  num cough; // 기침
  num fatigue; // 피로감
  num anosmia; // 미각,후각 상실
  // 드문 증상
  num soreThroat; // 인후통
  num headAche; // 두통
  num bodyAche; // 몸살
  num diarrhea; // 설사
  num bloodshot; // 충혈
  // 심각한 증상
  num dyspnea; // 호흡곤란 또는 숨 가쁨
  num dyslogia; // 언어장애
  num chestPain; // 가슴 통증

  Symptoms(
      //this.id,
      this.fever,
      this.cough,
      this.fatigue,
      this.anosmia,
      this.soreThroat,
      this.headAche,
      this.bodyAche,
      this.diarrhea,
      this.bloodshot,
      this.dyspnea,
      this.dyslogia,
      this.chestPain);

// firebase DB에 저장하는 코드
  Symptoms.fromSnapshot(DataSnapshot snapshot)
      : //id = snapshot.value['id'],
        fever = snapshot.value['fever'],
        cough = snapshot.value['cough'],
        fatigue = snapshot.value['fatigue'],
        anosmia = snapshot.value['anosmia'],
        soreThroat = snapshot.value['soreThroat'],
        headAche = snapshot.value['headAche'],
        bodyAche = snapshot.value['bodyAche'],
        diarrhea = snapshot.value['diarrhea'],
        bloodshot = snapshot.value['bloodshot'],
        dyspnea = snapshot.value['dyspnea'],
        dyslogia = snapshot.value['dysloga'],
        chestPain = snapshot.value['chestPain'];

// firebase에서 처리된 데이터를 JSON 파일로 불러오는 코드
  toJson() {
    return {
      //'id': id,
      'fever': fever,
      'cough': cough,
      'fatigue': fatigue,
      'anosmia': anosmia,
      'soreThroat': soreThroat,
      'headAche': headAche,
      'bodyAche': bodyAche,
      'diarrhea': diarrhea,
      'bloodshot': bloodshot,
      'dyspnea': dyspnea,
      'dyslogia': dyslogia,
      'chestPain': chestPain,
    };
  }
}
