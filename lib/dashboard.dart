import 'package:flutter/material.dart';
import 'firebase_handler.dart';

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
      appBar: AppBar(
        title: Text(widget.title),
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
        child: Column(
          children: <Widget>[
            Text(
              'Temperature',
              style: TextStyle(color: Colors.grey[500]),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              sliderTemp.toInt().toString(),
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Slider(
              divisions: 14,
              value: sliderTemp,
              onChanged: (newValue) {
                setState(() {
                  sliderTemp = newValue;
                  firebanseHandler.setTemperature(temperature: newValue);
                });
              },
              min: 16,
              max: 30,
            ),
            const SizedBox(
              height: 32,
            ),
            Text(
              'Operation Mode',
              style: TextStyle(color: Colors.grey[500]),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              operationMode == true ? "Automatic" : "Manual",
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            Switch(
              value: operationMode,
              onChanged: (newOperationMode) {
                setState(() {
                  operationMode = newOperationMode;
                  firebanseHandler.changeOperationMode(opMode: newOperationMode);
                });
              },
            ),
            const SizedBox(
              height: 32,
            ),
            Text(
              'AC State',
              style: TextStyle(color: Colors.grey[500]),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              acState == true ? "ON" : "OFF",
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    acState = !acState;
                    firebanseHandler.changeState(state: acState == true ? 1 : 0);
                  });
                },
                child: Text(
                  acState == true ? "Turn AC OFF" : "Turn AC ON",
                  style: const TextStyle(),
                ))
          ],
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


