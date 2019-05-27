import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;




class Check extends StatefulWidget{
  @override
  _Check createState() => _Check();
}

class _Check extends State<Check> {
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
   _startFind(){
    print("uhull");
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
}}