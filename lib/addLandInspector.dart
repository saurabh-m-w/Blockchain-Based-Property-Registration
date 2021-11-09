import 'package:flutter/material.dart';
import 'package:land_registration/LandRegisterModel.dart';
import 'package:land_registration/constant/constants.dart';
import 'package:land_registration/constant/loadingScreen.dart';
import 'package:land_registration/home_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class AddLandInspector extends StatefulWidget {
  const AddLandInspector({Key? key}) : super(key: key);

  @override
  _AddLandInspectorState createState() => _AddLandInspectorState();
}

class _AddLandInspectorState extends State<AddLandInspector> {
  late String address, name, age, desig, city;
  var model;
  bool isDesktop = false;
  double width = 490;
  int screen = 0;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    model = Provider.of<LandRegisterModel>(context);

    if (width > 500) {
      isDesktop = true;
      width = 490;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Add Land Inspector',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Row(
        children: [
          isDesktop ? drawer() : Container(),
          if (screen == 0)
            Expanded(
              child: addLandInspector(),
            )
        ],
      ),
    );
  }

  Widget addLandInspector() {
    return Container(
      width: width,
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                onChanged: (val) {
                  address = val;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Address',
                  hintText:
                      'Enter Land Inspector Address(0xc5aEabE793B923981fc401bb8da620FDAa45ea2B)',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                onChanged: (val) {
                  name = val;
                },
                //obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                  hintText: 'Enter Name',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                onChanged: (val) {
                  age = val;
                },
                //obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Age',
                  hintText: 'Enter Age',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                onChanged: (val) {
                  desig = val;
                },
                //obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Designation',
                  hintText: 'Enter Designation',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                onChanged: (val) {
                  city = val;
                },
                //obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'City',
                  hintText: 'Enter City',
                ),
              ),
            ),
            CustomButton(
                'Add',
                isLoading
                    ? null
                    : () async {
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          await model.addLandInspector(
                              address, name, age, desig, city);
                          showToast("Successfully Added",
                              context: context, backgroundColor: Colors.green);
                        } catch (e) {
                          print(e);
                          showToast("Something Went Wrong",
                              context: context, backgroundColor: Colors.red);
                        }
                        setState(() {
                          isLoading = false;
                        });
                      }),
            isLoading ? CircularProgressIndicator() : Container()
          ],
        ),
      ),
    );
  }

  Widget drawer() {
    return Drawer(
      elevation: 10,
      child: ListView(padding: EdgeInsets.zero, children: <Widget>[
        ListTile(
          leading: Icon(Icons.dashboard),
          title: Text('Add Land Inspector'),
          onTap: () {
            setState(() {
              //screen = 0;
            });
          },
        ),
        ListTile(
          leading: Icon(Icons.verified_user),
          title: Text('All Land Inspectors'),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text('Logout'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => home_page()));
          },
        ),
      ]),
    );
  }
}
