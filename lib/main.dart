import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:land_registration/LandRegisterModel.dart';
import 'package:land_registration/home_page.dart';
import 'package:provider/provider.dart';

import 'constant/MetamaskProvider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // return ChangeNotifierProvider(
    //   create: (context) => LandRegisterModel(),
    //   child: MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     navigatorObservers: [FlutterSmartDialog.observer],
    //     builder: FlutterSmartDialog.init(),
    //     home: home_page(),
    //   ),
    // );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LandRegisterModel>(
          create: (context) => LandRegisterModel(),
        ),
        ChangeNotifierProvider<MetaMaskProvider>(
          create: (context) => MetaMaskProvider()..init(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorObservers: [FlutterSmartDialog.observer],
        builder: FlutterSmartDialog.init(),
        home: home_page(),
      ),
    );
  }
}
