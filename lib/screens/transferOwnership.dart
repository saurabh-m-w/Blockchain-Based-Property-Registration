import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:land_registration/constant/constants.dart';
import 'package:land_registration/providers/LandRegisterModel.dart';
import 'package:land_registration/providers/MetamaskProvider.dart';
import 'package:land_registration/widget/land_container.dart';
import 'package:provider/provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import '../constant/utils.dart';

class transferOwnership extends StatefulWidget {
  final String buyerAdd;
  final String sellerAdd;
  final String landId;
  final String reqId;
  final List<CameraDescription> cameraList;
  const transferOwnership({
    Key? key,
    required this.buyerAdd,
    required this.sellerAdd,
    required this.landId,
    required this.reqId,
    required this.cameraList,
  }) : super(key: key);

  @override
  _transferOwnershipState createState() => _transferOwnershipState();
}

class _transferOwnershipState extends State<transferOwnership> {
  List<dynamic> sellerInfo = ['', '', '', '', '', '', '', '', '', '', ''];
  List<dynamic> buyerInfo = ['', '', '', '', '', '', '', '', '', '', ''];
  List<dynamic> landInfo = ['', '', '', '', '', '', '', '', '', '', ''];
  var model, model2;
  bool isFirstTimeLoad = true, isLoading = true;
  late CameraController controller, controller2, controller3;
  XFile? pictureFile;
  late Uint8List sellerPictureBytes, buyerPictureBytes, witnessPictureBytes;
  bool isSellerpicturetaken = false,
      isBuyerpicturetaken = false,
      isWitnesspicturetaken = false;
  bool cameraInilizing = true, isOwnershipTransfered = false;
  final pdf = pw.Document();
  String witnessName = "", witnessAge = "", witnessAddress = "";
  late List<CameraDescription> cameras;
  String documentId = "", docUrl = "";

  @override
  Future<void> dispose() async {
    await controller.dispose();
    super.dispose();
  }

  Future<void> uploadDocument(bytes) async {
    String url = "https://api.nft.storage/upload";
    var header = {"Authorization": "Bearer $nftStorageApiKey"};

    try {
      final response =
          await http.post(Uri.parse(url), headers: header, body: bytes);
      var data = jsonDecode(response.body);
      //print(data);
      if (data['ok']) {
        var cid = data["value"]["cid"];
        docUrl = "https://" + cid + ".ipfs.dweb.link";
        print(docUrl);
      }
    } catch (e) {
      print(e);
      showToast("Something went wrong,while document uploading",
          context: context, backgroundColor: Colors.red);
    }
  }

  generateDocument(villegename, price, sellername, buyername, selleraddress,
      buyeraddress, surveyno, area, date, sellerpan, buyerpan) async {
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Center(
                  child: pw.Text('Index No. 2'),
                ),
                pw.SizedBox(height: 10),
                pw.Divider(),
                pw.Center(
                  child: pw.Text('Villege Name: ' + villegename),
                ),
                pw.Divider(),
                pw.SizedBox(height: 14),
                pw.Table(columnWidths: {
                  1: const pw.FractionColumnWidth(0.8),
                  2: const pw.FractionColumnWidth(0.2),
                }, children: [
                  tableRow("1)Type of Document:", "Sale Deed"),
                  tableRowSizedBox(),
                  tableRow("2)Compensation:", price),
                  tableRowSizedBox(),
                  tableRow("3)Market Price:", price),
                  tableRowSizedBox(),
                  tableRow("4)Survey No.:", surveyno),
                  tableRowSizedBox(),
                  tableRow("5)Area:", area),
                  tableRowSizedBox(),
                  tableRow(
                      "6)Seller Name and Address:",
                      sellername +
                          ',' +
                          selleraddress +
                          ',Pan no.:' +
                          sellerpan),
                  tableRowSizedBox(),
                  tableRow("7)Buyer name and Address",
                      buyername + ',' + buyeraddress + ',Pan no.:' + buyerpan),
                  tableRowSizedBox(),
                  tableRow("8)Document written Date:", date),
                  tableRowSizedBox(),
                  tableRow("9)Document Registrtion Date:", date),
                  tableRowSizedBox(),
                  tableRow("10)Stamp Duty paid amount:", "Rs6000"),
                  tableRowSizedBox(),
                  tableRow("11)Registration Serial No.:", "613"),
                  tableRowSizedBox(),
                  tableRow("12)Registration Fee:", "Rs.5000"),
                  tableRowSizedBox(),
                ]),
                pw.Divider(height: 2),
                pw.Divider(height: 2),
                pw.SizedBox(height: 14),
                pw.Text("Paragraph selected for stamp duty: "),
              ]); // Center
        })); // Page

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(date),
                      pw.Text('Document Abstract'),
                      pw.Text('Document No.:' + documentId),
                    ]),
                pw.Divider(),
                pw.Text('Type of Document: Sale Deed'),
                pw.Text('Document No.:' + documentId),
                pw.Divider(),
                pw.Table(columnWidths: {
                  0: const pw.FractionColumnWidth(0.3),
                  1: const pw.FractionColumnWidth(0.1),
                  2: const pw.FractionColumnWidth(0.1),
                  3: const pw.FractionColumnWidth(0.4),
                }, children: [
                  pw.TableRow(children: [
                    pw.Text("Name:" +
                        sellername +
                        "\nAddress:" +
                        selleraddress +
                        "\nPan:" +
                        sellerpan),
                    pw.Text("Seller"),
                    pw.Text("Sign: "),
                    pw.Container(
                        child: pw.Image(pw.MemoryImage(sellerPictureBytes),
                            height: 150, width: 265)),
                  ]),
                  pw.TableRow(children: [
                    pw.SizedBox(height: 10),
                    pw.SizedBox(height: 10),
                    pw.SizedBox(height: 10),
                    pw.SizedBox(height: 10)
                  ]),
                  pw.TableRow(children: [
                    pw.Text("Name:" +
                        buyername +
                        "\nAddress:" +
                        buyeraddress +
                        "\nPan:" +
                        buyerpan),
                    pw.Text("Buyer"),
                    pw.Text("Sign: "),
                    pw.Container(
                        child: pw.Image(pw.MemoryImage(buyerPictureBytes),
                            height: 150, width: 265)),
                  ]),
                  pw.TableRow(children: [
                    pw.SizedBox(height: 5),
                    pw.SizedBox(height: 5),
                    pw.SizedBox(height: 5),
                    pw.SizedBox(height: 5)
                  ]),
                  pw.TableRow(children: [
                    pw.Divider(),
                    pw.Divider(),
                    pw.Divider(),
                    pw.Divider()
                  ]),
                  pw.TableRow(children: [
                    pw.SizedBox(height: 5),
                    pw.SizedBox(height: 5),
                    pw.SizedBox(height: 5),
                    pw.SizedBox(height: 5)
                  ]),
                  pw.TableRow(children: [
                    pw.Text("Name:" +
                        witnessName +
                        "\nAddress:" +
                        witnessAddress +
                        "\nAge:" +
                        witnessAge),
                    pw.Text("Witness"),
                    pw.Text("Sign: "),
                    pw.Container(
                        child: pw.Image(pw.MemoryImage(witnessPictureBytes),
                            height: 150, width: 265)),
                  ]),
                ]),
                pw.Text("Timestamp: " + date)
              ]);
        }));

    var data = await pdf.save();
    Uint8List bytes = Uint8List.fromList(data);
    await uploadDocument(bytes);

    /// final blob = html.Blob([bytes], 'application/pdf');
    /// final url = html.Url.createObjectUrlFromBlob(blob);
    // final anchor = html.document.createElement('a') as html.AnchorElement
    //   ..href = url
    //   ..style.display = 'none'
    //   ..download = 'some_name.pdf';
    /// html.window.open(url, "_blank");
    // html.document.body!.children.add(anchor);
    // anchor.click();
    // html.document.body!.children.remove(anchor);
    // html.Url.revokeObjectUrl(url);
  }

  getProfileInfo() async {
    isFirstTimeLoad = false;
    if (connectedWithMetamask) {
      sellerInfo = await model2.userInfo(widget.sellerAdd);
    } else
      sellerInfo = await model.userInfo(widget.sellerAdd);

    if (connectedWithMetamask)
      buyerInfo = await model2.userInfo(widget.buyerAdd);
    else
      buyerInfo = await model.userInfo(widget.buyerAdd);

    if (connectedWithMetamask)
      landInfo = await model2.landInfo(BigInt.parse(widget.landId));
    else
      landInfo = await model.landInfo(BigInt.parse(widget.landId));

    if (connectedWithMetamask)
      documentId = await model2.documentId();
    else
      documentId = await model.documentId();

    //cameras = await availableCameras();

    controller = CameraController(widget.cameraList[0], ResolutionPreset.max,
        enableAudio: false);

    controller.initialize().then((_) {
      cameraInilizing = false;
      if (!mounted) {
        return;
      }
      setState(() {});
    });
    isLoading = false;
    setState(() {});
  }

  Future<bool> transferOwnershipFunction() async {
    try {
      if (connectedWithMetamask)
        await model2.transferOwnership(widget.reqId, docUrl);
      else
        await model.transferOwnership(BigInt.parse(widget.reqId), docUrl);
      // await paymentDoneList();
      showToast("Ownership Transfered",
          context: context,
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3));
      isOwnershipTransfered = true;
      return true;
    } catch (e) {
      print(e);
      showToast("Something Went Wrong",
          context: context,
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3));
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    model = Provider.of<LandRegisterModel>(context);
    model2 = Provider.of<MetaMaskProvider>(context);
    if (isFirstTimeLoad) {
      getProfileInfo();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transfer Ownership"),
        centerTitle: true,
        backgroundColor: const Color(0xFF272D34),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      sellerProfile(
                          "Seller Profile",
                          sellerInfo[0],
                          sellerInfo[1],
                          sellerInfo[2],
                          sellerInfo[3],
                          sellerInfo[4],
                          sellerInfo[5],
                          sellerInfo[6],
                          sellerInfo[7]),
                      buyerProfile(
                          "Buyer Profile",
                          buyerInfo[0],
                          buyerInfo[1],
                          buyerInfo[2],
                          buyerInfo[3],
                          buyerInfo[4],
                          buyerInfo[5],
                          buyerInfo[6],
                          buyerInfo[7]),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      landWid3(
                        landInfo[9].toString(),
                        landInfo[1].toString(),
                        landInfo[2],
                        landInfo[3].toString(),
                        landInfo[5].toString(),
                        landInfo[6].toString(),
                        landInfo[7].toString(),
                      ),
                      takeWitnessInfo()
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (isOwnershipTransfered)
                    const Text("Successfully Transferred",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                  const SizedBox(
                    height: 8,
                  ),
                  if (isOwnershipTransfered)
                    MaterialButton(
                      onPressed: () {
                        launchUrl(docUrl);
                      },
                      child: const Text(
                        'View Document',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomButton(
                      "Transfer",
                      isOwnershipTransfered
                          ? null
                          : () async {
                              if (isBuyerpicturetaken &&
                                  isSellerpicturetaken &&
                                  isWitnesspicturetaken &&
                                  witnessName != "" &&
                                  witnessAge != "" &&
                                  witnessAddress != "") {
                                SmartDialog.showLoading(msg: "Please Wait");
                                await generateDocument(
                                    landInfo[2],
                                    landInfo[3].toString(),
                                    sellerInfo[1],
                                    buyerInfo[1],
                                    sellerInfo[3],
                                    buyerInfo[3],
                                    landInfo[6].toString(),
                                    landInfo[1].toString(),
                                    DateTime.now().toString(),
                                    sellerInfo[5],
                                    buyerInfo[5]);
                                //SmartDialog.dismiss();
                                //SmartDialog.showLoading(msg: "please wait");
                                bool temp = await transferOwnershipFunction();
                                SmartDialog.dismiss();
                                setState(() {});
                                //await Duration(seconds: 1);
                                //if (temp) launchUrl(docUrl);
                              } else {
                                showToast("Complete All the details",
                                    context: context,
                                    backgroundColor: Colors.red);
                              }
                            }),
                  const SizedBox(
                    height: 14,
                  ),
                ],
              ),
            ),
    );
  }

  Widget takeWitnessInfo() {
    return Container(
      width: width,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          //color: Color(0xFFBb3b3cc),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all()),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Enter Witness Info",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Container(
                  height: 200,
                  width: 265,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                  ),
                  child: isBuyerpicturetaken
                      ? (!isWitnesspicturetaken
                          ? CameraPreview(controller)
                          : Image.memory(witnessPictureBytes))
                      : const Center(child: Text('Capture Witness Photo'))),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    pictureFile = await controller.takePicture();
                    witnessPictureBytes = await pictureFile!.readAsBytes();
                    isWitnesspicturetaken = true;
                    await controller.dispose();
                    setState(() {});
                  },
                  child: const Text('Capture Photo'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (val) {
                  witnessName = val;
                },
                style: const TextStyle(
                  fontSize: 15,
                ),
                decoration: const InputDecoration(
                    isDense: true, // Added this
                    contentPadding: EdgeInsets.all(12),
                    border: OutlineInputBorder(),
                    labelText: "Name",
                    labelStyle: TextStyle(fontSize: 20),
                    fillColor: Colors.white,
                    filled: true),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (val) {
                  witnessAge = val;
                },
                style: const TextStyle(
                  fontSize: 15,
                ),
                decoration: const InputDecoration(
                    isDense: true, // Added this
                    contentPadding: EdgeInsets.all(12),
                    border: OutlineInputBorder(),
                    labelText: "Age",
                    labelStyle: TextStyle(fontSize: 20),
                    fillColor: Colors.white,
                    filled: true),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (val) {
                  witnessAddress = val;
                },
                style: const TextStyle(
                  fontSize: 15,
                ),
                decoration: const InputDecoration(
                    isDense: true, // Added this
                    contentPadding: EdgeInsets.all(12),
                    border: OutlineInputBorder(),
                    labelText: "Address",
                    labelStyle: TextStyle(fontSize: 20),
                    fillColor: Colors.white,
                    filled: true),
              ),
            ),
          ]),
    );
  }

  Widget sellerProfile(
      sellerOrBuyer, walletAddres, name, age, city, adhar, pan, docu, mail) {
    //if (isLoading) return CircularProgressIndicator();

    return Container(
      width: width,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          //color: Color(0xFFBb3b3cc),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all()),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sellerOrBuyer,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Row(
            children: const [
              Text(
                'Verified',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
              ),
              Icon(
                Icons.verified,
                color: Colors.green,
              )
            ],
          ),
          Center(
            child: Container(
              height: 200,
              width: 265,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: const BorderRadius.all(Radius.circular(6)),
              ),
              child: !isSellerpicturetaken
                  ? CameraPreview(controller)
                  : Image.memory(sellerPictureBytes),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  pictureFile = await controller.takePicture();

                  sellerPictureBytes = await pictureFile!.readAsBytes();
                  isSellerpicturetaken = true;
                  await controller.dispose();
                  controller = await CameraController(
                      widget.cameraList[0], ResolutionPreset.max,
                      enableAudio: false);
                  await controller.initialize();

                  setState(() {});
                },
                child: const Text('Capture Photo'),
              ),
            ),
          ),
          CustomTextFiled(walletAddres.toString(), 'Wallet Address'),
          CustomTextFiled(name.toString(), 'Name'),
          CustomTextFiled(age.toString(), 'Age'),
          CustomTextFiled(city.toString(), 'City'),
          CustomTextFiled(adhar.toString(), 'Adhar Number'),
          CustomTextFiled(pan.toString(), 'Pan'),
          TextButton(
            onPressed: () {
              launchUrl(docu.toString());
            },
            child: const Text(
              '  View Document',
              style: TextStyle(color: Colors.blue),
            ),
          ),
          CustomTextFiled(mail.toString(), 'Mail'),
        ],
      ),
    );
  }

  Widget buyerProfile(
      sellerOrBuyer, walletAddres, name, age, city, adhar, pan, docu, mail) {
    //if (isLoading) return CircularProgressIndicator();

    return Container(
      width: width,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          //color: Color(0xFFBb3b3cc),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all()),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sellerOrBuyer,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Row(
            children: const [
              Text(
                'Verified',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
              ),
              Icon(
                Icons.verified,
                color: Colors.green,
              )
            ],
          ),
          Center(
            child: Container(
              height: 200,
              width: 265,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: const BorderRadius.all(Radius.circular(6)),
              ),
              child: isSellerpicturetaken
                  ? (!isBuyerpicturetaken
                      ? CameraPreview(controller)
                      : Image.memory(buyerPictureBytes))
                  : const Center(child: Text('Capture Buyer Photo')),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  pictureFile = await controller.takePicture();

                  buyerPictureBytes = await pictureFile!.readAsBytes();
                  isBuyerpicturetaken = true;
                  await controller.dispose();
                  controller = await CameraController(
                      widget.cameraList[0], ResolutionPreset.max,
                      enableAudio: false);
                  await controller.initialize();

                  setState(() {});
                },
                child: const Text('Capture Photo'),
              ),
            ),
          ),
          CustomTextFiled(walletAddres.toString(), 'Wallet Address'),
          CustomTextFiled(name.toString(), 'Name'),
          CustomTextFiled(age.toString(), 'Age'),
          CustomTextFiled(city.toString(), 'City'),
          CustomTextFiled(adhar.toString(), 'Adhar Number'),
          CustomTextFiled(pan.toString(), 'Pan'),
          TextButton(
            onPressed: () {
              launchUrl(docu.toString());
            },
            child: const Text(
              '  View Document',
              style: TextStyle(color: Colors.blue),
            ),
          ),
          CustomTextFiled(mail.toString(), 'Mail'),
        ],
      ),
    );
  }
}
