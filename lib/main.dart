//*********************************************************************//
//
//
//
//
//*********************************************************************//
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '1_login_see/a_login_page.dart';
import '1_login_see/b_sign_page.dart';
import '2_main_see/a_main_page.dart';
import '2_main_see/c_statics_page.dart';
import '3_setting_see/a_privacy_page.dart';
import '3_setting_see/b_manual_page.dart';
import '3_setting_see/c_made_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'With Corona',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
         '/': (context) => const LoginPage(),
          '/sign': (context) => const SignPage(),
          '/main': (context) => const MainPage(),
          '/statistics': (context) => const StatisticsPage(),
        '/privacy': (context) => const PrivacyPage(),
        '/manual': (context) => const ManualPage(),
        '/made': (context) => const MadePage(),
        //  '/location': (context) => LocationPage(),
      },
    );
  }
}
