import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:thundervolt/models/GlobalVar.dart';
import 'package:thundervolt/models/models.dart';
import 'package:thundervolt/utils/constants.dart';
import 'package:thundervolt/utils/sizeConfig.dart';

class PolyLineMap extends StatefulWidget {
  final List<MapLatLng> points;
  final List<LocationModel> polyLocation;
  PolyLineMap({Key? key, required this.points, required this.polyLocation})
      : super(key: key);

  @override
  _PolyLineMapState createState() => _PolyLineMapState();
}

class _PolyLineMapState extends State<PolyLineMap> {
  MapShapeSource? _dataSource;
  MapTileLayerController? _controller;
  late MapZoomPanBehavior _zoomPanBehavior;
  PageController? _pageController;
  List<LocationModel> _data = [];
  MapLatLng? currentLoc = MapLatLng(21, 72);
  int? _currentSelectedIndex;
  bool? _canupdateFocalLatLang;
  bool? _canupdateZoomLevel;
  double? _cardHeight;
  int? _previousSelectedIndex;
  double? _bottomsheetHeight;
  double? _slotOpacity;
  int? _tappedMarkedIndex;

  List _slotTime = [];

  late List<List<MapLatLng>> polylines;

  @override
  void initState() {
    _canupdateFocalLatLang = true;
    _canupdateZoomLevel = true;
    _controller = MapTileLayerController();

    polylines = <List<MapLatLng>>[widget.points];

    for (int i = 1; i <= 24; i++) {
      _slotTime.add(i);
    }

    setInitialLoc();

    _currentSelectedIndex = 0;
    _slotOpacity = 0;

    _zoomPanBehavior = MapZoomPanBehavior(
        focalLatLng: currentLoc,
        minZoomLevel: 9,
        maxZoomLevel: 15,
        enableDoubleTapZooming: true,
        showToolbar: true,
        toolbarSettings: MapToolbarSettings(
          position: MapToolbarPosition.bottomRight,
          iconColor: Constant.tealColor,
          itemBackgroundColor: Constant.bgColor,
          itemHoverColor: Colors.blue,
        ));

    _bottomsheetHeight = SizeConfig.screenHeight! * 365 / 926;
    _data = List.from(widget.polyLocation);

    super.initState();
  }

  setInitialLoc() async {
    await Geolocator.requestPermission();
    final pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);

    // final polyLineProvider = Provider.of<MapProvider>(context, listen: false);

    // await polyLineProvider.getMapLocationList(
    //     lat: pos.latitude, long: pos.longitude);
    // LocationModel myLoc =

    currentLoc = MapLatLng(pos.latitude, pos.longitude);
    GlobalCurrentLoc.currentLocLat = pos.latitude;
    GlobalCurrentLoc.currentLocLong = pos.longitude;
    print(
        "Latitude: ${currentLoc!.latitude} and longitude: ${currentLoc!.longitude} ");
    await Future.delayed(Duration(seconds: 1));
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _pageController!.dispose();
    _controller!.dispose();
    _data.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    _cardHeight = SizeConfig.screenHeight! * 150 / 926;
    _pageController = PageController(
        initialPage: _currentSelectedIndex!, viewportFraction: 0.8);
    if (_canupdateZoomLevel!) {
      _zoomPanBehavior.zoomLevel = 9;
      _canupdateZoomLevel = false;
    }

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: SfMaps(layers: [
              MapTileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                // initialFocalLatLng: mapLatLng!,
                initialZoomLevel: 9,
                // initialFocalLatLng: MapLatLng(27.1751, 50.0421),
                zoomPanBehavior: _zoomPanBehavior,
                sublayers: [
                  MapPolylineLayer(
                      polylines:
                          List<MapPolyline>.generate(polylines.length, (int i) {
                    return MapPolyline(
                      points: polylines[i],
                    );
                  }).toSet()
                      //         polylines.length, (int i) {
                      //   return MapPolyline(points: polylines[i]);
                      // })),
                      )
                ],

                initialMarkersCount: _data.length,
                markerBuilder: (BuildContext context, int index) {
                  final double markerSize =
                      _currentSelectedIndex == index ? 40 : 35;
                  return MapMarker(
                    latitude: _data[index].latitude!,
                    longitude: _data[index].longitude!,
                    alignment: Alignment.bottomCenter,
                    // child: Icon(
                    //   Icons.location_on,
                    //   size: 28,
                    //   color: Constant.tealColor,
                    // ),
                    child: GestureDetector(
                      onTap: () {
                        if (_currentSelectedIndex != index) {
                          _canupdateFocalLatLang = false;
                          _tappedMarkedIndex = index;

                          _pageController!.animateToPage(index,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeInOut);
                        }
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        height: markerSize,
                        width: markerSize,
                        child: FittedBox(
                          child: Icon(
                            Icons.location_on,
                            color: _currentSelectedIndex == index
                                ? Colors.red
                                : Constant.tealColor,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                controller: _controller,
              ),
            ]),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: _cardHeight,
              padding: EdgeInsets.only(bottom: 20),
              child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: _handlepageChange,
                  itemCount: _data.length,
                  itemBuilder: (context, index) {
                    return Transform.scale(
                      scale: index == _currentSelectedIndex ? 0.9 : 0.7,
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) {
                                    return StatefulBuilder(builder:
                                        (context, StateSetter setState) {
                                      return Container(
                                        height: _bottomsheetHeight,
                                        padding: EdgeInsets.all(20),
                                        color: Constant.lightGrey,
                                        child: Column(
                                          children: [
                                            Container(
                                              width: SizeConfig.screenWidth! *
                                                  64 /
                                                  428,
                                              height: 3,
                                              decoration: BoxDecoration(
                                                  color: Constant.tealColor,
                                                  borderRadius:
                                                      BorderRadius.circular(2)),
                                            ),
                                            sh(10),
                                            Row(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  child: Container(
                                                    height: 90,
                                                    width: 90,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width:
                                                      SizeConfig.screenWidth! *
                                                          22 /
                                                          428,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      _data[_currentSelectedIndex!]
                                                          .name!,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                    Text(
                                                      List<String>.generate(3,
                                                          (i) {
                                                        return _data[index]
                                                            .address!
                                                            .split(" ")[i];
                                                      }).join(" "),
                                                      style: TextStyle(
                                                        color: Colors.white70,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        FittedBox(
                                                          child: Icon(
                                                            Icons.location_on,
                                                            color: Constant
                                                                .tealColor,
                                                            size: 20,
                                                          ),
                                                        ),
                                                        Text(
                                                          "${_data[index].distance!.toInt() / 1000} KM",
                                                          style: TextStyle(
                                                            color: Constant
                                                                .tealColor,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                            sh(21),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                vertical:
                                                    SizeConfig.screenHeight! *
                                                        20 /
                                                        926,
                                                horizontal:
                                                    SizeConfig.screenHeight! *
                                                        20 /
                                                        926,
                                              ),
                                              decoration: BoxDecoration(
                                                  color: Constant.lightbgColor,
                                                  borderRadius:
                                                      BorderRadius.circular(14),
                                                  border: Border.all(
                                                      color: Color(0xfC4C4C4)
                                                          .withOpacity(0.33))),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      child: Container(
                                                    alignment: Alignment.center,
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          "Type 3",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                        Text(
                                                          "Connection",
                                                          style: TextStyle(
                                                            color: Constant
                                                                .tealColor,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )),
                                                  Container(
                                                    height: SizeConfig
                                                            .screenHeight! *
                                                        48 /
                                                        926,
                                                    width: 2,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xffC4C4C4),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              2),
                                                    ),
                                                  ),
                                                  Expanded(
                                                      child: Container(
                                                    alignment: Alignment.center,
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          "300",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                        Text(
                                                          "Per kwh",
                                                          style: TextStyle(
                                                            color: Constant
                                                                .tealColor,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ))
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                                child: Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  _slotOpacity == 0
                                                      ? GestureDetector(
                                                          onTap: () async {
                                                            // await mapProvider.navigateToGoogleMaps(
                                                            //     sourceLat:
                                                            //         GlobalCurrentLoc
                                                            //             .currentLocLat!,
                                                            //     sourcelong:
                                                            //         GlobalCurrentLoc
                                                            //             .currentLocLong!,
                                                            //     destlat: _data[
                                                            //             _currentSelectedIndex!]
                                                            //         .latitude!,
                                                            //     destlong: _data[
                                                            //             _currentSelectedIndex!]
                                                            //         .longitude!);
                                                          },
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                              horizontal: SizeConfig
                                                                      .screenWidth! *
                                                                  40 /
                                                                  428,
                                                            ),
                                                            height: SizeConfig
                                                                    .screenHeight! *
                                                                72 /
                                                                926,
                                                            decoration:
                                                                BoxDecoration(
                                                              border:
                                                                  Border.all(
                                                                color: Constant
                                                                    .tealColor,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          14),
                                                            ),
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                              "Navigate",
                                                              style: TextStyle(
                                                                color: Constant
                                                                    .tealColor,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      : Opacity(opacity: 0),
                                                  _slotOpacity == 0
                                                      ? GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              _bottomsheetHeight =
                                                                  SizeConfig
                                                                          .screenHeight! *
                                                                      750 /
                                                                      926;
                                                              _slotOpacity = 1;
                                                            });
                                                          },
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                              horizontal: SizeConfig
                                                                      .screenWidth! *
                                                                  65 /
                                                                  428,
                                                            ),
                                                            height: SizeConfig
                                                                    .screenHeight! *
                                                                72 /
                                                                926,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Constant
                                                                  .tealColor,
                                                              border:
                                                                  Border.all(
                                                                color: Constant
                                                                    .tealColor,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          14),
                                                            ),
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                              "Book",
                                                              style: TextStyle(
                                                                color: Constant
                                                                    .bgColor,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      : Opacity(opacity: 0)
                                                ],
                                              ),
                                            )),
                                            _slotOpacity == 1
                                                ? Container(
                                                    height: 300,
                                                    child: GridView.builder(
                                                      physics:
                                                          BouncingScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemCount:
                                                          _slotTime.length,

                                                      // controller: ,
                                                      gridDelegate:
                                                          SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 3,
                                                        childAspectRatio:
                                                            1.5 / 0.7,
                                                        crossAxisSpacing: 25,
                                                        mainAxisSpacing: 25,
                                                      ),
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            horizontal: SizeConfig
                                                                    .screenWidth! *
                                                                36 /
                                                                428,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  color: Constant
                                                                      .lightbgColor,
                                                                  border: Border
                                                                      .all(
                                                                    color: Constant
                                                                        .tealColor,
                                                                  )),
                                                          height: SizeConfig
                                                                  .screenHeight! *
                                                              40 /
                                                              926,
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                              _slotTime[index]
                                                                  .toString()),
                                                        );
                                                      },
                                                    ),
                                                  )
                                                : Opacity(opacity: 0),
                                            _slotOpacity == 1
                                                ? Expanded(
                                                    child: Align(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: Container(
                                                        height: SizeConfig
                                                                .screenHeight! *
                                                            72 /
                                                            926,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                          vertical: SizeConfig
                                                                  .screenHeight! *
                                                              25 /
                                                              926,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Constant
                                                              .tealColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(14),
                                                        ),
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          "Book",
                                                          style: TextStyle(
                                                            color: Constant
                                                                .bgColor,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : Opacity(opacity: 0)
                                          ],
                                        ),
                                      );
                                    });
                                  }).whenComplete(() {
                                setState(() {
                                  _bottomsheetHeight =
                                      SizeConfig.screenHeight! * 365 / 926;
                                  _slotOpacity = 0;
                                });
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Color(0xff555B69),
                                // border: Border.all(
                                //   color: index == _currentSelectedIndex
                                //       ? Constant.tealColor
                                //       : Color(0xff555B69),
                                // ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Container(
                                      height:
                                          SizeConfig.screenHeight! * 90 / 926,
                                      width:
                                          SizeConfig.screenHeight! * 90 / 926,
                                      color: Colors.red,
                                    ),
                                  ),
                                  SizedBox(
                                    width: SizeConfig.screenWidth! * 18 / 428,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(top: 5, right: 5),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            _data[index].name.toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 17),
                                          ),
                                          Text(
                                            List<String>.generate(
                                                min(
                                                    _data[index]
                                                        .address!
                                                        .split(" ")
                                                        .length,
                                                    3), (i) {
                                              return _data[index]
                                                  .address!
                                                  .split(" ")[i];
                                            }).join(" "),
                                            style: TextStyle(
                                              color: Color(0xffD4D4D4)
                                                  .withOpacity(0.33),
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }

  void _handlepageChange(int index) {
    if (!_canupdateFocalLatLang!) {
      if (_tappedMarkedIndex == index) {
        _updateSelectedCard(index);
      }
    } else if (_canupdateFocalLatLang!) {
      _updateSelectedCard(index);
    }
  }

  void _updateSelectedCard(int index) {
    setState(() {
      _previousSelectedIndex = _currentSelectedIndex;
      _currentSelectedIndex = index;
    });

    /// While updating the page viewer through interaction, selected position's
    /// marker should be moved to the center of the maps. However, when the
    /// marker is directly clicked, only the respective card should be moved to
    /// center and the marker itself should not move to the center of the maps.
    if (_canupdateFocalLatLang!) {
      _zoomPanBehavior.focalLatLng = MapLatLng(
          _data[_currentSelectedIndex!].latitude!,
          _data[_currentSelectedIndex!].longitude!);
    }

    /// Updating the design of the selected marker. Please check the
    /// `markerBuilder` section in the build method to know how this is done.
    _controller!
        .updateMarkers(<int>[_currentSelectedIndex!, _previousSelectedIndex!]);
    _canupdateFocalLatLang = true;
  }
}
