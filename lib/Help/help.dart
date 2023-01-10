import 'package:flutter/material.dart';
import '../Widgets/navBar.dart';
import '../About/about.dart';
import '../Card/card.dart';

class Help extends StatefulWidget{
  Help({
  required this.about,
});

  final About about;
  @override
  HelpState createState()=> HelpState(about: about);
}

class HelpState extends State<Help>{
  HelpState({
   required this.about,
});

  List<String> questions = ["What's LineageOS?", "Can this app update to latest android?", "Is this app compatible with my device?", "Is this app affiliated with LineageOS?"];
  List<String> images = [];
  List<String> descriptions = ["LineageOS is a open-source, community built fork of the android open source project. LineageOS is maintained by enthusiast and all of incoming are from donors", "This app can update to the current android versions supported by me, these versions are displayed on home screen", "This app is compatible with the whole family of Galaxy J5 Devices, this includes 2015 and 2016 models", "This app is NOT affiliated with LineageOS Team and the Lineag logo and brand is property of the lineageOS team"];
  NavBar navigationBar = NavBar();
  final About about;
  late Card createCard;

  void initState(){
    super.initState();
  }

  questionsView(){
    // This listview will show a list of the most commons questions to users
    return Expanded(
        child : ListView.builder(
      itemCount: questions.length,
        itemBuilder: (context, index){
        return InkWell(
          onTap: (){

          },
            child : Card(
          color: Colors.black,
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.trending_up_rounded, color: const Color.fromRGBO(22, 124, 128, 100),),
                title: Text(questions[index], style: TextStyle(color: Colors.white,),),

              )

            ],
          ),
        )
        );
    }
    )
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [

          Expanded(
            child : Column(
            children: [
              //Banner
              Image.asset("assets/icon/banner_help.png", height: 200, width: 400,),
              SizedBox(height: 20,),

              //Title
              Text("Frequent Questions", style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),

              // ListView
              questionsView(),

      ],
            )

          ),


          // NavBar
          navigationBar.NavigationBar(context, about, "help"),

        ],
      ),
    );
  }
}