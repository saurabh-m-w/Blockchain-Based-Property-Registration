import 'package:flutter/material.dart';
import 'package:land_registration/constant/constants.dart';
import 'package:mapbox_search/mapbox_search.dart';

class MapSample extends StatefulWidget {
  @override
  _MapSampleState createState() => _MapSampleState();
}

class _MapSampleState extends State<MapSample> {
  List<MapBoxPlace> predictions = [];
  late PlacesSearch placesSearch;
  final FocusNode _focusNode = FocusNode();
  late OverlayEntry _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  TextEditingController addressController = TextEditingController();
  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
        builder: (context) => Positioned(
              width: 600,
              child: CompositedTransformFollower(
                link: this._layerLink,
                showWhenUnlinked: false,
                offset: Offset(0.0, 40 + 5.0),
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
                                _overlayEntry.remove();
                                _overlayEntry.dispose();
                                setState(() {});
                              },
                            )),
                  ),
                ),
              ),
            ));
  }

  @override
  void initState() {
    placesSearch = PlacesSearch(
      apiKey:
          'pk.eyJ1Ijoic2F1cmFiaG13IiwiYSI6ImNreTRiYzNidjBhMTkydnB2dmpoeGt4ZmgifQ.2QZ4CsNiygDTAhkqASpbPg',
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
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF272D34),
          title: Text('Draw Land on Map'),
        ),
        body: Container(
          width: width,
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: CompositedTransformTarget(
                    link: this._layerLink,
                    child: TextFormField(
                      controller: addressController,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          autocomplete(value);
                          _overlayEntry.remove();
                          _overlayEntry = this._createOverlayEntry();
                          Overlay.of(context)!.insert(_overlayEntry);
                        } else {
                          if (predictions.length > 0 && mounted) {
                            setState(() {
                              predictions = [];
                            });
                          }
                        }
                      },
                      focusNode: this._focusNode,
                      decoration: const InputDecoration(
                        isDense: true, // Added this
                        contentPadding: EdgeInsets.all(12),
                        border: OutlineInputBorder(),
                        labelText: 'Address',
                        hintText: 'Enter Address',
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextFormField(
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    onChanged: (val) {},
                    decoration: const InputDecoration(
                      isDense: true, // Added this
                      contentPadding: EdgeInsets.all(12),
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                      hintText: 'Enter Name',
                    ),
                  ),
                ),
                // TextField(
                //   onChanged: (value) {
                //     if (value.isNotEmpty) {
                //       autocomplete(value);
                //     } else {
                //       if (predictions.length > 0 && mounted) {
                //         setState(() {
                //           predictions = [];
                //         });
                //       }
                //     }
                //   },
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                // ListView.builder(
                //   itemCount: predictions.length,
                //   itemBuilder: (context, index) {
                //     return ListTile(
                //       leading: CircleAvatar(
                //         child: Icon(
                //           Icons.pin_drop,
                //           color: Colors.white,
                //         ),
                //       ),
                //       title: Text(predictions[index].placeName.toString()),
                //       onTap: () {
                //         debugPrint(predictions[index].placeName);
                //       },
                //     );
                //   },
                // ),

                //Positioned(top: 20, child: CustomTextFiled("text", "label"))
              ],
            ),
          ),
        ),
      );
}

class CountriesField extends StatefulWidget {
  @override
  _CountriesFieldState createState() => _CountriesFieldState();
}

class _CountriesFieldState extends State<CountriesField> {
  final FocusNode _focusNode = FocusNode();
  late OverlayEntry _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        this._overlayEntry = this._createOverlayEntry();
        Overlay.of(context)!.insert(this._overlayEntry);
      } else {
        this._overlayEntry.remove();
      }
    });
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
        builder: (context) => Positioned(
              width: 100,
              child: CompositedTransformFollower(
                link: this._layerLink,
                showWhenUnlinked: false,
                offset: Offset(0.0, 100 + 5.0),
                child: Material(
                  elevation: 4.0,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    children: <Widget>[
                      ListTile(
                        title: Text('Syria'),
                        onTap: () {
                          print('Syria Tapped');
                        },
                      ),
                      ListTile(
                        title: Text('Lebanon'),
                        onTap: () {
                          print('Lebanon Tapped');
                        },
                      )
                    ],
                  ),
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: this._layerLink,
      child: TextFormField(
        focusNode: this._focusNode,
        decoration: InputDecoration(labelText: 'Country'),
      ),
    );
  }
}
