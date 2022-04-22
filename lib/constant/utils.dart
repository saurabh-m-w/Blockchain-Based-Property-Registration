import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:pdf/widgets.dart' as pw;

double ethToInr = 0;

bool connectedWithMetamask =
    false; //1->entered private key ; 2->connected with metamask

double width = 590;
bool isDesktop = false;
String privateKey = "";

class LandInfo {
  final String area;
  final String landAddress;
  final String landPrice;
  //string allLongitude;
  final String propertyPID;
  final String physicalSurveyNumber;
  final String document;
  final bool isforSell;
  final String ownerAddress;
  final bool isLandVerified;

  LandInfo(
      this.area,
      this.landAddress,
      this.landPrice,
      this.propertyPID,
      this.physicalSurveyNumber,
      this.document,
      this.isforSell,
      this.ownerAddress,
      this.isLandVerified);
}

launchUrl(String url) async {
  url = url.replaceAll('.dweb.', '.nftstorage.');

  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    );
  } else {
    throw 'Could not launch $url';
  }
}

getEthToInr() async {
  try {
    String api =
        "https://api.nomics.com/v1/currencies/ticker?key=b081894c50331900a2c0e667a3c24c66482ebc8c&ids=ETH&interval=1h&convert=INR";
    var url = Uri.parse(api);
    var response = await http.get(url);
    var data = jsonDecode(response.body);
    double priceInr = double.parse(data[0]['price']);
    ethToInr = double.parse(priceInr.toStringAsFixed(3));
    print("ETH to INR " + priceInr.toStringAsFixed(3));
  } catch (e) {
    print(e);
    ethToInr = 329172.649;
  }
}

Widget CustomButton(text, fun) => Container(
      constraints: const BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
      margin: const EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: fun,
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
Widget CustomButton2(text, fun) => Container(
      constraints: const BoxConstraints(maxWidth: 150.0, minHeight: 40.0),
      margin: const EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: fun,
        //color: Theme.of(context).accentColor,
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
Widget CustomButton3(text, fun, color) => Container(
      constraints: const BoxConstraints(maxWidth: 130.0, minHeight: 40.0),
      margin: const EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: fun,
        style: ElevatedButton.styleFrom(primary: color),
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Container(
            color: color,
            alignment: Alignment.center,
            child: Text(
              text,
              style: TextStyle(
                fontSize: 15,
                color: color == Colors.white ? Colors.black : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
Widget CustomAnimatedContainer(text, fun) => Padding(
      padding: const EdgeInsets.all(10.0),
      child: HoverCrossFadeWidget(
        firstChild: Container(
          height: 270,
          width: 250,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black54, width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(13))),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (text == 'Contract Owner')
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    'assets/contract_owner_icon.jpg',
                    width: 110.0,
                    height: 110.0,
                    fit: BoxFit.fill,
                  ),
                ),
              if (text == 'Land Inspector')
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    'assets/land_ins_icon.jpg',
                    width: 110.0,
                    height: 110.0,
                    fit: BoxFit.fill,
                  ),
                ),
              if (text == 'User')
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    'assets/user_icon.png',
                    width: 110.0,
                    height: 110.0,
                    fit: BoxFit.fill,
                  ),
                ),
              Text(
                text,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              CustomButton2('Continue', fun)
            ],
          )),
        ),
        duration: const Duration(milliseconds: 100),
        secondChild: Container(
          height: 270,
          width: 250,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.blue, width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (text == 'Contract Owner')
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    'assets/contract_owner_icon.jpg',
                    width: 110.0,
                    height: 110.0,
                    fit: BoxFit.fill,
                  ),
                ),
              if (text == 'Land Inspector')
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    'assets/land_ins_icon.jpg',
                    width: 110.0,
                    height: 110.0,
                    fit: BoxFit.fill,
                  ),
                ),
              if (text == 'User')
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    'assets/user_icon.png',
                    width: 110.0,
                    height: 110.0,
                    fit: BoxFit.fill,
                  ),
                ),
              Text(
                text,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              CustomButton2('Continue', fun)
            ],
          )),
        ),
      ),
    );

Widget CustomTextFiled(text, label) => Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        readOnly: true,
        initialValue: text,
        style: const TextStyle(
          fontSize: 15,
        ),
        decoration: InputDecoration(
            isDense: true, // Added this
            contentPadding: const EdgeInsets.all(12),
            border: const OutlineInputBorder(),
            labelText: label,
            labelStyle: const TextStyle(fontSize: 20),
            fillColor: Colors.grey,
            filled: true),
      ),
    );

class Menu {
  String title;
  IconData icon;

  Menu({required this.title, required this.icon});
}

void confirmDialog(
  msg,
  context,
  func,
) =>
    showCupertinoDialog(
        context: context,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            title: const Text('Please Confirm'),
            content: Text(msg),
            actions: [
              // The "Yes" button
              CupertinoDialogAction(
                onPressed: func,
                child: const Text('Yes'),
                isDefaultAction: true,
                isDestructiveAction: true,
              ),
              // The "No" button
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('No'),
                isDefaultAction: false,
                isDestructiveAction: false,
              )
            ],
          );
        });

pw.TableRow tableRow(text1, text2) =>
    pw.TableRow(children: [pw.Text(text1), pw.Text(text2)]);
pw.TableRow tableRowSizedBox() =>
    pw.TableRow(children: [pw.SizedBox(height: 14), pw.SizedBox(height: 14)]);
