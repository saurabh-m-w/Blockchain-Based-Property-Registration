import 'package:flutter/material.dart';
import 'package:land_registration/LandRegisterModel.dart';
import 'package:provider/provider.dart';

class UserDashBoard extends StatefulWidget {
  const UserDashBoard({Key? key}) : super(key: key);

  @override
  _UserDashBoardState createState() => _UserDashBoardState();
}

class _UserDashBoardState extends State<UserDashBoard> {
  bool isDesktop = false;
  int width = 400;
  var model;
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
        title: Text('User Dashboard'),
      ),
      body: Row(
        children: [
          isDesktop ? drawer() : Container(),
          Expanded(
            child: Column(
              children: [Text('Welcome')],
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
      ]),
    );
  }
}
