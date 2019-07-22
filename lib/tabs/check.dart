import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:necronomicon/model/class.dart';




class Check extends StatefulWidget{
  @override
  _Check createState() => _Check();
}
String _className = "";

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
  double _myOpacity = 1.0;
  bool _showCard = false;
  double _successOpacity = 0.0;

bool canCheckBiometric = false;
  List<BiometricType> _availableBiometrics = List<BiometricType>();
  @override
  void initState(){
    super.initState();

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

  void _showDialog() async{
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 5), () {

          setState(() {
            _showCard = true;
            Class c =  new Class(title: "Data Sctructure",semester: 2,days: "Mon",faults: 0.3);
            _className = c.title;

          });
          Navigator.of(context).pop(true);
        });


        // return object of type Dialog
        return AlertDialog(
          title: new Text("Finding NFC TAG"),
          content: new Text("Waiting..."),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _makeCard(){
    return Center(
      child: Card(
        child: Column(
          //mainAxisSize: MainAxisSize.min,
          children: <Widget>[
             ListTile(
              leading: Icon(Icons.album),
              title: Text(_className),
              subtitle: Text('Teacher: Novak Djokovic'),
            ),
            ButtonTheme.bar( // make buttons use the appropriate styles for cards
              child: ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      setState(() {
                        _myOpacity = 0.0;
                        _showCard = false;
                      });
                    },
                  ),
                  FlatButton(
                    child: const Text('Confirm'),
                    onPressed: () { _checkBiometrics(); },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              Visibility(
                visible: _showCard,
                child:
                  Container(
                        child: Column(
                          children: <Widget>[
                            _makeCard()
                          ],
                        ),
                      ),
              ),
            AnimatedOpacity(
                opacity: _successOpacity,
                duration: Duration(milliseconds: 300) ,
                child:
                      Container(
                        margin: EdgeInsets.only(top: 60.0),
                          child: Column(

                            children: <Widget>[

                              Image.asset('assets/images/ok.png', height: 200.0, width: 200.0,),
                              Text("Success",
                                style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize:30.0),),
                            ],

                          )
                      )),
            ],
          ),

        ),
      ),

      floatingActionButton: FloatingActionButton(onPressed: _showDialog,
        child: Icon(Icons.add),
      ),

    );



  }

  Future<void> _checkBiometrics() async {
    try {
      var authenticate = await _localAuth.authenticateWithBiometrics(
          localizedReason: 'Please, put your fingerprint to continue');
      setState(() {
        if (authenticate) {
          _showCard = false;
          _successOpacity = 1.0;
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

  Future<void> _ackAlert(BuildContext context) {

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
