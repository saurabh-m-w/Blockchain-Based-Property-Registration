import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const spinkitLoader = SpinKitWanderingCubes(
  color: Colors.blue,
  size: 50.0,
);

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Row(
      children: [
        const CircularProgressIndicator(),
        Container(
            margin: const EdgeInsets.only(left: 7),
            child: const Text("Loading...")),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
