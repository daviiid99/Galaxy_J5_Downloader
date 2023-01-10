import 'package:flutter/material.dart';
import '../Widgets/navBar.dart';

class About extends StatefulWidget{
  const About({
    required this.model,
    required this.manufacturer,
    required this.platform,
    required this.chipMaker,
    required this.version,
    required this.securityPatch,
    required this.bootloader,
    super.key,
});

  final String model;
  final String manufacturer;
  final String platform;
  final String chipMaker;
  final String version;
  final String securityPatch;
  final String bootloader;

  @override
  AboutState createState() => AboutState(model : this.model, manufacturer : this.manufacturer, platform : this.platform, chipMaker : this.chipMaker, version : this.version, securityPatch : this.securityPatch, bootloader : this.bootloader);
}

class AboutState extends State<About>{

  AboutState({
    required this.model,
    required this.manufacturer,
    required this.platform,
    required this.chipMaker,
    required this.version,
    required this.securityPatch,
    required this.bootloader,
});

  late NavBar aboutNavBar;
  final String model;
  final String manufacturer;
  final String platform;
  final String chipMaker;
  final String version;
  final String securityPatch;
  final String bootloader;
  List<String> optionsTitle = [];
  List<String> optionsSubtitle = ["Codename", "Manufacturer", "Chipset platform", "Chipmaker", "android OS version", "Security Patch Level", "Bootloader"];
  List<IconData> optionsIcon = [Icons.phone_android_rounded, Icons.house_rounded, Icons.developer_board_rounded, Icons.developer_mode_rounded, Icons.android_rounded, Icons.security_rounded, Icons.flash_on_rounded ];
  String currentBanner = "";
  Map <dynamic, dynamic> androidOSBanner = {
    "11" : "assets/images/eleven.png",
    "12" : "assets/images/twelve.png",
    "13" : "assets/images/thirteen.png",
    "unknown" : "assets/images/unknown.png",
  };

  @override
  void initState(){
    optionsTitle = [model, manufacturer, platform, chipMaker, version, securityPatch, bootloader];
    AssignDeviceVersionBanner();
    aboutNavBar = NavBar();
    super.initState();
  }

  AssignDeviceVersionBanner() async {
    // This method reads current device androidOS versions and assigns a banner according to it

    for (String os in androidOSBanner.keys){
      // Check the proper banner
      if (os == version){
        setState(() {
          currentBanner = androidOSBanner[os];
        });
      }
    }

    if (currentBanner.isEmpty){
      // Not candidate version found
      setState(() {
        currentBanner = androidOSBanner["unknown"];
      });
    }
  }

  Expanded settingsList(BuildContext context) {
    // This method returns a list view with all device info

    return Expanded(
        child: ListView.builder(
            itemCount: optionsTitle.length,
            itemBuilder: (context, index) {
              return ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(24),
                    topLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                    bottomLeft: Radius.circular(24),
                  ),
                  child: InkWell(
                    onTap: (){
                      // Just to higlight selected card :)
                    },
              child : Card(
                    color: Colors.black26.withOpacity(0.2),
                    child: Row(
                      children: [
                        ListTile(
                          leading: Icon(optionsIcon[index],
                            color: Color.fromRGBO(22, 124, 128, 100),),
                          title: Text(optionsTitle[index], style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),),
                          subtitle: Text(optionsSubtitle[index],
                            style: TextStyle(color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),),
                        )
                      ],
                    ),
                  )
                  ),
              );
            }
    )
    );
  }




  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          // Banner
          ClipRRect(
          borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
      ),
          child : SizedBox(
          child : Image.asset(currentBanner))),

          SizedBox(height: 50,),

          // Device settings
          settingsList(context),

          // NavBar
          aboutNavBar.NavigationBar(context, About(model: model, manufacturer: manufacturer, platform: platform, chipMaker: chipMaker, version: version, securityPatch: securityPatch, bootloader: bootloader), "about"),
        ],
      ),
    );
  }
}