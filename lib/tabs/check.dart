import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';



class Check extends StatefulWidget{
  @override
  _Check createState() => _Check();
}

class _Check extends State<Check> {
  final LocalAuthentication auth = LocalAuthentication();
  String _authorized = "Not Authorized";
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            new RaisedButton(
              onPressed: () {

                //_ackAlert(context);
                _checkBiometrics();
              },
              child: const Text("Ack Dialog"),
            ),
            new Text("Auth: $_authorized")
          ],
        ),
      ),
    );

  }
  Future<void> _checkBiometrics() async {
    bool authed = false;
    try {
      authed = await auth.authenticateWithBiometrics(
          localizedReason: 'Scan your fingerprint to authenticate',
          useErrorDialogs: true,
          stickyAuth: false);
    } on PlatformException catch (e) {
      print(e);
    }
  }


}

Future<void> _ackAlert(BuildContext context) {

  return  showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      /*Future.delayed(Duration(seconds: 5), () {
        Navigator.of(context).pop(true);
      });
      */

      return AlertDialog(
        title: Text('Finding Nfc Tag'),
        content: const Text('Please wait..'),
        actions: <Widget>[
          FlatButton(

            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}