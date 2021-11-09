import 'package:flutter/material.dart';
import 'package:land_registration/Check_private_key.dart';
import 'package:land_registration/LandRegisterModel.dart';
import 'package:land_registration/constant/constants.dart';
import 'package:provider/provider.dart';

class home_page extends StatefulWidget {
  const home_page({Key? key}) : super(key: key);

  @override
  _home_pageState createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  @override
  Widget build(BuildContext context) {
    var model = Provider.of<LandRegisterModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Land Registration'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              CustomButton('Login as ContractOwner', () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CheckPrivateKey(
                              val: "owner",
                            )));
              }),
              CustomButton('Login as LandInspector', () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CheckPrivateKey(
                              val: "LandInspector",
                            )));
              }),
              CustomButton("Login as User", () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CheckPrivateKey(
                              val: "UserLogin",
                            )));
              }),
              CustomButton("RegisterUser", () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CheckPrivateKey(
                              val: "RegisterUser",
                            )));
              }),
            ],
          ),
        ),
      ),
    );
  }
}
