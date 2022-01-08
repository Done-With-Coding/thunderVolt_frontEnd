import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:thundervolt/utils/constants.dart';
import 'package:thundervolt/utils/sizeConfig.dart';
import 'package:thundervolt/views/login/loginPage.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: SizeConfig.screenHeight! * 100 / 926,
              ),
              child: Image.asset(
                "assets/car.png",
                // fit: BoxFit.contain,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: SizeConfig.screenHeight! * 138 / 926),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth! * 24 / 428),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "EV Charging Solution",
                        style: TextStyle(
                          color: Constant.tealColor,
                          fontSize: SizeConfig.screenWidth! * 23 / 428,
                        ),
                      ),
                      Image.asset(
                        "assets/thunder.png",
                        height: SizeConfig.screenHeight! * 20 / 928,
                        width: SizeConfig.screenWidth! * 20 / 428,
                      )
                    ],
                  ),
                  sh(
                    SizeConfig.screenHeight! * 10 / 926,
                  ),
                  RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                          text: "Get Started",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: SizeConfig.screenWidth! * 57 / 428,
                          ),
                          children: [
                            TextSpan(
                                text: ".",
                                style: TextStyle(
                                  color: Constant.tealColor,
                                ))
                          ])),
                  sh(
                    SizeConfig.screenHeight! * 45 / 926,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                        boxShadow: [
                          BoxShadow(
                              color: Constant.tealColor.withOpacity(0.4),
                              spreadRadius: 5,
                              blurRadius: 15)
                        ]),
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (c, a1, a2) => LoginPage(),
                            transitionsBuilder: (c, anim, a2, child) =>
                                FadeTransition(opacity: anim, child: child),
                            transitionDuration: Duration(milliseconds: 300),
                          ),
                        );
                      },
                      backgroundColor: Constant.tealColor,
                      elevation: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(
                            Radius.circular(100),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Constant.tealColor.withOpacity(0.3),
                              spreadRadius: 10,
                              blurRadius: 7,
                              // offset: Offset(3, 5),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.arrow_forward,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
