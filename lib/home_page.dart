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
    width = MediaQuery.of(context).size.width;
    if (width > 600) {
      width = 590;
      isDesktop = true;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF272D34),
        centerTitle: true,
        title: const Text('Blockchain Based Property Registration'),
      ),
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Flex(
              mainAxisAlignment: MainAxisAlignment.center,
              direction: isDesktop ? Axis.horizontal : Axis.vertical,
              children: [
                CustomAnimatedContainer('Contract Owner', () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CheckPrivateKey(
                                val: "owner",
                              )));
                }),
                CustomAnimatedContainer('Land Inspector', () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CheckPrivateKey(
                                val: "LandInspector",
                              )));
                }),
                CustomAnimatedContainer('User', () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CheckPrivateKey(
                                val: "UserLogin",
                              )));
                }),
                // CustomAnimatedContainer('User Register', () {
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => CheckPrivateKey(
                //                 val: "RegisterUser",
                //               )));
                // })
              ],
            ),
          ),
          // Column(
          //   children: [
          //     CustomButton('Login as ContractOwner', () {
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) => CheckPrivateKey(
          //                     val: "owner",
          //                   )));
          //     }),
          //     CustomButton('Login as LandInspector', () {
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) => CheckPrivateKey(
          //                     val: "LandInspector",
          //                   )));
          //     }),
          //     CustomButton("Login as User", () {
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) => CheckPrivateKey(
          //                     val: "UserLogin",
          //                   )));
          //     }),
          //     CustomButton("RegisterUser", () {
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) => CheckPrivateKey(
          //                     val: "RegisterUser",
          //                   )));
          //     }),
          //   ],
          // ),
        ),
      ),
    );
  }
}
