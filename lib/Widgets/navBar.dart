import 'dart:io';
import 'package:flutter/material.dart';
import 'package:galaxy_j5_downloader/Download/download.dart';
import 'package:galaxy_j5_downloader/Home/home.dart';
import '../About/about.dart';

class NavBar extends StatelessWidget{
  // This widgets created a BottomNavigationBar to be widely used on all application pages
  // A call to this widget will return a navbar

  Stack NavigationBar(BuildContext context, About about, String previous) {
    return Stack(
        children: [
          BottomNavigationBar(
              backgroundColor: Colors.transparent,
              items: [
                BottomNavigationBarItem(
                    icon: IconButton(icon : Icon(Icons.home_rounded, color: Colors.white,), onPressed: (){
                      if (previous!="home"){
                        Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home()));
                      }
                    }), backgroundColor: Colors.transparent, label: ""),
                BottomNavigationBarItem(
                  icon: IconButton(icon : Icon(Icons.download_rounded, color: Colors.white,), onPressed: (){
                    if (previous!="downloads"){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Download(about: about,)));
                    }
                  }), backgroundColor: Colors.transparent, label: "",),
                BottomNavigationBarItem(
                    icon: IconButton(icon : Icon(Icons.info_rounded, color: Colors.white,), onPressed: (){
                      // Navigate to about device page
                      if (previous!="about"){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => about));
                      }

                    }), backgroundColor: Colors.transparent, label: "",),
              ]
          )]
    );
  }

  @override
  Widget build(BuildContext context){
    throw exit(0);

  }
}