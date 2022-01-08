import 'package:flutter/material.dart';
import 'package:thundervolt/utils/constants.dart';
import 'package:thundervolt/utils/sizeConfig.dart';

class NoBooking extends StatelessWidget {
 final  String ? title;

  const NoBooking({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: SizeConfig.screenHeight! * 101 / 926,
          ),
          child: Image.asset("assets/no-booking.png"),
        ),
        sh(27),
        Text(
          title!,
          style: TextStyle(color: Colors.white, fontSize: 20),
        )
      ],
    );
  }
}
