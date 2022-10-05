import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:school_project_ac_controller/configuration.dart';
import 'package:school_project_ac_controller/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'firebase_handler.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

String wifiName = "";

class _SettingsPageState extends State<SettingsPage> {
  final Future<SharedPreferences> _preferences =
      SharedPreferences.getInstance();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    returnWifiName();
  }

  void returnWifiName() async {
    final SharedPreferences preferences = await _preferences;
    wifiName = preferences.getString(wifiName).toString();
  }

  FirebaseHandler firebaseHandler = new FirebaseHandler();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(color: Colors.grey[900]),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            "Settings",
            style: TextStyle(
              color: Colors.grey[900],
              fontFamily: 'Euclid',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.0),
        child: Center(
          child: Column(
            children: <Widget>[
              // SvgPicture.asset(
              //   'assets/icons/wifi.svg',
              //   semanticsLabel: 'on/off',
              //   color: Color(0xFF00A3FF),
              // ),
              // const SizedBox(
              //   height: 8,
              // ),
              // Text(
              //   "Connected to",
              //   style: TextStyle(color: Colors.grey[500], fontFamily: 'Euclid'),
              // ),
              // Text(
              //   wifiName,
              //   style: TextStyle(color: Colors.grey[500], fontFamily: 'Euclid'),
              // ),
              SizedBox(
                height: 32.0,
              ),
              Text(
                "Change device configuration",
                style: kTitle_textStyle,
              ),
              SizedBox(
                height: 8.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Text(
                  "Changing configuration will reset the device, click the button to contiue\n\nTurn OFF the device first, click the button then turn it ON again.",
                  style: kNormalText,
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: ElevatedButton(
                  
                  style: ButtonStyle(
                    
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                        //side: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                  onPressed: ()  {
firebaseHandler.resetDevice();

                    Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              const ConfigurationPage(),
                        ),
                      );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                    child: Center(
                      child: Row(
                        children: <Widget>[
                          Center(
                            child: Text(
                              "Change configuration",
                              style: kRoundedButton_textStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.center,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
