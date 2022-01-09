import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thundervolt/utils/constants.dart';
import 'package:thundervolt/utils/sizeConfig.dart';
import 'package:thundervolt/views/login/otpScreen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Color buttonColor = Constant.bgColor;
  Color buttonTextColor = Constant.tealColor;

  TextEditingController _phoneController = TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey();

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      bottomSheet: Container(
        padding: EdgeInsets.only(
          left: SizeConfig.screenWidth! * 21 / 428,
          right: SizeConfig.screenWidth! * 21 / 428,
          bottom: SizeConfig.screenHeight! * 54 / 926,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              color: Colors.transparent,
              width: double.infinity,
              child: Form(
                key: _formkey,
                child: TextFormField(
                  controller: _phoneController,
                  onChanged: (val) {
                    if (val.length == 10) {
                      setState(() {
                        if (val.length == 10) {
                          buttonColor = Constant.tealColor;
                          buttonTextColor = Constant.bgColor;
                        } else {
                          buttonColor = Constant.bgColor;
                          buttonTextColor = Constant.tealColor;
                        }
                      });
                    }
                  },
                  validator: (val){
                    if(val!.length!=6){
                      throw "Enter valid OTP";
                    }
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: InputDecoration(
                    labelText: "Phone Number",
                    contentPadding:
                        EdgeInsets.only(top: 20, bottom: 20, right: 10),
                    prefixIcon: Icon(
                      Icons.phone,
                      color: Constant.tealColor,
                      size: 28,
                    ),
                    filled: true,
                    fillColor: Color.fromRGBO(33, 247, 192, 0.14),
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(14)),
                        borderSide: BorderSide(color: Colors.transparent)
                        // borderSide: BorderSide(
                        //   color: Color.fromRGBO(33, 247, 192, 0.14),
                        // ),
                        ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(14.0)),
                        borderSide: BorderSide(color: Constant.tealColor)),
                    labelStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.white.withOpacity(0.44),
                    ),
                  ),
                  style: TextStyle(fontSize: 20, color: Colors.white),
                  cursorColor: Colors.white,
                ),
              ),
            ),
            sh(
              SizeConfig.screenHeight! * 20 / 926,
            ),
            GestureDetector(
              onTap: () {

                 
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (c, a1, a2) => OTPScreenPage(
                      phoneNumber: _phoneController.text,
                    ),
                    transitionsBuilder: (c, anim, a2, child) =>
                        FadeTransition(opacity: anim, child: child),
                    transitionDuration: Duration(milliseconds: 300),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.screenHeight! * 24 / 926,
                ),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: buttonColor,
                    border: Border.all(
                      color: Constant.tealColor,
                    ),
                    borderRadius: BorderRadius.circular(14)),
                child: Text(
                  'Send OTP',
                  style: TextStyle(
                    fontSize: 20,
                    color: buttonTextColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          SingleChildScrollView(
            // physics: NeverScrollableScrollPhysics(),
            child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: SizeConfig.screenHeight! * 150 / 928),
                  child: Image.asset("assets/car.png"),
                )),
          ),
        ],
      ),
    );
  }
}
