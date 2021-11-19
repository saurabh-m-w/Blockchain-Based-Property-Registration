import 'package:flutter/material.dart';
import 'package:land_registration/LandInspectorDashboard.dart';
import 'package:land_registration/UserDashboard.dart';
import 'package:land_registration/addLandInspector.dart';
import 'package:land_registration/constant/constants.dart';
import 'package:land_registration/constant/loadingScreen.dart';
import 'package:land_registration/registerUser.dart';
import 'package:provider/provider.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'LandRegisterModel.dart';

class CheckPrivateKey extends StatefulWidget {
  final String val;
  const CheckPrivateKey({Key? key, required this.val}) : super(key: key);

  @override
  _CheckPrivateKeyState createState() => _CheckPrivateKeyState();
}

class _CheckPrivateKeyState extends State<CheckPrivateKey> {
  String privatekey = "";
  String errorMessage = "";
  bool isDesktop = false;
  double width = 590;
  bool _isObscure = true;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<LandRegisterModel>(context);
    width = MediaQuery.of(context).size.width;

    if (width > 600) {
      isDesktop = true;
      width = 590;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF272D34),
        title: const Text('Login'),
      ),
      body: Container(
        //width: 500,
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Container(
              width: width,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter private key';
                      }
                      return null;
                    },
                    obscureText: _isObscure,
                    onChanged: (val) {
                      privatekey = val;
                    },
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          icon: Icon(_isObscure
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          }),
                      border: const OutlineInputBorder(),
                      labelText: 'Private Key',
                      hintText: 'Enter Your PrivateKey',
                    ),
                  ),
                ),
              ),
            ),
            Text(
              errorMessage,
              style: const TextStyle(color: Colors.red),
            ),
            CustomButton(
                'Continue',
                isLoading
                    ? null
                    : () async {
                        if (_formKey.currentState!.validate()) {
                          privateKey = privatekey;
                          print(privateKey);
                          setState(() {
                            isLoading = true;
                          });
                          try {
                            await model.initiateSetup();

                            if (widget.val == "owner") {
                              bool temp =
                                  await model.isContractOwner(privatekey);
                              if (temp == false) {
                                setState(() {
                                  errorMessage = "You are not authrosied";
                                });
                              } else {
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AddLandInspector()));
                              }
                            } else if (widget.val == "RegisterUser") {
                              bool temp = await model.isUserregistered();
                              if (temp) {
                                setState(() {
                                  errorMessage = "You already registered";
                                });
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RegisterUser()));
                              }
                            } else if (widget.val == "LandInspector") {
                              bool temp =
                                  await model.isLandInspector(privatekey);
                              if (temp == false) {
                                setState(() {
                                  errorMessage = "You are not authrosied";
                                });
                              } else {
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LandInspector()));
                              }
                            } else if (widget.val == "UserLogin") {
                              bool temp = await model.isUserregistered();
                              if (temp == false) {
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RegisterUser()));
                              } else {
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UserDashBoard()));
                              }
                            }
                          } catch (e) {
                            print(e);
                            showToast("Something Went Wrong",
                                context: context, backgroundColor: Colors.red);
                          }
                          setState(() {
                            isLoading = false;
                          });
                        }
                      }),
            isLoading ? spinkitLoader : Container()
          ],
        ),
      ),
    );
  }
}
