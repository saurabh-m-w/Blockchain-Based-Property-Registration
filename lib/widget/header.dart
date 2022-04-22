import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:land_registration/constant/constants.dart';
import 'package:universal_html/html.dart' as html;
import '../constant/utils.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  static final appContainer = kIsWeb
      ? html.window.document.querySelectorAll('flt-glass-pane')[0]
      : null;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        // logo
        const Text(
          'Land Registry',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: InkWell(
                child: MouseRegion(
                  onHover: (PointerHoverEvent evt) {
                    appContainer?.style.cursor = 'pointer';
                  },
                  onExit: (PointerExitEvent evt) {
                    appContainer?.style.cursor = 'default';
                  },
                  child: const Text(
                    'Home',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Color(0xff28313b),
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      letterSpacing: 1.627907,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const CheckPrivateKey(
                  //               val: "UserLogin",
                  //             )));
                  Navigator.of(context).pushNamed(
                    '/login',
                    arguments: "UserLogin",
                  );
                },
                child: MouseRegion(
                  onHover: (PointerHoverEvent evt) {
                    appContainer?.style.cursor = 'pointer';
                  },
                  onExit: (PointerExitEvent evt) {
                    appContainer?.style.cursor = 'default';
                  },
                  child: const Text(
                    'User',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Color(0xff28313b),
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      letterSpacing: 1.627907,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const CheckPrivateKey(
                  //               val: "LandInspector",
                  //             )));
                  Navigator.of(context).pushNamed(
                    '/login',
                    arguments: "LandInspector",
                  );
                },
                child: MouseRegion(
                  onHover: (PointerHoverEvent evt) {
                    appContainer?.style.cursor = 'pointer';
                  },
                  onExit: (PointerExitEvent evt) {
                    appContainer?.style.cursor = 'default';
                  },
                  child: const Text(
                    'Land Inspector',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Color(0xff28313b),
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      letterSpacing: 1.627907,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const CheckPrivateKey(
                  //               val: "owner",
                  //             )));
                  Navigator.of(context).pushNamed(
                    '/login',
                    arguments: "owner",
                  );
                },
                child: MouseRegion(
                  onHover: (PointerHoverEvent evt) {
                    appContainer?.style.cursor = 'pointer';
                  },
                  onExit: (PointerExitEvent evt) {
                    appContainer?.style.cursor = 'default';
                  },
                  child: const Text(
                    'Contract Owner',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Color(0xff28313b),
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      letterSpacing: 1.627907,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: GestureDetector(
                onTap: () async {
                  // await Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => RegisterUser()));
                },
                child: MouseRegion(
                  onHover: (PointerHoverEvent evt) {
                    appContainer?.style.cursor = 'pointer';
                  },
                  onExit: (PointerExitEvent evt) {
                    appContainer?.style.cursor = 'default';
                  },
                  child: const Text(
                    'About',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Color(0xff28313b),
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      letterSpacing: 1.627907,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: IconButton(
                onPressed: () {
                  launchUrl(
                      "https://github.com/saurabh-m-w/Blockchain-Based-Property-Registration");
                },
                iconSize: 30,
                icon: Image.asset(
                  'assets/github-logo.png',
                  color: Colors.black,
                  width: 60.0,
                  height: 60.0,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
