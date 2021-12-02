//*********************************************************************//
//
//
//
//
//*********************************************************************//

import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reborn_with_corona/0_database/a_user_list.dart';

class SignPage extends StatefulWidget {
  const SignPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SignPage();
  }
}

class TextController extends GetxController{
  var idText = "".obs;
  var pwText = "".obs;
  var pwCheckText = "".obs;
}

class _SignPage extends State<SignPage> {
  FirebaseDatabase? _database;
  DatabaseReference? reference;
  final String _databaseURL = 'https://reborn-with-corona-default-rtdb.firebaseio.com/';

  TextEditingController? _idTextController;
  TextEditingController? _pwTextController;
  TextEditingController? _pwCheckTextController;

  @override
  void initState() {
    super.initState();
    _idTextController = TextEditingController();
    _pwTextController = TextEditingController();
    _pwCheckTextController = TextEditingController();

    _database = FirebaseDatabase(databaseURL: _databaseURL);
    reference = _database?.reference().child('user');
  }

  @override
  Widget build(BuildContext context) {
    final TextController textController = Get.put(TextController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('회원 가입'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                width: 200,
                child: TextField(
                  controller: _idTextController,
                  maxLines: 1,
                  decoration: const InputDecoration(hintText: '학번을 입력해 주세요', labelText: '학번', border: OutlineInputBorder()),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 200,
                child: TextField(
                  controller: _pwTextController,
                  obscureText: true,
                  maxLines: 1,
                  decoration: const InputDecoration(hintText: '6자 이상 입력해주세요', labelText: '비밀번호', border: OutlineInputBorder()),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 200,
                child: TextField(
                  controller: _pwCheckTextController,
                  obscureText: true,
                  maxLines: 1,
                  decoration: const InputDecoration(labelText: '비밀번호확인', border: OutlineInputBorder()),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              FlatButton(
                onPressed: () async {
                  textController.idText.value = _idTextController!.value.text;
                  textController.pwText.value = _pwTextController!.value.text;
                  textController.pwCheckText.value = _pwCheckTextController!.value.text;

                  final userReference = _database!.reference().child("user");
                  final userListReference = _database!.reference().child("userList");
                  final userListSnapshot = await userListReference.get();

                  if(textController.idText.value == ""){
                    makeDialog("학번을 입력해 주세요.");
                  }
                  else{
                    userReference.child(textController.idText.value).once().then(
                            (data){
                          if(data.value == null){
                            if (textController.idText.value.length >= 4 && textController.pwText.value.length >= 6) {
                              if (textController.pwText.value == textController.pwCheckText.value) {
                                var bytes = utf8.encode(textController.pwText.value);
                                var digest = sha1.convert(bytes);
                                // var degreeOfRisk = 0;

                                /// 회원가입 시 DB 에 userList 정보를 업데이트

                                List<String> userList = [];
                                for(dynamic d in userListSnapshot.value['userList']){
                                  if(d!=null){
                                    userList.add(d);
                                  }
                                }
                                userList.add(textController.idText.value);
                                userListReference.update({
                                  'userList':userList
                                });
                                //////////////////////////////////////

                                reference!
                                    .child(textController.idText.value)
                                    .push()
                                    .set(User(textController.idText.value, digest.toString(), DateTime.now().toIso8601String()).toJson())
                                    .then((_) {

                                  Navigator.of(context).pop();
                                  makeDialog('회원가입이 완료되었습니다');
                                });
                              }
                              else {
                                makeDialog('비밀번호가 틀립니다');
                              }
                            }
                            else {
                              makeDialog('길이가 짧습니다');
                            }
                          }
                          else{
                            makeDialog("이미 가입된 학번 입니다.");
                          }
                        });
                  }
                },
                child: const Text(
                  '회원 가입',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blueAccent,
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
    );
  }

  void makeDialog(String text) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(text),
          );
        });
  }
}
