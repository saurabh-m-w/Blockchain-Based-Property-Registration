import 'dart:html';

import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:flutter/material.dart';

class landOnMap extends StatefulWidget {
  const landOnMap({Key? key}) : super(key: key);

  @override
  _landOnMapState createState() => _landOnMapState();
}

class _landOnMapState extends State<landOnMap> {
  late MapboxMapController mapController;
  List<LatLng> polygon = [];
  late Fill landPolygonFill;
  bool _polygonAdded = false;
  bool isSatelliteView = true;
  String allLatitude = "", allLongitude = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF272D34),
        title: Text('Draw Land on Map'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 600,
              width: 900,
              child: MapboxMap(
                  accessToken:
                      "pk.eyJ1Ijoic2F1cmFiaG13IiwiYSI6ImNreTRiYzNidjBhMTkydnB2dmpoeGt4ZmgifQ.2QZ4CsNiygDTAhkqASpbPg",
                  styleString:
                      "mapbox://styles/saurabhmw/cky4ce7f61b2414nuh9ng177k",
                  initialCameraPosition: CameraPosition(
                    zoom: 15.0,
                    target: LatLng(17.4838891, 75.2999884),
                  ),
                  onMapCreated: (MapboxMapController controller) {
                    mapController = controller;
                  },
                  compassEnabled: false,
                  onMapClick: (Point<double> point, LatLng coordinates) async {
                    if (_polygonAdded) {
                      polygon.add(coordinates);
                      allLatitude += coordinates.latitude.toString() + ",";
                      allLongitude += coordinates.longitude.toString() + ",";

                      mapController.addCircle(CircleOptions(
                          geometry: coordinates,
                          circleRadius: 5,
                          circleColor: "#ff0000",
                          draggable: true));

                      if (polygon.length == 3) {
                        landPolygonFill = await mapController.addFill(
                          FillOptions(
                            fillColor: "#2596be",
                            fillOutlineColor: "#2596be",
                            geometry: [polygon],
                          ),
                        );
                      }
                      if (polygon.length > 3) {
                        mapController.updateFill(
                            landPolygonFill,
                            FillOptions(
                              fillColor: "#2596be",
                              fillOutlineColor: "#2596be",
                              geometry: [polygon],
                            ));

                        //print(landPolygonFill.options.geometry.toString());
                      }
                    }
                  }),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.add),
                  label:
                      _polygonAdded ? Text('Drawing') : Text('Start Drawing'),
                  onPressed: () {
                    _polygonAdded = true;
                    showToast("Add one by one marker on map",
                        context: context,
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 3));
                    setState(() {});
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.clear),
                  label: Text('CLEAR All'),
                  onPressed: () {
                    mapController.clearCircles();
                    mapController.clearFills();
                    polygon = [];
                    allLatitude = "";
                    allLongitude = "";
                    setState(() => _polygonAdded = false);
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.save),
                  label: Text('Save'),
                  onPressed: () {
                    allLatitude = allLatitude.trim();
                    allLatitude =
                        allLatitude.substring(0, allLatitude.length - 1);
                    allLongitude = allLongitude.trim();
                    allLongitude =
                        allLongitude.substring(0, allLongitude.length - 1);
                    allLatitude = allLatitude + "|" + allLongitude;
                    Navigator.pop(context, allLatitude);
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.change_circle),
                  label: !isSatelliteView
                      ? Text('Satellite View')
                      : Text('Road Map View'),
                  onPressed: () {
                    isSatelliteView = !isSatelliteView;
                    setState(() {});
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
