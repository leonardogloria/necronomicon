import 'package:flutter/material.dart';
import 'package:necronomicon/model/class.dart';

class Classes extends StatefulWidget{
  @override
  _Classes createState() => _Classes();

}

class _Classes extends State<Classes> {
  List classes;
  @override
  void initState() {
    classes = getClasses();
    super.initState();
  }


  @override
  Widget build(BuildContext context){

    ListTile makeListTile(Class _class) => ListTile(
      contentPadding:
      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Container(
        padding: EdgeInsets.only(right: 12.0),
        decoration: new BoxDecoration(
            border: new Border(
                right: new BorderSide(width: 1.0, color: Colors.white24))),
        child: Icon(Icons.autorenew, color: Colors.white),
      ),
      title: Text(
        _class.title,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

      subtitle: Row(
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Container(
                // tag: 'hero',
                child: LinearProgressIndicator(
                    backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
                    value: _class.faults.toDouble(),
                    valueColor: AlwaysStoppedAnimation(Colors.red)),
              )),
          Expanded(
            flex: 4,
            child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(_class.days,
                    style: TextStyle(color: Colors.white))),
          )
        ],
      ),
      trailing:
      Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),

    );

    Card makeCard(Class _class) => Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: makeListTile(_class),
      ),
    );
    final makeBody = Container(
      // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: classes.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(classes[index]);
        },
      ),
    );
    return Scaffold(
      body: makeBody,
    );



  }
   List getClasses(){
    return [
      Class(
        title: "Data Sctructure",
        semester: 2,
        days: "Mon",
        faults: 0.3
      ),
      Class(
        title: "Algorithm",
        semester: 2,
        days: "Fry",
        faults: 0

      ),
      Class(
        title: "Networks",
        semester: 2,
        days: 'Mon - Tue',
        faults: 0.7

      )
    ];
  }
}