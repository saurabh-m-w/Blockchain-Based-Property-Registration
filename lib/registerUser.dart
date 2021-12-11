import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:land_registration/UserDashboard.dart';
import 'package:land_registration/constant/constants.dart';
import 'package:provider/provider.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'LandRegisterModel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

import 'constant/MetamaskProvider.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({Key? key}) : super(key: key);

  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  late String name, age, city, adharNumber, panNumber, document, email;

  double width = 590;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false, isAdded = false;
  String docuName = "";
  late PlatformFile documentFile;
  String cid = "", docUrl = "";

  pickDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf'],
    );

    if (result != null) {
      docuName = result.files.single.name;
      documentFile = result.files.first;
    }
    setState(() {});
  }

  Future<bool> uploadDocument() async {
    String url = "https://api.nft.storage/upload";
    var header = {
      "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJkaWQ6ZXRocjoweDJmNGUwQTQwNTI4MkMyMDNkZDBEZmY2NUNlMkUwRTYyQUNCODFDRWUiLCJpc3MiOiJuZnQtc3RvcmFnZSIsImlhdCI6MTYzNzkwNzQxNjEwNSwibmFtZSI6ImxhbmRfZG9jdW1lbnQifQ.5ReEuIxsDhWxOLa2lVe9n-B2PUjdEkwJ5jLsBGdBDGA"
    };

    if (docuName != "") {
      try {
        final response = await http.post(Uri.parse(url),
            headers: header, body: documentFile.bytes);
        var data = jsonDecode(response.body);
        //print(data);
        if (data['ok']) {
          cid = data["value"]["cid"];
          docUrl = "https://" + cid + ".ipfs.dweb.link";
          print(docUrl);
          return true;
        }
      } catch (e) {
        print(e);
        showToast("Something went wrong,while document uploading",
            context: context, backgroundColor: Colors.red);
      }
    } else {
      showToast("Choose Document",
          context: context, backgroundColor: Colors.red);
      return false;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<LandRegisterModel>(context);
    var model2 = Provider.of<MetaMaskProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF272D34),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'User Registration',
        ),
      ),
      body: Center(
        child: Material(
          elevation: 10,
          child: Container(
            padding: const EdgeInsets.all(15),
            width: width,
            child: Form(
              key: _formKey,
              child: Column(
                // scrollDirection: Axis.vertical,
                // shrinkWrap: true,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: TextFormField(
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      onChanged: (val) {
                        name = val;
                      },
                      decoration: const InputDecoration(
                        isDense: true, // Added this
                        contentPadding: EdgeInsets.all(12),
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                        hintText: 'Enter Name',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter age';
                        }
                        return null;
                      },
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                      onChanged: (val) {
                        age = val;
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                      ],
                      decoration: const InputDecoration(
                        isDense: true, // Added this
                        contentPadding: EdgeInsets.all(12),
                        border: OutlineInputBorder(),
                        labelText: 'Age',
                        hintText: 'Enter Age',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                      onChanged: (val) {
                        city = val;
                      },
                      //obscureText: true,
                      decoration: const InputDecoration(
                        isDense: true, // Added this
                        contentPadding: EdgeInsets.all(12),
                        border: OutlineInputBorder(),
                        labelText: 'City',
                        hintText: 'Enter City',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Adhar number';
                        } else if (value.length != 12)
                          return 'Please enter Valid Adhar number';
                        return null;
                      },
                      //maxLength: 12,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                      ],
                      onChanged: (val) {
                        adharNumber = val;
                      },
                      //obscureText: true,
                      decoration: const InputDecoration(
                        isDense: true, // Added this
                        contentPadding: EdgeInsets.all(12),
                        border: OutlineInputBorder(),
                        labelText: 'Adhar',
                        hintText: 'Enter Adhar Number',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Pan Number';
                        } else if (value.length != 10)
                          return 'Please enter Valid Adhar number';
                        return null;
                      },
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                      //maxLength: 10,

                      onChanged: (val) {
                        panNumber = val;
                      },
                      //obscureText: true,
                      decoration: const InputDecoration(
                        isDense: true, // Added this
                        contentPadding: EdgeInsets.all(12),
                        border: OutlineInputBorder(),
                        labelText: 'Pan',
                        hintText: 'Enter Pan Number',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        MaterialButton(
                          color: Colors.grey,
                          onPressed: pickDocument,
                          child: Text('Upload Document'),
                        ),
                        Text(docuName)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      validator: (value) {
                        RegExp regex = RegExp(
                            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                            r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                            r"{0,253}[a-zA-Z0-9])?)*$");
                        if (!regex.hasMatch(value!) || value == null)
                          return 'Enter a valid email address';
                        else
                          return null;
                      },
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                      onChanged: (val) {
                        email = val;
                      },
                      //obscureText: true,
                      decoration: const InputDecoration(
                        isDense: true, // Added this
                        contentPadding: EdgeInsets.all(12),
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        hintText: 'Enter Email',
                      ),
                    ),
                  ),
                  isAdded
                      ? CustomButton('Contine to Login', () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserDashBoard()));
                        })
                      : CustomButton(
                          'Add',
                          isLoading
                              ? null
                              : () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    try {
                                      SmartDialog.showLoading(
                                          msg: "Uploading Document");
                                      bool isFileupload =
                                          await uploadDocument();
                                      SmartDialog.dismiss();
                                      if (isFileupload) {
                                        if (connectedWithMetamask)
                                          await model2.registerUser(
                                              name,
                                              age,
                                              city,
                                              adharNumber,
                                              panNumber,
                                              docUrl,
                                              email);
                                        else
                                          await model.registerUser(
                                              name,
                                              age,
                                              city,
                                              adharNumber,
                                              panNumber,
                                              docUrl,
                                              email);
                                        showToast("Successfully Registered",
                                            context: context,
                                            backgroundColor: Colors.green);
                                        isAdded = true;
                                      }
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
                  isLoading ? CircularProgressIndicator() : Container()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
