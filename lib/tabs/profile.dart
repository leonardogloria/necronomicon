import 'package:flutter/material.dart';
class Profile extends StatelessWidget {
  final String name = "Rick Sanchez";
  Widget _buildCoverImage(Size screeSize){
    return Container(
      height: screeSize.height / 3.8,
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/wallpaper.png'),
            fit: BoxFit.cover,
          )),
    );
  }
  Widget _buildProfileImage(){
    return Center(
      child: Container(
        width: 140.0,
        height: 140.0,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/rick.png'),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(80.0),
            border: Border.all(
                color: Colors.white,
                width: 10.0
            )
        ),

      ),
    );
  }
  Widget _buildFullName(){
    TextStyle _nameTextStyle = TextStyle(

      color: Colors.black,
      fontSize: 28.0,
      fontWeight: FontWeight.w700,
    );
    return Text(
      "Rick Sanchez",
      style: _nameTextStyle ,
    );
  }


  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildCoverImage(screenSize),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: screenSize.height / 6.4,),
                  _buildProfileImage(),
                  _buildFullName()
                ],
              ) ,
            ),
          )
        ],
      ),
    );
  }

}
