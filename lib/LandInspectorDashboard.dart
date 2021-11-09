import 'package:flutter/material.dart';
import 'package:land_registration/LandRegisterModel.dart';
import 'package:land_registration/home_page.dart';
import 'package:provider/provider.dart';

class LandInspector extends StatefulWidget {
  const LandInspector({Key? key}) : super(key: key);

  @override
  _LandInspectorState createState() => _LandInspectorState();
}

class _LandInspectorState extends State<LandInspector> {
  bool isDesktop = false;
  int width = 400;
  var model;

  List<List<dynamic>> userData = [];
  // List<List<String>> data = [
  //   ['0xd55EDeFB3120A759e72339c785796681857a2830', 'Saurabh', 'Verified'],
  //   ['0xd55EDeFB3120A759e72339c785796681857a2830', 'Saurabh', 'Verified'],
  //   ['0xd55EDeFB3120A759e72339c785796681857a2830', 'Saurabh', 'Verified'],
  //   ['0xd55EDeFB3120A759e72339c785796681857a2830', 'Saurabh', 'Verified'],
  // ];
  int screen = 0;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width as int;
    model = Provider.of<LandRegisterModel>(context);

    if (width > 500) {
      isDesktop = true;
      width = 420;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("LandInspector Dashboard"),
      ),
      body: Row(
        children: [
          isDesktop ? drawer() : Container(),
          if (screen == 0)
            Expanded(
              child: Text('Welcome'),
            )
          else if (screen == 1)
            Expanded(
              child: Container(
                padding: EdgeInsets.all(25),
                child: userList(),
              ),
            )
          else if (screen == 2)
            Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
        ],
      ),
    );
  }

  Widget drawer() {
    return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: <Widget>[
        ListTile(
          leading: Icon(Icons.dashboard),
          title: Text('Welcome'),
          onTap: () {
            setState(() {
              screen = 0;
            });
          },
        ),
        ListTile(
          leading: Icon(Icons.verified_user),
          title: Text('VerifyUser'),
          onTap: () {
            setState(() {
              screen = 2;
            });
            getUserList();
          },
        ),
        ListTile(
          leading: Icon(Icons.verified_user),
          title: Text('VerifyLand'),
          onTap: () async {},
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

  Future<void> getUserList() async {
    List<dynamic> userList = await model.allUsers();

    List<List<dynamic>> allInfo = [];
    List<dynamic> temp;
    for (int i = 0; i < userList.length; i++) {
      print(userList[i].toString());
      temp = await model.userInfo(userList[i].toString());
      allInfo.add(temp);
    }
    setState(() {
      userData = allInfo;
      screen = 1;
    });
    //return allInfo;
  }

  Widget userList() {
    return ListView.builder(
        itemCount: userData == null ? 1 : userData.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(
              children: [
                Divider(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Sr.No.',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      flex: 1,
                    ),
                    Expanded(
                        child: Center(
                          child: Text('Address',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        flex: 3),
                    Expanded(
                      child: Text('Name',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      flex: 2,
                    ),
                    Expanded(
                      child: Text('Document',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      flex: 1,
                    ),
                    Expanded(
                      child: Text('Verify',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      flex: 1,
                    )
                  ],
                ),
                Divider(
                  height: 15,
                )
              ],
            );
          }
          index -= 1;
          List<dynamic> data = userData[index];
          return ListTile(
            title: Row(
              children: [
                Expanded(
                  child: Text(index.toString()),
                  flex: 1,
                ),
                Expanded(child: Text(data[0].toString()), flex: 3),
                Expanded(child: Text(data[1].toString()), flex: 2),
                Expanded(
                    child: Text(
                      data[6].toString(),
                    ),
                    flex: 1),
                Expanded(
                    child: data[8]
                        ? Text('Verified')
                        : ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                screen = 2;
                              });
                              await model.verifyUser(data[0].toString());
                              getUserList();
                            },
                            child: Text('Verify')),
                    flex: 1),
              ],
            ),
          );
        });
  }
  // Widget userList() {
  //   return FutureBuilder(
  //     future: getUserList(),
  //     builder: (context, AsyncSnapshot<List<List<dynamic>>> snap) {
  //       if (snap.connectionState == ConnectionState.none &&
  //           snap.hasData == null) {
  //         //print('project snapshot data is: ${projectSnap.data}');
  //         return Container();
  //       }
  //       return ListView.builder(
  //           itemCount: snap.data == null ? 1 : snap.data!.length + 1,
  //           itemBuilder: (context, index) {
  //             if (index == 0) {
  //               return Column(
  //                 children: [
  //                   Row(
  //                     children: [
  //                       Expanded(
  //                         child: Text(
  //                           'Sr.No.',
  //                           style: TextStyle(fontWeight: FontWeight.bold),
  //                         ),
  //                         flex: 1,
  //                       ),
  //                       Expanded(
  //                           child: Center(
  //                             child: Text('Address',
  //                                 style:
  //                                     TextStyle(fontWeight: FontWeight.bold)),
  //                           ),
  //                           flex: 3),
  //                       Expanded(
  //                         child: Text('Name',
  //                             style: TextStyle(fontWeight: FontWeight.bold)),
  //                         flex: 2,
  //                       ),
  //                       Expanded(
  //                         child: Text('Document',
  //                             style: TextStyle(fontWeight: FontWeight.bold)),
  //                         flex: 1,
  //                       ),
  //                       Expanded(
  //                         child: Text('Verify',
  //                             style: TextStyle(fontWeight: FontWeight.bold)),
  //                         flex: 1,
  //                       )
  //                     ],
  //                   ),
  //                   Divider()
  //                 ],
  //               );
  //             }
  //             index -= 1;
  //             List<dynamic> data = snap.data![index];
  //             return ListTile(
  //               title: Row(
  //                 children: [
  //                   Expanded(
  //                     child: Text(index.toString()),
  //                     flex: 1,
  //                   ),
  //                   Expanded(child: Text(data[0].toString()), flex: 3),
  //                   Expanded(child: Text(data[1].toString()), flex: 2),
  //                   Expanded(
  //                       child: Text(
  //                         data[6].toString(),
  //                       ),
  //                       flex: 1),
  //                   Expanded(child: Text(data[8].toString()), flex: 1),
  //                 ],
  //               ),
  //             );
  //           });
  //     },
  //   );
  // }
}
