import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import '../About/about.dart';
import '../Widgets/navBar.dart';
import '../Update/update.dart';
import '../Help/help.dart';

class Home extends StatefulWidget{
  @override
  Home({
    super.key,
});

  @override
  HomeState createState() => HomeState();

}

class HomeState extends State<Home>{

  // Pages
  late About about;

  // NavBar
  late NavBar homeNavBar;

  // Device specs
  String deviceModel = "";
  String deviceManufacturer = "";
  String deviceBoard = "";
  String deviceHardware = "";
  String deviceBootloader = "";
  String deviceVersion = "";
  String deviceSecurityPatch = "";
  String deviceROM = '';


  // Variables
  late String model;
  String targetVersion = "";
  String targetModel = "";
  String targerJsonFile = "";
  String jsonStirng = "";
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  late AndroidDeviceInfo j5Model;
  String currentDevice = "";
  List<String> lineageVersion = ["LineageOS 18.1", "LineageOS 19.1", "LineageOS 20.0"];
  List<String> lineageRender = ['assets/images/eleven.png', 'assets/images/twelve.png', 'assets/images/thirteen.png'];
  Map <dynamic, dynamic> modelJson = {
    "LineageOS 18.1": {
      "j53g" : "https://raw.githubusercontent.com/Galaxy-J5-Unofficial-LineageOS-Sources/OTA-Updates/lineage-18.1/j53g.json",
      "j53gxx" : "https://raw.githubusercontent.com/Galaxy-J5-Unofficial-LineageOS-Sources/OTA-Updates/lineage-18.1/j53gxx.json",
      "j5lte" : "https://raw.githubusercontent.com/Galaxy-J5-Unofficial-LineageOS-Sources/OTA-Updates/lineage-18.1/j5lte.json",
      "j5ltechn" : "https://raw.githubusercontent.com/Galaxy-J5-Unofficial-LineageOS-Sources/OTA-Updates/lineage-18.1/j5ltechn.json",
      "j5ltedo" : "https://raw.githubusercontent.com/Galaxy-J5-Unofficial-LineageOS-Sources/OTA-Updates/lineage-18.1/j5ltedo.json",
      "j5ltedx" : "https://raw.githubusercontent.com/Galaxy-J5-Unofficial-LineageOS-Sources/OTA-Updates/lineage-18.1/j5ltedx.json",
      "j5ltekx" : "https://raw.githubusercontent.com/Galaxy-J5-Unofficial-LineageOS-Sources/OTA-Updates/lineage-18.1/j5ltekx.json",
      "j5lteub" : "https://raw.githubusercontent.com/Galaxy-J5-Unofficial-LineageOS-Sources/OTA-Updates/lineage-18.1/j5lteub.json",
      "j5ltexx" : "https://raw.githubusercontent.com/Galaxy-J5-Unofficial-LineageOS-Sources/OTA-Updates/lineage-18.1/j5ltexx.json",
      "j5ltezm" : "https://raw.githubusercontent.com/Galaxy-J5-Unofficial-LineageOS-Sources/OTA-Updates/lineage-18.1/j5ltezm.json",
      "j5ltezt" : "https://raw.githubusercontent.com/Galaxy-J5-Unofficial-LineageOS-Sources/OTA-Updates/lineage-18.1/j5ltezt.json",
      "j5nlte" : "https://raw.githubusercontent.com/Galaxy-J5-Unofficial-LineageOS-Sources/OTA-Updates/lineage-18.1/j5nlte.json",
      "j5nltetxx" : "https://raw.githubusercontent.com/Galaxy-J5-Unofficial-LineageOS-Sources/OTA-Updates/lineage-18.1/j5nltexx.json",
      "j5xlte" : "https://raw.githubusercontent.com/Galaxy-J5-Unofficial-LineageOS-Sources/OTA-Updates/lineage-18.1/j5xlte.json",
      "j5xnlte" : "https://raw.githubusercontent.com/Galaxy-J5-Unofficial-LineageOS-Sources/OTA-Updates/lineage-18.1/j5xnlte.json",
      "j5ylte" : "https://raw.githubusercontent.com/Galaxy-J5-Unofficial-LineageOS-Sources/OTA-Updates/lineage-18.1/j5ylte.json",
    },

    "LineageOS 19.1" : {
      "j53g" : "https://raw.githubusercontent.com/Galaxy-J5-Unofficial-LineageOS-Sources/OTA-Updates/lineage-19.0/j53g.json",
      "j53gxx" : "https://raw.githubusercontent.com/Galaxy-J5-Unofficial-LineageOS-Sources/OTA-Updates/lineage-19.0/j53gxx.json",
      "j5lte" : "https://raw.githubusercontent.com/Galaxy-J5-Unofficial-LineageOS-Sources/OTA-Updates/lineage-19.0/j5lte.json",
      "j5ltechn" : "https://raw.githubusercontent.com/Galaxy-J5-Unofficial-LineageOS-Sources/OTA-Updates/lineage-19.0/j5ltechn.json",
      "j5ltedo" : "https://raw.githubusercontent.com/Galaxy-J5-Unofficial-LineageOS-Sources/OTA-Updates/lineage-19.0/j5ltedo.json",
      "j5ltedx" : "https://raw.githubusercontent.com/Galaxy-J5-Unofficial-LineageOS-Sources/OTA-Updates/lineage-19.0/j5ltedx.json",
      "j5ltekx" : "https://raw.githubusercontent.com/Galaxy-J5-Unofficial-LineageOS-Sources/OTA-Updates/lineage-19.0/j5ltekx.json",
      "j5lteub" : "https://raw.githubusercontent.com/Galaxy-J5-Unofficial-LineageOS-Sources/OTA-Updates/lineage-19.0/j5lteub.json",
      "j5ltexx" : "https://raw.githubusercontent.com/Galaxy-J5-Unofficial-LineageOS-Sources/OTA-Updates/lineage-19.0/j5ltexx.json",
      "j5ltezm" : "https://raw.githubusercontent.com/Galaxy-J5-Unofficial-LineageOS-Sources/OTA-Updates/lineage-19.0/j5ltezm.json",
      "j5ltezt" : "https://raw.githubusercontent.com/Galaxy-J5-Unofficial-LineageOS-Sources/OTA-Updates/lineage-19.0/j5ltezt.json",
      "j5nlte" : "https://raw.githubusercontent.com/Galaxy-J5-Unofficial-LineageOS-Sources/OTA-Updates/lineage-19.0/j5nlte.json",
      "j5nltetxx" : "https://raw.githubusercontent.com/Galaxy-J5-Unofficial-LineageOS-Sources/OTA-Updates/lineage-19.0/j5nltexx.json",
      "j5xlte" : "https://raw.githubusercontent.com/Galaxy-J5-Unofficial-LineageOS-Sources/OTA-Updates/lineage-19.0/j5xlte.json",
      "j5xnlte" : "https://raw.githubusercontent.com/Galaxy-J5-Unofficial-LineageOS-Sources/OTA-Updates/lineage-19.0/j5xnlte.json",
      "j5ylte" : "https://raw.githubusercontent.com/Galaxy-J5-Unofficial-LineageOS-Sources/OTA-Updates/lineage-19.0/j5ylte.json",
    },

    "LineageOS 20.0" : {
      "j53g" : "https://raw.githubusercontent.com/Galaxy-J5-Unofficial-LineageOS-Sources/OTA-Updates/lineage-20.0/j53g.json",
      "j53gxx" : "https://raw.githubusercontent.com/Galaxy-J5-Unofficial-LineageOS-Sources/OTA-Updates/lineage-20.0/j53gxx.json",
      "j5lte" : "https://raw.githubusercontent.com/Galaxy-J5-Unofficial-LineageOS-Sources/OTA-Updates/lineage-20.0/j5lte.json",
      "j5ltechn" : "https://raw.githubusercontent.com/Galaxy-J5-Unofficial-LineageOS-Sources/OTA-Updates/lineage-20.0/j5ltechn.json",
      "j5ltedo" : "https://raw.githubusercontent.com/Galaxy-J5-Unofficial-LineageOS-Sources/OTA-Updates/lineage-20.0/j5ltedo.json",
      "j5ltedx" : "https://raw.githubusercontent.com/Galaxy-J5-Unofficial-LineageOS-Sources/OTA-Updates/lineage-20.0/j5ltedx.json",
      "j5ltekx" : "https://raw.githubusercontent.com/Galaxy-J5-Unofficial-LineageOS-Sources/OTA-Updates/lineage-20.0/j5ltekx.json",
      "j5lteub" : "https://raw.githubusercontent.com/Galaxy-J5-Unofficial-LineageOS-Sources/OTA-Updates/lineage-20.0/j5lteub.json",
      "j5ltexx" : "https://raw.githubusercontent.com/Galaxy-J5-Unofficial-LineageOS-Sources/OTA-Updates/lineage-20.0/j5ltexx.json",
      "j5ltezm" : "https://raw.githubusercontent.com/Galaxy-J5-Unofficial-LineageOS-Sources/OTA-Updates/lineage-20.0/j5ltezm.json",
      "j5ltezt" : "https://raw.githubusercontent.com/Galaxy-J5-Unofficial-LineageOS-Sources/OTA-Updates/lineage-20.0/j5ltezt.json",
      "j5nlte" : "https://raw.githubusercontent.com/Galaxy-J5-Unofficial-LineageOS-Sources/OTA-Updates/lineage-20.0/j5nlte.json",
      "j5nltetxx" : "https://raw.githubusercontent.com/Galaxy-J5-Unofficial-LineageOS-Sources/OTA-Updates/lineage-20.0/j5nltexx.json",
      "j5xlte" : "https://raw.githubusercontent.com/Galaxy-J5-Unofficial-LineageOS-Sources/OTA-Updates/lineage-20.0/j5xlte.json",
      "j5xnlte" : "https://raw.githubusercontent.com/Galaxy-J5-Unofficial-LineageOS-Sources/OTA-Updates/lineage-20.0/j5xnlte.json",
      "sdk_gphone64_x86_64" : "https://raw.githubusercontent.com/Galaxy-J5-Unofficial-LineageOS-Sources/OTA-Updates/lineage-20.0/j5ylte.json",
    },
  };

  @override
  void initState() async{
    j5Model = await deviceInfo.androidInfo;
    targetModel = j5Model.model;
    aboutDeviceSpecs();
    homeNavBar = NavBar();
    initializeNavBar();
    super.initState();
  }

  initializeNavBar() {
    setState(() {
      about = About(model: this.deviceModel, manufacturer: this.deviceManufacturer, platform: this.deviceBoard, chipMaker: this.deviceHardware, version: this.deviceVersion, securityPatch: this.deviceSecurityPatch, bootloader: this.deviceBootloader,);
    });
  }

  checkDeviceModel(){
    // This method will assign the current device model into a variable
     setState(() {
       targerJsonFile = modelJson[targetVersion][targetModel];
     });
    }

    aboutDeviceSpecs(){
    // This method will return current device OS details
      deviceModel = j5Model.model;
      deviceManufacturer = j5Model.manufacturer;
      deviceBoard = j5Model.board;
      deviceHardware = j5Model.hardware;
      deviceVersion = j5Model.version.release;
      deviceROM = j5Model.version.baseOS!;
      deviceSecurityPatch = j5Model.version.securityPatch!;
      deviceBootloader = j5Model.bootloader;

      print("""
      Model : ${deviceModel}
      Manufacturer : ${deviceManufacturer}
      Board : ${deviceBoard}
      Hardware : ${deviceHardware}
      Version : ${deviceVersion}
      ROM : ${deviceROM};
      Security Patch : ${deviceSecurityPatch}
      Bootloader : ${deviceBootloader}
      """);

    }

  checkForUpdates(String lineageOSVersion) {
    // This method will receive the choosed lineageOS versions as an input
    // Also will determine the device model on real time
    // Will return a download link of the choosed version and device

    for (String version in modelJson.keys) {
      if (lineageOSVersion == version) {
        // We found the candidate version
        // Let's check device model
        setState(() async {
          targetVersion = lineageOSVersion;
          checkDeviceModel();
          openDialog(lineageOSVersion);
        });
      }
    }
  }

  openDialog(String version){
    Navigator.push(context,
    MaterialPageRoute(builder: (context) => Update(state: true, version: version, targetJson: targerJsonFile,)));
  }


  Expanded phonesView(BuildContext context){
    // This ListView will let users choose a desired android version and download the latest available release
    return Expanded(
        child: GridView.builder(
          gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
          scrollDirection: Axis.horizontal,
        itemCount: lineageVersion.length,
        itemBuilder: (context, index) {
          return Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {

                    },
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                        bottomLeft: Radius.circular(24),
                        bottomRight: Radius.circular(24),),
                      child: Card(
                        shadowColor: Colors.black,
                        color: const Color.fromRGBO(22, 124, 128, 100),
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView(
                            scrollDirection: Axis.vertical,
                            children : [
                            Image.asset(
                              lineageRender[index], width: 150, height: 200,),
                            const SizedBox(height: 25,),
                            Align(
                              child: Text(lineageVersion[index],
                                style: const TextStyle(color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),),
                            ),

                            const SizedBox(height: 25,),

                            TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: const Color.fromRGBO(32, 38, 38, 100)
                                ),
                                onPressed: () {
                                  // Check what's the current card version
                                  checkForUpdates(lineageVersion[index]);
                                },
                                child: const Text("Check Updates",
                                  style: TextStyle(color: Colors.white),))]))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ]
          );
        }
          ),
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
        title: Row(
          children: [
            // This row will contain a button at the end to show relevant help information on display
            Spacer(),
            IconButton(
                onPressed: (){
                 Navigator.push(context,
                     MaterialPageRoute(builder: (context) => Help(about: about,)));
                },
                icon: Icon(Icons.help_outline_rounded, color: Colors.white,))
          ],
        ),
      ),
      body: Column(
        children: [
          // Banner



          ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(24),
              topLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
              bottomLeft: Radius.circular(24),
            ),
          child : ColoredBox(
            color: Colors.black,
          child : Image.asset("assets/icon/banner_home.png"))),
          const SizedBox(height: 50,),
          phonesView(context),
          homeNavBar.NavigationBar(context, about, "home"),
        ],
      ),
    );
  }}