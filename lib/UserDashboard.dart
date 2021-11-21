import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:land_registration/LandRegisterModel.dart';
import 'package:land_registration/constant/loadingScreen.dart';
import 'package:land_registration/home_page.dart';
import 'package:land_registration/widget/land_container.dart';
import 'package:land_registration/widget/menu_item_tile.dart';
import 'package:provider/provider.dart';

import 'constant/constants.dart';

class UserDashBoard extends StatefulWidget {
  const UserDashBoard({Key? key}) : super(key: key);

  @override
  _UserDashBoardState createState() => _UserDashBoardState();
}

class _UserDashBoardState extends State<UserDashBoard> {
  var model;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int screen = 0;
  late List<dynamic> userInfo;
  bool isLoading = true, isUserVerified = false;
  bool isUpdated = true;
  List<List<dynamic>> LandGall = [];
  String name = "";
  late AnimationController _animationController;
  late Animation<double> _animation;
  final _formKey = GlobalKey<FormState>();
  late String area, city, state, landPrice, propertyID, surveyNo, document;
  List<List<dynamic>> landInfo = [];
  List<Menu> menuItems = [
    Menu(title: 'Dashboard', icon: Icons.dashboard),
    Menu(title: 'Add Lands', icon: Icons.add_chart),
    Menu(title: 'My Lands', icon: Icons.landscape_rounded),
    Menu(title: 'Land Gallery', icon: Icons.landscape_rounded),
    Menu(title: 'My Land Request', icon: Icons.request_page_outlined),
    Menu(title: 'Logout', icon: Icons.logout),
  ];

  getLandInfo() async {
    setState(() {
      isLoading = true;
    });
    List<dynamic> landList = await model.myAllLands();
    List<List<dynamic>> info = [];
    List<dynamic> temp;
    for (int i = 0; i < landList.length; i++) {
      temp = await model.landInfo(landList[i]);
      info.add(temp);
    }
    landInfo = info;
    setState(() {
      isLoading = false;
    });
    print(info);
  }

  getLandGallery() async {
    setState(() {
      isLoading = true;
    });
    List<dynamic> landList = await model.allLandList();
    List<List<dynamic>> allInfo = [];
    List<dynamic> temp;
    for (int i = 0; i < landList.length; i++) {
      temp = await model.landInfo(landList[i]);
      allInfo.add(temp);
    }
    LandGall = allInfo;
    screen = 3;
    isLoading = false;
    print(LandGall);
    setState(() {});
  }

  Future<void> getProfileInfo() async {
    // setState(() {
    //   isLoading = true;
    // });
    userInfo = await model.myProfileInfo();
    name = userInfo[1];
    setState(() {
      isLoading = false;
    });
    print(userInfo);
  }

  @override
  Widget build(BuildContext context) {
    model = Provider.of<LandRegisterModel>(context);
    if (isUpdated) {
      getProfileInfo();
      isUpdated = false;
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF272D34),
        leading: isDesktop
            ? Container()
            : GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.menu,
                    color: Colors.white,
                  ), //AnimatedIcon(icon: AnimatedIcons.menu_arrow,progress: _animationController,),
                ),
                onTap: () {
                  _scaffoldKey.currentState!.openDrawer();
                },
              ),
        title: const Text('User Dashboard'),
      ),
      drawer: drawer2(),
      drawerScrimColor: Colors.transparent,
      body: Row(
        children: [
          isDesktop ? drawer2() : Container(),
          // Expanded(
          //   child: Column(
          //     children: [Text('Welcome')],
          //   ),
          // ),
          if (screen == 0)
            Center(widthFactor: isDesktop ? 2 : 1, child: userProfile())
          else if (screen == 1)
            addLand()
          else if (screen == 2)
            myLands()
          else if (screen == 3)
            LandGallery()
        ],
      ),
    );
  }

  Widget LandGallery() {
    if (isLoading) return CircularProgressIndicator();
    return Center(
      child: Container(
        width: isDesktop ? 900 : width,
        child: GridView.builder(
          padding: EdgeInsets.all(10),
          scrollDirection: Axis.vertical,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 440,
              crossAxisCount: isDesktop ? 2 : 1,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          itemCount: LandGall.length,
          itemBuilder: (context, index) {
            return landWid(
                LandGall[index][10],
                LandGall[index][1].toString(),
                LandGall[index][2].toString() + LandGall[index][3].toString(),
                LandGall[index][4].toString());
          },
        ),
      ),
    );
  }

  Widget myLands() {
    if (isLoading) return CircularProgressIndicator();
    return Center(
      child: Container(
        width: isDesktop ? 900 : width,
        child: GridView.builder(
          padding: EdgeInsets.all(10),
          scrollDirection: Axis.vertical,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 440,
              crossAxisCount: isDesktop ? 2 : 1,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          itemCount: landInfo.length,
          itemBuilder: (context, index) {
            return landWid(
                landInfo[index][10],
                landInfo[index][4].toString(),
                landInfo[index][2].toString() + landInfo[index][3].toString(),
                landInfo[index][1].toString());
          },
        ),
      ),
    );
  }

  Widget addLand() {
    return Center(
      widthFactor: isDesktop ? 2 : 1,
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            //color: Color(0xFFBb3b3cc),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all()),
        width: width,
        child: Form(
          key: _formKey,
          child: Column(
            // scrollDirection: Axis.vertical,
            // shrinkWrap: true,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(12),
                child: TextFormField(
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onChanged: (val) {
                    area = val;
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                  ],
                  decoration: InputDecoration(
                    isDense: true, // Added this
                    contentPadding: EdgeInsets.all(12),
                    border: OutlineInputBorder(),
                    labelText: 'Area(SqFt)',
                    hintText: 'Enter Area in SqFt',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter city';
                    }
                    return null;
                  },
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  onChanged: (val) {
                    city = val;
                  },
                  decoration: InputDecoration(
                    isDense: true, // Added this
                    contentPadding: EdgeInsets.all(12),
                    border: OutlineInputBorder(),
                    labelText: 'City',
                    hintText: 'Enter city',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  onChanged: (val) {
                    state = val;
                  },
                  //obscureText: true,
                  decoration: InputDecoration(
                    isDense: true, // Added this
                    contentPadding: EdgeInsets.all(12),
                    border: OutlineInputBorder(),
                    labelText: 'State',
                    hintText: 'Enter State',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Land Price';
                    }
                    return null;
                  },
                  //maxLength: 12,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                  ],
                  onChanged: (val) {
                    landPrice = val;
                  },
                  //obscureText: true,
                  decoration: InputDecoration(
                    isDense: true, // Added this
                    contentPadding: EdgeInsets.all(12),
                    border: OutlineInputBorder(),
                    labelText: 'Land Price',
                    hintText: 'Enter Land Price',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter PID';
                    }
                    return null;
                  },
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  //maxLength: 10,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                  ],
                  onChanged: (val) {
                    propertyID = val;
                  },
                  //obscureText: true,
                  decoration: InputDecoration(
                    isDense: true, // Added this
                    contentPadding: EdgeInsets.all(12),
                    border: OutlineInputBorder(),
                    labelText: 'PID',
                    hintText: 'Enter Property ID',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onChanged: (val) {
                    surveyNo = val;
                  },
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  //obscureText: true,
                  decoration: InputDecoration(
                    isDense: true, // Added this
                    contentPadding: EdgeInsets.all(12),
                    border: OutlineInputBorder(),
                    labelText: 'Survey No.',
                    hintText: 'Survey No.',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return '';
                    else
                      return null;
                  },
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  onChanged: (val) {
                    document = val;
                  },
                  //obscureText: true,
                  decoration: InputDecoration(
                    isDense: true, // Added this
                    contentPadding: EdgeInsets.all(12),
                    border: OutlineInputBorder(),
                    labelText: 'Land Document',
                    hintText: 'Land Document',
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
                              await model.addLand(area, city, state, landPrice,
                                  propertyID, surveyNo, document);
                              showToast("Land Successfully Added",
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

                          //model.makePaymentTestFun();
                        }),
              isLoading ? spinkitLoader : Container()
            ],
          ),
        ),
      ),
    );
  }

  Widget userProfile() {
    if (isLoading) return CircularProgressIndicator();
    isUserVerified = userInfo[8];
    return Container(
      width: width,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          //color: Color(0xFFBb3b3cc),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all()),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Profile',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          userInfo[8]
              ? Row(
                  children: [
                    Text(
                      'Verified',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                    Icon(
                      Icons.verified,
                      color: Colors.green,
                    )
                  ],
                )
              : Text(
                  'Not Yet Verified',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blueAccent),
                ),
          CustomTextFiled(userInfo[0].toString(), 'Wallet Address'),
          CustomTextFiled(userInfo[1].toString(), 'Name'),
          CustomTextFiled(userInfo[2].toString(), 'Age'),
          CustomTextFiled(userInfo[3].toString(), 'City'),
          CustomTextFiled(userInfo[4].toString(), 'Adhar Number'),
          CustomTextFiled(userInfo[5].toString(), 'Pan'),
          Text(
            'View Document',
            style: TextStyle(color: Colors.blue),
          ),
          CustomTextFiled(userInfo[7].toString(), 'Mail'),
        ],
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
          Text(name,
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
                    if (index == 5) {
                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => home_page()));
                    }
                    if (index == 0) getProfileInfo();
                    if (index == 2) getLandInfo();
                    if (index == 3) getLandGallery();
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
          title: Text('Welcome'),
          onTap: () => {},
        ),
        ListTile(
          leading: Icon(Icons.verified_user),
          title: Text('Add Lands'),
          onTap: () => {},
        ),
        ListTile(
          leading: Icon(Icons.verified_user),
          title: Text('My Lands'),
          onTap: () async {},
        ),
        ListTile(
          leading: Icon(Icons.verified_user),
          title: Text('My Land Request'),
          onTap: () async {
            //await model.allUsers();
            //await model.userInfo('0x97Ac9Fa9797eb63f54ECCe96A89AD10010eCDD2F');
          },
        ),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text('Logout'),
          onTap: () async {
            Navigator.pop(context);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => home_page()));
          },
        ),
      ]),
    );
  }
}
