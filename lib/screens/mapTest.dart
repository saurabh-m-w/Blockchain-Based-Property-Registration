import 'package:flutter/material.dart';
// import 'package:flutter_google_places/flutter_google_places.dart';
// import 'package:google_maps_webservice/places.dart';
import 'package:google_place/google_place.dart';

class MapSample extends StatefulWidget {
  @override
  _MapSampleState createState() => _MapSampleState();
}

class _MapSampleState extends State<MapSample> {
  String kGoogleApiKey = "AIzaSyCYd-Oht4NM3YXbWYwzOdvKIh0kvpGxdTE";
  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];
  // Future<void> _handlePressButton() async {
  //   // show input autocomplete with selected mode
  //   // then get the Prediction selected
  //   Prediction? p = await PlacesAutocomplete.show(
  //     context: context,
  //     apiKey: kGoogleApiKey,
  //     onError: onError,
  //     mode: Mode.overlay,
  //     proxyBaseUrl:
  //         "https://maps.googleapis.com/maps/api/place/autocomplete/json",
  //     language: "us",
  //     // decoration: InputDecoration(
  //     //   hintText: 'Search',
  //     //   focusedBorder: OutlineInputBorder(
  //     //     borderRadius: BorderRadius.circular(20),
  //     //     borderSide: BorderSide(
  //     //       color: Colors.white,
  //     //     ),
  //     //   ),
  //     // ),
  //     // components: [Component(Component.country, "us")],
  //   );
  //   await displayPrediction(p!);
  // }
  //
  // fun() async {
  //   Prediction? p =
  //       await PlacesAutocomplete.show(context: context, apiKey: kGoogleApiKey);
  //   displayPrediction2(p!);
  // }
  //
  // Future<Null> displayPrediction2(Prediction p) async {
  //   if (p != null) {
  //     GoogleMapsPlaces _places = GoogleMapsPlaces(
  //       apiKey: kGoogleApiKey,
  //       // apiHeaders: await GoogleApiHeaders().getHeaders(),
  //     );
  //     PlacesDetailsResponse detail =
  //         await _places.getDetailsByPlaceId(p.placeId!);
  //
  //     var placeId = p.placeId;
  //     double lat = detail.result.geometry!.location.lat;
  //     double lng = detail.result.geometry!.location.lng;
  //
  //     //var address = await Geocoder.local.findAddressesFromQuery(p.description);
  //
  //     print(lat);
  //     print(lng);
  //   }
  // }
  //
  // void onError(PlacesAutocompleteResponse response) {
  //   print(response.errorMessage.toString());
  // }
  //
  // Future<Null> displayPrediction(Prediction? p) async {
  //   if (p != null) {
  //     // get detail (lat/lng)
  //     GoogleMapsPlaces _places = GoogleMapsPlaces(
  //       apiKey: kGoogleApiKey,
  //       // apiHeaders: await GoogleApiHeaders().getHeaders(),
  //     );
  //     PlacesDetailsResponse detail =
  //         await _places.getDetailsByPlaceId(p.placeId.toString());
  //     final lat = detail.result.geometry!.location.lat;
  //     final lng = detail.result.geometry!.location.lng;
  //
  //     print("${p.description} - $lat/$lng");
  //   }
  // }

  @override
  void initState() {
    googlePlace = GooglePlace(kGoogleApiKey);
    super.initState();
  }

  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      setState(() {
        predictions = result.predictions!;
      });
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF272D34),
          title: Text('Draw Land on Map'),
        ),
        body: Center(
          child: Column(
            children: [
              TextField(
                autofillHints: ["pune", "pune"],
                // predictions.length == 0
                //     ? []
                //     : List.generate(
                //         predictions.length > 10 ? 10 : predictions.length,
                //         (index) => predictions[index].placeId.toString()),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    autoCompleteSearch(value);
                  } else {
                    if (predictions.length > 0 && mounted) {
                      setState(() {
                        predictions = [];
                      });
                    }
                  }
                },
              ),
              TextButton(
                child: Text(
                  'Search',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: null, //_handlePressButton,
              ),
            ],
          ),
        ),
      );
}
//Column(
//             children: [
//               const SizedBox(
//                 height: 10,
//               ),
//               Container(
//                 height: 600,
//                 width: 900,
//                 child: GoogleMap(
//                   key: _key,
//                   //markers: {Marker(GeoCoord(17.4838891, 75.2999884),),},
//                   initialZoom: 12,
//                   initialPosition: GeoCoord(17.4838891, 75.2999884),
//                   mapType: _mapStyle,
//
//                   interactive: true,
//                   onTap: (coord) {
//                     if (_polygonAdded) {
//                       GoogleMap.of(_key)!.addMarkerRaw(
//                         GeoCoord(
//                           coord.latitude,
//                           coord.longitude,
//                         ),
//                       );
//                       polygon.add(GeoCoord(
//                         coord.latitude,
//                         coord.longitude,
//                       ));
//                       allLatitude += coord.latitude.toString() + ",";
//                       allLongitude += coord.longitude.toString() + ",";
//                       if (polygon.length == 3)
//                         GoogleMap.of(_key)!.addPolygon(
//                           '1',
//                           polygon,
//                         );
//                       if (polygon.length > 3)
//                         GoogleMap.of(_key)!.editPolygon(
//                           '1',
//                           polygon,
//                           fillColor: Colors.purple,
//                           strokeColor: Colors.purple,
//                         );
//                     }
//                     // _scaffoldKey.currentState!.showSnackBar(SnackBar(
//                     //   content: Text(coord.toString()),
//                     //   duration: const Duration(seconds: 2),
//                     // ));
//                   },
//                   mobilePreferences: const MobileMapPreferences(
//                     trafficEnabled: true,
//                     zoomControlsEnabled: false,
//                   ),
//                   webPreferences: WebMapPreferences(
//                     fullscreenControl: true,
//                     zoomControl: true,
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ElevatedButton.icon(
//                     icon: Icon(Icons.add),
//                     label: Text('Add'),
//                     onPressed: () {
//                       _polygonAdded = true;
//                       showToast("Add one by one marker on map",
//                           context: context,
//                           backgroundColor: Colors.green,
//                           duration: Duration(seconds: 3));
//                       setState(() {});
//                     },
//                   ),
//                   const SizedBox(
//                     width: 10,
//                   ),
//                   ElevatedButton.icon(
//                     icon: Icon(Icons.clear),
//                     label: Text('CLEAR All'),
//                     onPressed: () {
//                       GoogleMap.of(_key)!.clearMarkers();
//                       GoogleMap.of(_key)!.clearPolygons();
//                       polygon = [];
//                       setState(() => _polygonAdded = false);
//                     },
//                   ),
//                   const SizedBox(
//                     width: 10,
//                   ),
//                   ElevatedButton.icon(
//                     icon: Icon(Icons.save),
//                     label: Text('Save'),
//                     onPressed: () {
//                       Navigator.pop(context, [allLatitude, allLongitude]);
//                     },
//                   ),
//                   const SizedBox(
//                     width: 10,
//                   ),
//                   ElevatedButton.icon(
//                     icon: Icon(Icons.change_circle),
//                     label: !isSatelliteView
//                         ? Text('Satellite View')
//                         : Text('Road Map View'),
//                     onPressed: () {
//                       if (isSatelliteView) {
//                         _mapStyle = MapType.roadmap;
//                         isSatelliteView = false;
//                       } else {
//                         _mapStyle = MapType.satellite;
//                         isSatelliteView = true;
//                       }
//                       setState(() {});
//                     },
//                   )
//                 ],
//               )
//             ],
//           )
// Widget getMap() {
//   String htmlId = "7";
//
//   // ignore: undefined_prefixed_name
//   ui.platformViewRegistry.registerViewFactory(htmlId, (int viewId) {
//     final myLatlng = LatLng(1.3521, 103.8198);
//
//     final mapOptions = MapOptions()
//       ..zoom = 10
//       ..center = LatLng(1.3521, 103.8198);
//
//     final elem = DivElement()
//       ..id = htmlId
//       ..style.width = "100%"
//       ..style.height = "100%"
//       ..style.border = 'none';
//
//     final map = GMap(
//       elem,
//       mapOptions,
//     );
//
//     Marker(MarkerOptions()
//       ..position = myLatlng
//       ..map = map
//       ..title = 'Hello World!'
//       ..draggable = true);
//
//     return elem;
//   });
//
//   return HtmlElementView(viewType: htmlId);
// }
//
// Widget getMap2() {
//   String htmlId = "7";
//
//   final mapOptions = new MapOptions()
//     ..zoom = 8
//     ..center = new LatLng(-34.397, 150.644);
//
// // ignore: undefined_prefixed_name
//   ui.platformViewRegistry.registerViewFactory(htmlId, (int viewId) {
//     final elem = DivElement()
//       ..id = htmlId
//       ..style.width = "100%"
//       ..style.height = "100%"
//       ..style.border = 'none';
//
//     new GMap(elem, mapOptions);
//
//     return elem;
//   });
//
//   return HtmlElementView(viewType: htmlId);
// }
