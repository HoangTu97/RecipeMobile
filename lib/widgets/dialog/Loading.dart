import 'package:flutter/material.dart';

class LoadingDialog {
  static void show(BuildContext context, String msg) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        child: Container(
          color: Colors.white,
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(msg, style: TextStyle(fontSize: 18)),
              )
            ],
          ),
        ),
      ),
    );
  }

  static void hide(BuildContext context) {
    Navigator.of(context).pop(LoadingDialog());
  }
}
