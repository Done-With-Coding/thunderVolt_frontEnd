import 'package:flutter/material.dart';
import 'package:thundervolt/utils/constants.dart';
import 'package:thundervolt/utils/sizeConfig.dart';
import 'package:thundervolt/views/bookings/bookings.dart';
import 'package:thundervolt/views/journey/journey.dart';
import 'package:thundervolt/views/tile_layer/maps.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int? selectedIndex =1;
  Color _bottomItemColor = Colors.transparent;

  List<BottomNavItem> _bottomNavItems = [
    BottomNavItem(
      "Journey",
      Icons.car_rental,
    ),
    BottomNavItem(
      "Maps",
      Icons.map,
    ),
    BottomNavItem(
      "Bookings",
      Icons.book_online,
    )
  ];

  List<Widget> _bottomNavPage = [
    Journey(),
    Stack(
      children: [
        Positioned.fill(child: MapPage()),
      ],
    ),
    Bookings(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedIndex = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 21,
            vertical: 37,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Constant.bgColor,
                border: Border.all(
                  color: Colors.white.withOpacity(0.33),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      offset: Offset(0, 16),
                      spreadRadius: -4,
                      blurRadius: 20)
                ]),
            height: 72,
            width: double.infinity,
            child: Row(
              children: [
                for (int i = 0; i < _bottomNavItems.length; i++)
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = i;
                        });
                      },
                      child: Container(
                        // color: Colors.red,
                        padding: EdgeInsets.only(
                          top: 10,
                        ),
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          children: [
                            Icon(
                              _bottomNavItems[i].bottomNavIcon,
                              color: selectedIndex == i
                                  ? Constant.tealColor
                                  : Colors.white.withOpacity(0.42),
                            ),
                            sh(5),
                            Text(
                              _bottomNavItems[i].itemName!,
                              style: TextStyle(
                                color: selectedIndex == i
                                    ? Constant.tealColor
                                    : Colors.white.withOpacity(0.42),
                                fontSize: 12,
                              ),
                            ),
                            Expanded(
                                child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: 3,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: selectedIndex == i
                                        ? Constant.tealColor
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(2)),
                              ),
                            ))
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          )),
      body: _bottomNavPage[selectedIndex!],
    );
  }
}

class BottomNavItem {
  String? itemName;
  IconData? bottomNavIcon;

  BottomNavItem(
    this.itemName,
    this.bottomNavIcon,
  );
}
