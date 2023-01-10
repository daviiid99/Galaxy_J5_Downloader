import 'package:flutter/material.dart';

class DownloadScreen extends StatefulWidget{
  // We need a way to notify user about download state without compromise device performance
  // We'll display LineageOS logo bootanimation instead of a percentage while the download is active

  DownloadScreen({
    super.key,
    required this.animations,
    required this.version,

});

  final List<String> animations;
  final String version;

  @override
  DownloadScreenState createState() => DownloadScreenState(animations: this.animations, version: this.version);
}

class DownloadScreenState extends State<DownloadScreen>{

  DownloadScreenState({
    required this.animations,
    required this.version,
});

  final List<String> animations;
  final String version;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView(
               children: [

                // Banner
                Image.asset("assets/animation/00241.png"),
                 SizedBox(height: 50,),

                 // Title
                Text("Downloading $version...", style : TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25), textAlign: TextAlign.center,),
                SizedBox(height: 20,),
                Text("Don't close this window until the operation is completed", style: TextStyle(color: Colors.white, fontSize: 15), textAlign: TextAlign.center,),

               ],
      )
          )
        ],
      ),
    );
  }
}