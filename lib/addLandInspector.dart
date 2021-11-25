import 'package:flutter/material.dart';
import 'package:land_registration/LandRegisterModel.dart';
import 'package:land_registration/constant/constants.dart';
//import 'package:land_registration/constant/loadingScreen.dart';
import 'package:land_registration/home_page.dart';
import 'package:land_registration/widget/menu_item_tile.dart';
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
  double width = 490;
  int screen = 0;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Menu> menuItems = [
    Menu(title: 'Add Land Inspector', icon: Icons.person_add),
    Menu(title: 'All Land Inspectors', icon: Icons.group),
    Menu(title: 'Logout', icon: Icons.logout),
  ];
  @override
  Widget build(BuildContext context) {
    model = Provider.of<LandRegisterModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF272D34),
        leading: isDesktop
            ? Container()
            : GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Icon(
                    Icons.menu,
                    color: Colors.white,
                  ), //AnimatedIcon(icon: AnimatedIcons.menu_arrow,progress: _animationController,),
                ),
                onTap: () {
                  _scaffoldKey.currentState!.openDrawer();
                },
              ),
        title: Text(
          'Add Land Inspector',
        ),
      ),
      drawer: drawer2(),
      drawerScrimColor: Colors.transparent,
      body: Row(
        children: [
          isDesktop ? drawer2() : Container(),
          if (screen == 0) addLandInspector()
        ],
      ),
    );
  }

  Widget addLandInspector() {
    return Center(
      widthFactor: isDesktop ? 2 : 1,
      child: Container(
        width: width,
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
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
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
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
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
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
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
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
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
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
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              try {
                                await model.addLandInspector(
                                    address, name, age, desig, city);
                                showToast("Successfully Added",
                                    context: context,
                                    backgroundColor: Colors.green);
                              } catch (e) {
                                print(e);
                                showToast("Something Went Wrong",
                                    context: context,
                                    backgroundColor: Colors.red);
                              }
                              setState(() {
                                isLoading = false;
                              });
                            }
                          }),
                isLoading ? CircularProgressIndicator() : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget drawer2() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(blurRadius: 10, color: Colors.black26, spreadRadius: 2)
        ],
        color: Color(0xFF272D34),
      ),
      width: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.person,
            size: 50,
          ),
          SizedBox(
            width: 30,
          ),
          Text('Contract Owner',
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          SizedBox(
            height: 80,
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, counter) {
                return Divider(
                  height: 2,
                );
              },
              itemCount: menuItems.length,
              itemBuilder: (BuildContext context, int index) {
                return MenuItemTile(
                  title: menuItems[index].title,
                  icon: menuItems[index].icon,
                  isSelected: screen == index,
                  onTap: () {
                    if (index == 2) {
                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => home_page()));
                    }

                    setState(() {
                      screen = index;
                    });
                  },
                );
              },
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  Widget drawer() {
    return Container(
      width: 250,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.blueGrey,
              Colors.grey,
            ],
          ),
          //color: Color(0xFFBb3b3cc),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all()),
      child: ListView(padding: EdgeInsets.zero, children: <Widget>[
        ListTile(
          leading: Icon(Icons.dashboard),
          title:
              Text('Add Land Inspector', style: TextStyle(color: Colors.white)),
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
