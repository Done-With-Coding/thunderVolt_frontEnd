import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:thundervolt/services/prefService.dart';
import 'package:thundervolt/utils/constants.dart';
import 'package:thundervolt/views/login/start.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Prefs.isRemember().then((value) => runApp(MyApp(remember: value)));
}

class MyApp extends StatelessWidget {
  final bool? remember;
  const MyApp({Key? key, this.remember}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    print("Remember value in material app $remember");
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.transparent,
        ),
        scaffoldBackgroundColor: Constant.bgColor,
        fontFamily: "CenturyGothic",
      ),
      home: remember! ? BottomNav() : StartPage(),
    );
  }
}
