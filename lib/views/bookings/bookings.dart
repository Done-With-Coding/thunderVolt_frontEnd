import 'package:flutter/material.dart';
import 'package:thundervolt/utils/constants.dart';
import 'package:thundervolt/utils/sizeConfig.dart';
import 'package:thundervolt/views/bookings/current.dart';
import 'package:thundervolt/views/bookings/nobooking.dart';
import 'package:thundervolt/views/bookings/previous.dart';

class Bookings extends StatefulWidget {
  const Bookings({Key? key}) : super(key: key);

  @override
  _BookingsState createState() => _BookingsState();
}

class _BookingsState extends State<Bookings> {
  List<Widget> _bookingsPage = [
    Current(),
    Previous(),
  ];
  List _bookingNav = ["Current", "Previous"];

  int _selectedIndex = 0;
  int _selectedNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: SizeConfig.screenWidth! * 22 / 428,
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: SizeConfig.screenHeight! * 88 / 926,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Bookings",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Container(
                    height: SizeConfig.screenHeight! * 60 / 926,
                    width: SizeConfig.screenWidth! * 60 / 428,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            sh(24),
            Container(
              padding: EdgeInsets.all(4),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Constant.tealColor,
                ),
              ),
              child: Row(
                children: [
                  for (int i = 0; i < _bookingNav.length; i++)
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIndex = i;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: _selectedIndex == i
                              ? Constant.tealColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.screenHeight! * 8 / 928,
                        ),
                        child: Text(
                          _bookingNav[i],
                          style: TextStyle(
                            fontWeight: _selectedIndex == i
                                ? FontWeight.w700
                                : FontWeight.w400,
                            color: _selectedIndex == i
                                ? Constant.bgColor
                                : Colors.white,
                          ),
                        ),
                      ),
                    ))
                ],
              ),
            ),
            _bookingsPage[_selectedIndex]
          ],
        ),
      ),
    );
  }
}
