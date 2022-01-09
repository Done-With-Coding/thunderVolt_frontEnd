import 'package:flutter/material.dart';
import 'package:thundervolt/models/models.dart';
import 'package:thundervolt/utils/constants.dart';
import 'package:thundervolt/utils/sizeConfig.dart';
import 'package:thundervolt/views/bookings/nobooking.dart';

class Current extends StatefulWidget {
  final List<BookingModel> ? currentBookingList;
  const Current({Key? key, this.currentBookingList}) : super(key: key);

  @override
  _CurrentState createState() => _CurrentState();
}

class _CurrentState extends State<Current> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(
          top: SizeConfig.screenHeight! * 10 / 926,
        ),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.currentBookingList!.length,
            physics: BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, index) {
              return Container(
                margin: EdgeInsets.only(bottom: 20),
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 15,
                ),
                decoration: BoxDecoration(
                    color: Constant.lightGrey,
                    borderRadius: BorderRadius.circular(12)),
                child: Stack(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            height: 90,
                            width: 90,
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(
                          width: SizeConfig.screenWidth! * 8 / 428,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              sh(15),
                              Text(
                                widget.currentBookingList![index].name!,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                widget.currentBookingList![index].address!,
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Text(
                                "25 december | 6:00 PM",
                                style: TextStyle(
                                  color: Constant.tealColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Transform.scale(
                              scale: 0.8,
                              child: Chip(
                                  // labelPadding: EdgeInsets.all(20.0),
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  backgroundColor: Constant.tealColor,
                                  label: Text(
                                    "Navigate",
                                    style: TextStyle(
                                      color: Constant.bgColor,
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
