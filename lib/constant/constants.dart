import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';
import 'package:http/http.dart' as http;

double width = 590;
bool isDesktop = false;
String privateKey = "";
double ethToInr = 0;

getEthToInr() async {
  String api =
      "https://api.nomics.com/v1/currencies/ticker?key=b081894c50331900a2c0e667a3c24c66482ebc8c&ids=ETH&interval=1h&convert=INR";
  var url = Uri.parse(api);
  var response = await http.get(url);
  var data = jsonDecode(response.body);
  double priceInr = double.parse(data[0]['price']);
  ethToInr = double.parse(priceInr.toStringAsFixed(3));
  print("ETH to INR " + priceInr.toStringAsFixed(3));
}

Widget CustomButton(text, fun) => Container(
      constraints: BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
      margin: EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: fun,
        //color: Theme.of(context).accentColor,
        child: Padding(
          padding: EdgeInsets.all(0),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              text,
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
Widget CustomButton2(text, fun) => Container(
      constraints: BoxConstraints(maxWidth: 150.0, minHeight: 40.0),
      margin: EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: fun,
        //color: Theme.of(context).accentColor,
        child: Padding(
          padding: EdgeInsets.all(0),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              text,
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
Widget CustomButton3(text, fun, color) => Container(
      constraints: BoxConstraints(maxWidth: 130.0, minHeight: 40.0),
      margin: EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: fun,
        style: ElevatedButton.styleFrom(primary: color),
        child: Padding(
          padding: EdgeInsets.all(0),
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
              border: Border.all(color: Colors.black54, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(13))),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (text == 'Contract Owner')
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    'contract_owner_icon.jpg',
                    width: 110.0,
                    height: 110.0,
                    fit: BoxFit.fill,
                  ),
                ),
              if (text == 'Land Inspector')
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    'land_ins_icon.jpg',
                    width: 110.0,
                    height: 110.0,
                    fit: BoxFit.fill,
                  ),
                ),
              if (text == 'User')
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Icon(
                    Icons.person,
                    size: 85,
                  ),
                ),
              Text(
                text,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              CustomButton2('Continue', fun)
            ],
          )),
        ),
        duration: Duration(milliseconds: 100),
        secondChild: Container(
          height: 270,
          width: 250,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (text == 'Contract Owner')
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    'contract_owner_icon.jpg',
                    width: 110.0,
                    height: 110.0,
                    fit: BoxFit.fill,
                  ),
                ),
              if (text == 'Land Inspector')
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    'land_ins_icon.jpg',
                    width: 110.0,
                    height: 110.0,
                    fit: BoxFit.fill,
                  ),
                ),
              if (text == 'User')
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Icon(
                    Icons.person,
                    size: 90,
                  ),
                ),
              Text(
                text,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              CustomButton2('Continue', fun)
            ],
          )),
        ),
      ),
    );

Widget CustomTextFiled(text, label) => Padding(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        readOnly: true,
        initialValue: text,
        style: TextStyle(
          fontSize: 15,
        ),
        decoration: InputDecoration(
            isDense: true, // Added this
            contentPadding: EdgeInsets.all(12),
            border: OutlineInputBorder(),
            labelText: label,
            labelStyle: TextStyle(fontSize: 20),
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
  context,
  func,
) =>
    showCupertinoDialog(
        context: context,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            title: Text('Please Confirm'),
            content: Text('Are you sure to make it on sell?'),
            actions: [
              // The "Yes" button
              CupertinoDialogAction(
                onPressed: func,
                child: Text('Yes'),
                isDefaultAction: true,
                isDestructiveAction: true,
              ),
              // The "No" button
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('No'),
                isDefaultAction: false,
                isDestructiveAction: false,
              )
            ],
          );
        });
