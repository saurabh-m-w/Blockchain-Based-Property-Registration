import 'dart:html';

import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:flutter/material.dart';
import 'package:land_registration/constant/constants.dart';
import 'package:mapbox_search/mapbox_search.dart';

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
  TextEditingController addressController = TextEditingController();
  LatLng initialPos = LatLng(17.4838891, 75.2999884);
  List<MapBoxPlace> predictions = [];
  late PlacesSearch placesSearch;
  final FocusNode _focusNode = FocusNode();
  late OverlayEntry _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
        builder: (context) => Positioned(
              width: 600,
              child: CompositedTransformFollower(
                link: this._layerLink,
                showWhenUnlinked: false,
                offset: const Offset(0.0, 40 + 5.0),
                child: Material(
                  elevation: 4.0,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    children: List.generate(
                        predictions.length,
                        (index) => ListTile(
                              title:
                                  Text(predictions[index].placeName.toString()),
                              onTap: () {
                                addressController.text =
                                    predictions[index].placeName.toString();
                                initialPos = LatLng(
                                    predictions[index]
                                        .geometry!
                                        .coordinates![1],
                                    predictions[index]
                                        .geometry!
                                        .coordinates![0]);

                                mapController.animateCamera(
                                    CameraUpdate.newCameraPosition(
                                        CameraPosition(
                                  zoom: 15.0,
                                  target: initialPos,
                                )));
                                setState(() {});
                                _overlayEntry.remove();
                                _overlayEntry.dispose();
                              },
                            )),
                  ),
                ),
              ),
            ));
  }

  Future<void> autocomplete(value) async {
    List<MapBoxPlace>? res = await placesSearch.getPlaces(value);
    if (res != null) predictions = res;
    setState(() {});
    // print(res);
    // print(res![0].placeName);
    // print(res![0].geometry!.coordinates);
    // print(res![0]);
  }

  @override
  void initState() {
    placesSearch = PlacesSearch(
      apiKey: mapBoxApiKey,
      limit: 10,
    );

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _overlayEntry = this._createOverlayEntry();
        Overlay.of(context)!.insert(_overlayEntry);
      } else {
        _overlayEntry.remove();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF272D34),
        title: const Text('Draw Land on Map'),
        actions: [
          Center(
            child: Container(
              padding: const EdgeInsets.all(5),
              width: 600,
              decoration: BoxDecoration(color: Colors.white10),
              child: CompositedTransformTarget(
                link: this._layerLink,
                child: TextField(
                  controller: addressController,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      autocomplete(value);
                      _overlayEntry.remove();
                      _overlayEntry = this._createOverlayEntry();
                      Overlay.of(context)!.insert(_overlayEntry);
                    } else {
                      if (predictions.isNotEmpty && mounted) {
                        setState(() {
                          predictions = [];
                        });
                      }
                    }
                  },
                  focusNode: this._focusNode,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      prefix: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      isDense: true, // Added this
                      contentPadding: const EdgeInsets.all(12),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                      fillColor: Colors.white,
                      focusColor: Colors.white,
                      hintText: 'Search',
                      hintStyle: const TextStyle(color: Colors.white)),
                ),
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 550,
                width: 900,
                child: MapboxMap(
                    accessToken: mapBoxApiKey,
                    styleString: isSatelliteView
                        ? "mapbox://styles/saurabhmw/cky4ce7f61b2414nuh9ng177k"
                        : "mapbox://styles/saurabhmw/ckyb6byh90rvy15pcc8bej1r7",
                    initialCameraPosition: CameraPosition(
                      zoom: 3.0,
                      target: const LatLng(19.663280, 75.300293),
                    ),
                    onMapCreated: (MapboxMapController controller) {
                      mapController = controller;
                    },
                    compassEnabled: false,
                    onMapClick:
                        (Point<double> point, LatLng coordinates) async {
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
                    icon: const Icon(Icons.add),
                    label:
                        _polygonAdded ? Text('Drawing') : Text('Start Drawing'),
                    onPressed: () {
                      _polygonAdded = true;
                      showToast("Add one by one marker on map",
                          context: context,
                          backgroundColor: Colors.green,
                          duration: const Duration(seconds: 3));
                      setState(() {});
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.clear),
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
                    icon: const Icon(Icons.change_circle),
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
      ),
    );
  }
}
