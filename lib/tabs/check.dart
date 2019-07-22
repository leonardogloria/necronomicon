import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;




class Check extends StatefulWidget{
  @override
  _Check createState() => _Check();
}

class _Check extends State<Check> {

  void initState() {
    super.initState();
    _showDialog();
  }

  _showDialog() async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Finding NFC Tag"),
          content: new Text("Waiting"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  final LocalAuthentication _localAuth = LocalAuthentication();
  String _authorized = "Not Authorized";
  bool canCheckBiometric = false;
  List<BiometricType> _availableBiometrics = List<BiometricType>();

  Future<void> _canCheckBiometrics() async{
    bool _canCheck = false;
    try{
      _canCheck = await _localAuth.canCheckBiometrics;

    }on PlatformException catch(e){
      print(e);
    }
    if(!mounted) return;
    setState(() {
        canCheckBiometric = true;
    });


  }
  void _showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Wifi"),
          content: Text("Wifi not detected. Please activate it."),
        )
    );
  }
  Widget _makeFindingBox(){
    return new Card(

      child: new Text("Get your device close to nfc tag"),
    );
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      body: new Stack(
        children: <Widget>[
         _makeFindingBox()
        ],
      )
    );


    

  }
  Future<void> _checkBiometrics() async {
    try {
      var authenticate = await _localAuth.authenticateWithBiometrics(
          localizedReason: 'Please, put your fingerprint to continue');
      setState(() {
        if (authenticate) {
          _authorized = "Autorized";
        } else {

        }
      });
    }on PlatformException catch (e) {
      if (e.code == auth_error.notAvailable) {
        print('Nao funcionou');
      }
    }


}
  _checkNfcTag() async {
    print('Uhull');
    _showAlert(context);
  }

  Future<void> _ackAlert(BuildContext context) async {

  return  showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      Future.delayed(Duration(seconds: 5), () {
        Navigator.of(context).pop(true);
      });


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
}}