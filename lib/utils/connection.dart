import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectionUtility {
  static late StreamSubscription subscription;

  static bool connected = true;

  // write code to check internet connection, the bool connected should keep changing according to the internet connection
  static void init() {
    subscription = Connectivity().onConnectivityChanged.listen((event) async {
      connected = await InternetConnectionChecker().hasConnection;

      if (connected) {
        Fluttertoast.showToast(
          msg: "Connected to the internet",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        Fluttertoast.showToast(
          msg: "No internet connection",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    });
  }

  static void dispose() {
    subscription.cancel();
  }
}
