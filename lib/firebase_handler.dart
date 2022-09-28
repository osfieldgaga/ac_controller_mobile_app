import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_database/firebase_database.dart';


const deviceID = "TnOEDs0xzk29y6vlTNVhfA";

class FirebaseHandler {
  // final String email;
  // final String password;

//FirebaseHandler({required this.email, required this.password});



final firebaseDatabase = FirebaseDatabase.instance;
DatabaseReference ref = FirebaseDatabase.instance.ref(deviceID);

void setTemperature ({required temperature}) async {
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

void changeState ({required state}) async {
  await ref.update({
    "state": state,
  });
}

void changeOperationMode ({required opMode}) async {
  await ref.update({
    "operation_mode": opMode,
  });
}

static Future<String> signIn({required String email, required String password}) async {
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