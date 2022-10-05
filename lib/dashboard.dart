import 'package:flutter/material.dart';
import 'package:school_project_ac_controller/settings.dart';
import 'firebase_handler.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
//import 'package:iosstyleswitch/iosstyleswitch.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  double sliderTemp = 25.0;
  bool operationMode = false;
  bool acState = false;

  final firebanseHandler = FirebaseHandler();

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
            widget.title,
            style: TextStyle(
              color: Colors.grey[900],
              fontFamily: 'Euclid',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      body: //StreamBuilder(
          //stream: FirebaseAuth.instance.authStateChanges(),
          //builder: (context, snapshot) {
          //if (snapshot.hasData) {
          /* return*/ Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 32.0,
          vertical: 32.0,
        ),
        child: Center(
          child: Stack(children: <Widget>[
            //SvgPicture.asset('assets/bg.svg'),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 32,
                  ),
                  Transform.scale(
                    scale: 1.5,
                    child: SleekCircularSlider(
                        min: 20,
                        max: 30,
                        initialValue: 24,
                        appearance: CircularSliderAppearance(
                            customWidths: CustomSliderWidths(
                                handlerSize: 10, progressBarWidth: 10),
                            customColors: CustomSliderColors(
                              trackColor: Color(0xFFE9F7FF),
                              progressBarColors: [
                                Color(0xFF00A3FF),
                                Color(0xFF74CDFF)
                              ],
                              dotColor: Color(0xFF00A3FF),
                              hideShadow: true,
                            )),
                        innerWidget: (double value) {
                          return Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  value.toInt().toString(),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 32,
                                      fontFamily: 'Euclid',
                                      fontWeight: FontWeight.w700),
                                ),
                                const Text("°C",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontFamily: 'Euclid',
                                        fontWeight: FontWeight.w700))
                              ],
                            ),
                          );
                        },
                        onChange: (double value) {
                          print(value);
                        },
                        onChangeEnd: (double endValue) {
                          // ucallback providing an ending value (when a pan gesture ends)
                          setState(() {
                            sliderTemp = endValue;
                            firebanseHandler.setTemperature(
                                temperature: endValue.toInt());
                          });
                        }),
                  ),

                  SvgPicture.asset(
                    operationMode == true
                        ? 'assets/icons/Lock.svg'
                        : 'assets/icons/Unlock.svg',
                    semanticsLabel: 'on/off',
                    color: Color(0xFF00A3FF),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    operationMode == true
                        ? 'Cannot change temperature in auto mode'
                        : '',
                    style: TextStyle(
                        color: Colors.grey[500], fontFamily: 'Euclid'),
                  ),

                  // Text(
                  //   'Temperature',
                  //   style: TextStyle(color: Colors.grey[500]),
                  // ),
                  // const SizedBox(
                  //   height: 16,
                  // ),
                  // Text(
                  //   sliderTemp.toInt().toString(),
                  //   style: const TextStyle(
                  //     fontSize: 32,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 16,
                  // ),
                  // Slider(
                  //   divisions: 14,
                  //   value: sliderTemp,
                  //   onChanged: (newValue) {
                  //     setState(() {
                  //       sliderTemp = newValue;
                  //       firebanseHandler.setTemperature(temperature: newValue);
                  //     });
                  //   },
                  //   min: 16,
                  //   max: 30,
                  // ),
                  const SizedBox(
                    height: 16,
                  ),

                  Text(
                    'Operation Mode',
                    style: TextStyle(
                        color: Colors.grey[500], fontFamily: 'Euclid'),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    operationMode == true ? "Automatic Mode" : "Manual Mode",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontFamily: 'Euclid',
                        fontWeight: FontWeight.w400),
                  ),
                  Transform.scale(
                    scale: 1.3,
                    child: Switch(
                      value: operationMode,
                      onChanged: (newOperationMode) {
                        setState(() {
                          operationMode = newOperationMode;
                          firebanseHandler.changeOperationMode(
                              opMode: newOperationMode);
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            'Settings',
                            style: TextStyle(
                                color: Colors.grey[500], fontFamily: 'Euclid'),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(60, 60),
                                  shape: const CircleBorder(),
                                  backgroundColor: Colors.white,
                                  elevation: 5),
                              onPressed: () {
                                setState(() {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => const SettingsPage(),
                                    ),
                                  );
                                });
                              },
                              child: Transform.scale(
                                scale: 1.3,
                                child: SvgPicture.asset(
                                    'assets/icons/settings.svg',
                                    semanticsLabel: 'on/off'),
                              )),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            "",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: 'Euclid',
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            'AC State',
                            style: TextStyle(
                                color: Colors.grey[500], fontFamily: 'Euclid'),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(60, 60),
                                  shape: const CircleBorder(),
                                  backgroundColor: Colors.white,
                                  elevation: 5),
                              onPressed: () {
                                setState(() {
                                  acState = !acState;
                                  firebanseHandler.changeState(
                                      state: acState == true ? 1 : 0);
                                });
                              },
                              child: Transform.scale(
                                scale: 1.3,
                                child: SvgPicture.asset(
                                    'assets/icons/Turn-off.svg',
                                    semanticsLabel: 'on/off'),
                              )),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            acState == true ? "Turn Off AC" : "Turn On AC",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: 'Euclid',
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    'Stats',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Euclid',
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              SvgPicture.asset('assets/icons/drop.svg'),
                              const SizedBox(
                                height: 4,
                              ),
                              const Text("--",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: 'Euclid',
                                      fontWeight: FontWeight.w700)),
                              const Text("Air humidity",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'Euclid',
                                      fontWeight: FontWeight.w200)),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          SvgPicture.asset('assets/icons/thermometer.svg'),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            children: const <Widget>[
                              Text("--",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: 'Euclid',
                                      fontWeight: FontWeight.w700)),
                              Text("°C",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'Euclid',
                                      fontWeight: FontWeight.w700))
                            ],
                          ),
                          const Text(
                            "Outside\nTemperature",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Euclid',
                                fontWeight: FontWeight.w200),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ]),
        ),
      ),
      // } else {
      //   return const Center(
      //     child: CircularProgressIndicator(
      //       color: Colors.cyan,
      //     ),
      //   );
      // }
    );
  }
}
