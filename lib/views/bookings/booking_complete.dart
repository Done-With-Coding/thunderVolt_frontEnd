import 'package:flutter/material.dart';

class BookingDone extends StatelessWidget {
  const BookingDone({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset('assets/booking_done.png'),),
    );
  }
}