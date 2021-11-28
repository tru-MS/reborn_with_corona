//*********************************************************************//
//
//
//
//
//*********************************************************************//

import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:reborn_with_corona/0_database/a_user_list.dart';
import 'package:reborn_with_corona/2_main_see/a_main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoginPage();
  }
}

class _LoginPage extends State<LoginPage> with SingleTickerProviderStateMixin {
  FirebaseDatabase? _database;
  DatabaseReference? reference;
  final String _databaseURL = 'https://reborn-with-corona-default-rtdb.firebaseio.com/';

  double opacity = 0;
  AnimationController? _animationController;
  TextEditingController? _idTextController;
  TextEditingController? _pwTextController;

  @override
  void initState() {
    super.initState();

    _idTextController = TextEditingController();
    _pwTextController = TextEditingController();

    _animationController = AnimationController(duration: const Duration(seconds: 3), vsync: this);
    _animationController!.repeat();
    Timer(const Duration(seconds: 2), () {
      setState(() {
        opacity = 1;
      });
    });

    _database = FirebaseDatabase(databaseURL: _databaseURL);
    reference = _database!.reference().child('user');
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'imgs/logo.png',
                    width: 300,
                    height: 150,
                    fit: BoxFit.fill,
                  ),
                ],
              )),
              AnimatedOpacity(
                opacity: opacity,
                duration: const Duration(seconds: 1), // 1초 늦게 로그인창 뜨게 함
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: 200,
                      child: TextField(
                        controller: _idTextController,
                        maxLines: 1,
                        decoration: const InputDecoration(labelText: '학번', border: OutlineInputBorder()),
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
                        decoration: const InputDecoration(labelText: '비밀번호', border: OutlineInputBorder()),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('/sign');
                            },
                            child: const Text('회원가입')),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('/main');
                            },
                            child: const Text('넘김')),
                        TextButton(
                            onPressed: () {
                              if (_idTextController!.value.text.isEmpty || _pwTextController!.value.text.isEmpty) {
                                makeDialog('빈칸이 있습니다');
                              } else {
                                reference!.child(_idTextController!.value.text).onValue.listen((event) {
                                  if (event.snapshot.value == null) {
                                    makeDialog('학번이 없습니다');
                                  } else {
                                    reference!.child(_idTextController!.value.text).onChildAdded.listen((event) {

                                      User user = User.fromSnapshot(event.snapshot);
                                      var bytes = utf8.encode(_pwTextController!.value.text);
                                      var digest = sha1.convert(bytes);
                                      if (user.pw == digest.toString()) {
                                        final DataController dataController = Get.put(DataController(user.id));
                                        Navigator.of(context).pushReplacementNamed('/main', arguments: _idTextController!.value.text);
                                      } else {
                                        makeDialog('비밀번호가 틀립니다');
                                      }
                                    });
                                  }
                                });
                              }
                            },
                            child: const Text('로그인'))
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    )
                  ],
                ),
              )
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
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            content: Text(text),
          );
        });
  }
}
