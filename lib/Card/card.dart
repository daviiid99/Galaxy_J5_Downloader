import 'dart:io';

import 'package:flutter/material.dart';

class Cards extends StatelessWidget{
  // This class will be used to create random cards on usen interface with the given parameters
  Cards({
    required this.image,
    required this.title,
    required this.description,
});
  final String image;
  final String title;
  final String description;

  cardDialog(BuildContext context){
    // This widget will show a alert dialog

    return showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            backgroundColor: Colors.black,
            content: ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(24),
                topLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
                bottomLeft: Radius.circular(24),
              ),
              child : ColoredBox(
              color: Colors.transparent.withOpacity(0.5),
              child : SizedBox(
                height: 400,
              child: Column(
                children: [
                  Expanded(
                      child: ListView(
                        children: [
                          // Banner
                          Image.asset(image),

                          // Title
                          Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30), textAlign: TextAlign.center,),
                          SizedBox(height: 50,),

                          // Description
                          Text(description, style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
                          SizedBox(height: 20,),

                          //Button
                          TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor:  const Color.fromRGBO(22, 124, 128, 100),
                            ),
                              onPressed: (){
                              Navigator.pop(context);
                              },
                              child: Text("Close", style: TextStyle(color: Colors.white),))
                        ],
                      ))
                  // Title
                ],
              ),
            )
          )
            ),
          );
    }
    );
  }

  @override
  Widget build(BuildContext context){
    throw exitCode;
  }
}