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
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          //colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.9), BlendMode.dstATop),
          image: AssetImage(
              'assets/land_background.jpeg'), //NetworkImage('https://images.pexels.com/photos/388415/pexels-photo-388415.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          toolbarHeight: 60,
          backgroundColor: Colors.transparent, //const Color(0xFF272D34),
          title: const Text('Property Registry',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25)),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () {
                  launchUrl(
                      "https://github.com/saurabh-m-w/Blockchain-Based-Property-Registration");
                },
                iconSize: 30,
                icon: Image.asset(
                  'assets/github-logo.png',
                  color: Colors.white,
                  width: 60.0,
                  height: 60.0,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
        body: Container(
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: isDesktop ? Axis.horizontal : Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '     Blockchain Based \nProperty Registration and \n  Ownership Transfer',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Flex(
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
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
