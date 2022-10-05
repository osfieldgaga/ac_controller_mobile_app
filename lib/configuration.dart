import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:school_project_ac_controller/firebase_handler.dart';
import 'const.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'firebase_handler.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigurationPage extends StatefulWidget {
  const ConfigurationPage({super.key});

  @override
  State<ConfigurationPage> createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  String dropdownvalue = '- Choose AC Brand -';

  // List of items in our dropdown menu
  var items = [
    '- Choose AC Brand -',
    'Airton',
    'Amcor',
    'Argo',
    'Carrier',
    'Coolix',
    'Corona',
    'Delonghi',
    'Fujitsu',
    'Ecoclim',
    'Electra',
    'Goodweather',
    'Gree',
    'Hitachi',
    'Kelvinator',
    'LG',
    'Midea',
    'Mirage',
    'Mistsubishi',
    'Neoclima',
    'Panasonic',
  'Rhoss',
  'Smasung',
  'Sanyo',
  'Sharp',
  'TCL',
  'Technibel',
  'Teco',
  'Toshiba',
  'Transcold',
  'Trotec',
  'Truma',
  'Vestel',
  'Voltas',
    // 'Item 4',
    // 'Item 5',
  ];

  void connectBT() async {
    // Some simplest connection :F
  }

  FirebaseHandler firebaseHandler = new FirebaseHandler();

  bool sendConfigError = false;
  bool circularProgressVisible = false;
  final wifiNameController = TextEditingController();
  final wifiPasswordController = TextEditingController();
  String acBrandString = "";
  String wifiConfig = "";
  String configSent = "";
  bool textFieldEmpty = false;

  final Future<SharedPreferences> _preferences =
      SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            "Configure device",
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
            child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 16,
              ),
              Text(
                "Enter Wi-Fi credentials",
                style: kTitle_textStyle,
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                controller: wifiNameController,
                decoration: InputDecoration(
                    labelText: "Wi-Fi name",
                    labelStyle: kTextFieldLabel_textStyle),
                style: kTextField_textStyle,
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                controller: wifiPasswordController,
                decoration: InputDecoration(
                    labelText: "Wi-Fi password",
                    labelStyle: kTextFieldLabel_textStyle),
                style: kTextField_textStyle,
              ),
              Visibility(
                visible: textFieldEmpty,
                child: Text(
                  "Please fill in the credentials",
                  style: kErrorText,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Text(
                "Set AC Brand",
                style: kTitle_textStyle,
              ),
              const SizedBox(
                height: 16,
              ),
              DropdownButtonFormField(
                decoration: InputDecoration(
                    labelText: "AC Brand",
                    labelStyle: kTextFieldLabel_textStyle),
                style: kTextField_textStyle,
                value: dropdownvalue,
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    if (newValue != "- Choose AC Brand -") {
                      dropdownvalue = newValue!;
                      acBrandString = newValue;
                    }
                  });
                },
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                      //side: BorderSide(color: Colors.red),
                    ),
                  ),
                ),
                onPressed: () async {
                  setState(() {
                    if (!(wifiNameController.text.length > 0) |
                        !(wifiPasswordController.text.length > 0)) {
                      textFieldEmpty = true;
                    } else {
                      circularProgressVisible = true;
                    }
                  });
                  try {
                    if ((wifiNameController.text.length > 0) |
                        (wifiPasswordController.text.length > 0)) {
                      BluetoothConnection connection =
                          await BluetoothConnection.toAddress(
                              "0C:B8:15:F8:A7:2A");
                      print('Connected to the device');
                      wifiConfig = "sid:" +
                          wifiNameController.text +
                          "\$" +
                          "pass:" +
                          wifiPasswordController.text;

                      connection!.output
                          .add(Uint8List.fromList(utf8.encode(wifiConfig)));
                      await connection!.output.allSent;

                      firebaseHandler.sendAcConfig(config: acBrandString);
                      print(wifiConfig);
                      setState(() {
                        sendConfigError = false;
                        configSent = "Configuration sent!";
                        circularProgressVisible = false;
                        if ((wifiNameController.text.length > 0) |
                            (wifiPasswordController.text.length > 0)) {
                          textFieldEmpty = false;
                        }
                      });

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              const Dashboard(title: 'Smart AC Controller'),
                        ),
                      );
                    }
                  } catch (exception) {
                    print('Cannot connect, exception occured');

                    setState(() {
                      sendConfigError = true;
                      circularProgressVisible = false;
                      textFieldEmpty = false;
                    });
                  }
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                  child: Row(
                    children: <Widget>[
                      Center(
                        child: Text(
                          "Configure Device",
                          style: kRoundedButton_textStyle,
                        ),
                      ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Visibility(
                child: CircularProgressIndicator(),
                visible: circularProgressVisible,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  sendConfigError == true
                      ? "Couldn't send configuration, turn OFF and ON the device and try again."
                      : configSent,
                  style: sendConfigError == true ? kErrorText : kSuccessText,
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
