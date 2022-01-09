import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:thundervolt/services/mapService.dart';
import 'package:thundervolt/utils/constants.dart';
import 'package:thundervolt/utils/sizeConfig.dart';

class Journey extends StatefulWidget {
  const Journey({Key? key}) : super(key: key);

  @override
  _JourneyState createState() => _JourneyState();
}

class _JourneyState extends State<Journey> {
  Color buttonColor = Constant.bgColor;
  Color buttonTextColor = Constant.tealColor;

  DateTime selectedDate = DateTime.now();
  String? dateTime;
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  GlobalKey<FormState> _formkey = GlobalKey();
  TextEditingController _currentLocController = TextEditingController();
  TextEditingController _destinationController = TextEditingController();
  TextEditingController _rangeController = TextEditingController();
  DateTime? picked;
  TimeOfDay? pickedTime;
  bool? isDateSet;
  bool? isTimeSet;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isDateSet = false;
    isTimeSet = false;
  }

  validate(BuildContext context) async {
    print("validate field");
    if (_currentLocController.text.trim().isNotEmpty &&
        _destinationController.text.trim().isNotEmpty &&
        _rangeController.text.trim().isNotEmpty) {
      final DateTime dateTime = DateTime(picked!.year, picked!.month,
          picked!.day, pickedTime!.hour, pickedTime!.minute);

      await MapService.getRouteData(
          departedAt: dateTime.toString(),
          destination: _destinationController.text.trim(),
          origin: _currentLocController.text.trim(),
          range: _rangeController.text.trim(),
          context: context);
    } else {
      Fluttertoast.showToast(msg: "Fill all the fields");
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      // resizeToAvoidBottomInset: false,

      // bottomSheet: Container(
      //   padding: EdgeInsets.only(
      //     left: SizeConfig.screenWidth! * 21 / 428,
      //     right: SizeConfig.screenWidth! * 21 / 428,
      //     // bottom: SizeConfig.screenHeight! * 20/ 926,
      //   ),
      //   child: Column(
      //     mainAxisSize: MainAxisSize.min,
      //     mainAxisAlignment: MainAxisAlignment.end,
      //     children: [
      //       Container(
      //           color: Colors.transparent,
      //           width: double.infinity,
      //           child: GestureDetector(
      //             onTap: () {},
      //             child: Container(
      //               width: double.infinity,
      //               padding: EdgeInsets.symmetric(
      //                 vertical: SizeConfig.screenHeight! * 24 / 926,
      //               ),
      //               alignment: Alignment.center,
      //               decoration: BoxDecoration(
      //                   color: buttonColor,
      //                   border: Border.all(
      //                     color: Constant.tealColor,
      //                   ),
      //                   borderRadius: BorderRadius.circular(14)),
      //               child: Text(
      //                 'Schedule Journey',
      //                 style: TextStyle(
      //                   fontSize: 16,
      //                   color: buttonTextColor,
      //                   fontWeight: FontWeight.w700,
      //                 ),
      //               ),
      //             ),
      //           ))
      //     ],
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: SizeConfig.screenWidth! * 22 / 428,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: SizeConfig.screenHeight! * 50 / 926,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Journey",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 19,
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.more_vert,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
              sh(40),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Constant.cardGrey,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Constant.tealColor)),
                padding: EdgeInsets.only(
                  left: SizeConfig.screenWidth! * 33 / 428,
                  right: SizeConfig.screenWidth! * 30 / 428,
                  top: SizeConfig.screenHeight! * 30 / 926,
                  bottom: SizeConfig.screenHeight! * 30 / 926,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: SizeConfig.screenHeight! * 11 / 928,
                          width: SizeConfig.screenWidth! * 11 / 428,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff7AD66D),
                          ),
                        ),
                        SizedBox(
                          width: SizeConfig.screenWidth! * 18 / 428,
                        ),
                        Container(
                          width: SizeConfig.screenWidth! * 200 / 428,
                          // color: Colors.red,
                          child: TextField(
                            controller: _currentLocController,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter current location...",
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Color.fromRGBO(196, 196, 196, 0.43),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: SizeConfig.screenHeight! * 30 / 926,
                          width: 2,
                          decoration: BoxDecoration(
                              color: Color(0xffC4C4C4),
                              borderRadius: BorderRadius.circular(1)),
                        ),
                        SizedBox(
                          width: SizeConfig.screenWidth! * 18 / 428,
                        ),
                        Container(
                          height: 2,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(21, 25, 36, 0.27),
                              borderRadius: BorderRadius.circular(1)),
                          width: SizeConfig.screenWidth! * 292 / 482,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: SizeConfig.screenHeight! * 11 / 928,
                          width: SizeConfig.screenWidth! * 11 / 428,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xffFFCB28),
                          ),
                        ),
                        SizedBox(
                          width: SizeConfig.screenWidth! * 18 / 428,
                        ),
                        Container(
                          width: 200,
                          // color: Colors.red,
                          child: TextField(
                            controller: _destinationController,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              border: InputBorder.none,
                              hintText: "Enter your destination...",
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Color.fromRGBO(196, 196, 196, 0.43),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: SizeConfig.screenHeight! * 24 / 928,
                  bottom: SizeConfig.screenHeight! * 12 / 928,
                ),
                child: Text(
                  "Date & Time",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        picked = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2023));

                        setState(() {
                          isDateSet = true;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xff555B69),
                            borderRadius: BorderRadius.circular(14)),
                        padding: EdgeInsets.only(
                          left: SizeConfig.screenWidth! * 25 / 428,
                          right: SizeConfig.screenWidth! * 25 / 428,
                          top: SizeConfig.screenHeight! * 24 / 928,
                          bottom: SizeConfig.screenHeight! * 24 / 928,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              color: Color(0xff858890),
                            ),
                            SizedBox(
                              width: SizeConfig.screenWidth! * 20 / 428,
                            ),
                            Text(
                              picked == null
                                  ? "Date"
                                  : picked.toString().split(" ").first,
                              style: TextStyle(
                                color: Color(0xff858890),
                                fontSize: 14,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.screenWidth! * 20 / 428,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        pickedTime = await showTimePicker(
                          context: context,
                          initialTime: selectedTime,
                        );

                        setState(() {
                          isTimeSet = true;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.screenWidth! * 25 / 428,
                          vertical: SizeConfig.screenHeight! * 24 / 928,
                        ),
                        decoration: BoxDecoration(
                            color: Color(0xff555B69),
                            borderRadius: BorderRadius.circular(14)),
                        child: Row(
                          children: [
                            Icon(
                              Icons.lock_clock,
                              color: Color(0xff858890),
                            ),
                            SizedBox(
                              width: SizeConfig.screenWidth! * 20 / 428,
                            ),
                            Text(
                              pickedTime == null
                                  ? "Time"
                                  : pickedTime!.hour.toString() +
                                      ":" +
                                      pickedTime!.minute
                                          .toString()
                                          .padLeft(2, '0') +
                                      " " +
                                      pickedTime!.period.name,
                              style: TextStyle(
                                color: Color(0xff858890),
                                fontSize: 14,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(
                  top: SizeConfig.screenHeight! * 24 / 928,
                  bottom: SizeConfig.screenHeight! * 12 / 928,
                ),
                child: Text(
                  "Range(KM)",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
              TextFormField(
                // controller: _,
                onChanged: (val) {},
                controller: _rangeController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  // LengthLimitingTextInputFormatter(10),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.only(top: 20, bottom: 20, right: 10, left: 30),
                  filled: true,
                  fillColor: Color(0xff555B69),
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
                ),
                style: TextStyle(fontSize: 20, color: Colors.white),
                cursorColor: Colors.white,
              ),
              sh(110),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () async {
                      await validate(context);
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
                        'Schedule Journey',
                        style: TextStyle(
                          fontSize: 16,
                          color: buttonTextColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
