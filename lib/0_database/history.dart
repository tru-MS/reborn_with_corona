class History{
  late int health;
  late int timeStamp;
  late List<int> locationList;
  late List<bool> checkList;

  History(this.health , this.timeStamp , this.locationList , this.checkList);

  History.fromJson(Map<dynamic , dynamic> json){
    health = json['health'];
    timeStamp = json['timeStamp'];
    List<int> list1 = [];
    if(json['locationList'] == null){
      locationList = [];
    }
    else{
      for(int num in json['locationList']){
        list1.add(num);
      }
      locationList = list1;
    }
    List<bool> list2 = [];
    for(bool flag in json['checkList']){
      list2.add(flag);
    }
    checkList = list2;
  }
}