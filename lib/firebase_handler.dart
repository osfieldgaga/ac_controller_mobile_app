import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_svg/flutter_svg.dart';

const deviceID = "TnOEDs0xzk29y6vlTNVhfA";

class FirebaseHandler {
  // final String email;
  // final String password;

//FirebaseHandler({required this.email, required this.password});

  final firebaseDatabase = FirebaseDatabase.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref(deviceID);

  void setTemperature({required temperature}) async {
    await ref.update({
      "temperature": temperature,
    });

    Fluttertoast.showToast(
        msg: "changed temp",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  // Widget? readHumidity() {
  //   DatabaseReference humRef =
  //       FirebaseDatabase.instance.ref(deviceID + '/parameters/room_humidity');
  //   StreamBuilder(
  //       stream: humRef.onValue,
  //       builder: (context, snapshot) {
  //         if (snapshot.hasData) {
  //           return ;
  //         } else {
  //           return Container();
  //         }
  //       });
  // }

  void changeState({required state}) async {
    await ref.update({
      "state": state,
    });
  }

  void changeOperationMode({required opMode}) async {
    await ref.update({
      "operation_mode": opMode,
    });
  }

  static Future<String> signIn(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Fluttertoast.showToast(
          msg: "Signed in",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }
}
