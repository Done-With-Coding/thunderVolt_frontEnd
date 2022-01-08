import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:thundervolt/services/authentication.dart';
import 'package:thundervolt/utils/constants.dart';
import 'package:thundervolt/utils/sizeConfig.dart';
import 'package:thundervolt/views/bottomnav.dart';


class OTPScreenPage extends StatefulWidget {
  final String? phoneNumber;
  const OTPScreenPage({Key? key, this.phoneNumber}) : super(key: key);

  @override
  _OTPScreenPageState createState() => _OTPScreenPageState();
}

class _OTPScreenPageState extends State<OTPScreenPage> {
  GlobalKey<FormState> _otpKey = GlobalKey();
  Color buttonColor = Constant.bgColor;
  Color buttonTextColor = Constant.tealColor;

  bool loading = false;
  TextEditingController smsOTP = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    OTPLoginVM.instance.verifyPhone(
        forceResend: 0, phoneNumber: widget.phoneNumber!, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      bottomSheet: Container(
        margin: EdgeInsets.only(
          left: SizeConfig.screenWidth! * 20 / 428,
          right: SizeConfig.screenWidth! * 20 / 428,
          bottom: SizeConfig.screenHeight! * 54 / 926,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            PinCodeTextField(
              key: _otpKey,
              appContext: context,
              textStyle: TextStyle(
                color: Colors.white,
              ),
              pastedTextStyle: TextStyle(
                color: Colors.green.shade600,
                fontWeight: FontWeight.bold,
              ),
              length: 6,
              controller: smsOTP,
              animationType: AnimationType.fade,
              // validator: (v) {
              //   if (v!.length < 3) {
              //     return "I'm from validator";
              //   } else {
              //     return null;
              //   }
              // },
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],

              pinTheme: PinTheme(
                activeColor: Constant.tealColor,
                disabledColor: Constant.lightbgColor,
                selectedFillColor: Constant.lightbgColor,
                inactiveFillColor: Constant.lightbgColor,
                inactiveColor: Colors.transparent,
                selectedColor: Constant.tealColor,
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 50,
                fieldWidth: 40,
                activeFillColor: Constant.lightbgColor,
              ),

              cursorColor: Colors.white,
              animationDuration: Duration(milliseconds: 300),
              enableActiveFill: true,
              // errorAnimationController: errorController,
              // controller: textEditingController,
              keyboardType: TextInputType.number,
              boxShadows: [
                BoxShadow(
                  offset: Offset(0, 1),
                  color: Colors.black12,
                  blurRadius: 10,
                )
              ],
              onCompleted: (v) {
                print("Completed");
              },
              // onTap: () {
              //   print("Pressed");
              // },
              onChanged: (value) {
                print(value);

                setState(() {
                  if (value.length == 6) {
                    buttonColor = Constant.tealColor;
                    buttonTextColor = Constant.bgColor;
                  } else {
                    buttonColor = Constant.bgColor;
                    buttonTextColor = Constant.tealColor;
                  }
                });
              },
              beforeTextPaste: (text) {
                print("Allowing to paste $text");
                //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                //but you can show anything you want here, like your pop up saying wrong paste format or etc
                return true;
              },
            ),
            sh(
              SizeConfig.screenHeight! * 20 / 926,
            ),
            GestureDetector(
              onTap: () async {
                setState(() {
                  loading = true;
                });
                if (smsOTP.text.length == 6) {
                  await OTPLoginVM.instance.signInWithOTP(smsOTP.text, context);
                } else
                  Fluttertoast.showToast(
                      msg: "Enter Valid OTP",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black87,
                      textColor: Colors.white,
                      fontSize: 16.0);
                setState(() {
                  loading = false;
                });
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
                  'Get Started',
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
            physics: NeverScrollableScrollPhysics(),
            child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: SizeConfig.screenHeight! * 150 / 926,
                  ),
                  child: Image.asset("assets/car.png"),
                )),
          ),
        
        ],
      ),
    );
  }
}
