//*********************************************************************//
//
//
//
//
//*********************************************************************//

import 'package:firebase_database/firebase_database.dart';

class Location {
  num jangGong; // 장공관(본관)
  num philHeon; // 필헌관(대학원)
  num jangJunha; // 장준하통일관
  num gyeongSam; // 경삼관(도서관/대학일자리센터)
  num neujBom; // 늦봄관
  num manWoo; // 만우관
  num soTong; // 소통관(교수동)
  num seongBin; // 성빈학사
  num sonGam; // 송암관
  num imMaNuel; // 임마누엘관(학생회관)
  num hanUl; // 한울관
  num haeOreum; // 해오름관
  num shaLom; // 샬롬채플관
  num practiceBuilding; // 실습동(창업지원관)

  Location(
    this.jangGong,
    this.philHeon,
    this.jangJunha,
    this.gyeongSam,
    this.neujBom,
    this.manWoo,
    this.soTong,
    this.seongBin,
    this.sonGam,
    this.imMaNuel,
    this.hanUl,
    this.haeOreum,
    this.shaLom,
    this.practiceBuilding,
  );

// firebase DB에 저장하는 코드
  Location.fromSnapShot(DataSnapshot snapshot)
      : jangGong = snapshot.value['jangGong'],
        philHeon = snapshot.value['philHeon'],
        jangJunha = snapshot.value['jangJunha'],
        gyeongSam = snapshot.value['gyeongSam'],
        neujBom = snapshot.value['neujBom'],
        manWoo = snapshot.value['manWoo'],
        soTong = snapshot.value['soTong'],
        seongBin = snapshot.value['seongBin'],
        sonGam = snapshot.value['sonGam'],
        imMaNuel = snapshot.value['imMaNuel'],
        hanUl = snapshot.value['hanUl'],
        haeOreum = snapshot.value['haeOreum'],
        shaLom = snapshot.value['shaLom'],
        practiceBuilding = snapshot.value['practiceBuilding'];

  // firebase에서 처리된 데이터를 JSON 파일로 불러오는 코드
  toJson() {
    return {
      'jangGong': jangGong,
      'philHeon': philHeon,
      'jangJunha': jangJunha,
      'gyeongSam': gyeongSam,
      'neujBom': neujBom,
      'manWoo': manWoo,
      'soTong': soTong,
      'seongBin': seongBin,
      'sonGam': sonGam,
      'imMaNuel': imMaNuel,
      'hanUl': hanUl,
      'haeOreum': haeOreum,
      'shaLom': shaLom,
      'practiceBuilding': practiceBuilding,
    };
  }
}
