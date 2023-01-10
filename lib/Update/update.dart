import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import '../Download/download.dart';
import '../About/about.dart';
import '../Download/downloadScreen.dart';

class Update extends StatefulWidget {
  Update({
    required this.state,
    required this.version,
    required this.targetJson,
    super.key,
});

  final bool state;
  final String version;
  final String targetJson;

  @override
  UpdateState createState() => UpdateState(state: this.state, version: this.version, targetJson: this.targetJson);

}

class UpdateState extends State<Update> {
  UpdateState({
    required this.state,
    required this.version,
    required this.targetJson,
  });

  DownloadState download = DownloadState(about: About(model: "", manufacturer: "", platform: "", chipMaker: "", version: "", securityPatch: "", bootloader: ""));
  late DownloadScreen downloadScreen;

  final String targetJson;
  late Directory output;
  late Directory subdir;
  final bool state;
  final String version;
  String targetVersion = "";
  String changelog = "";
  String jsonFileName = "";
  String filename = "";
  List<String> changelogLines = [];
  List<Color> changelogColors = [];
  Color green = Colors.blueAccent;
  Color red = Colors.pinkAccent;
  Map<dynamic,dynamic> jsonDecoded = {};
  late File targetFile;
  String jsonString = "";
  bool downloading = false;
  String min = "121";
  String max = "240";
  List<String> animationImages = [];
  
  void initState() async {
    await downloadChangelog();
    super.initState();
  }

  chooseVersion() {
    // Retrieve current version number into a variable
    if (version.contains("18.1")) {
      setState(() {
        targetVersion = "18.1";
      });
    } else if (version.contains("19.1")) {
      setState(() {
        targetVersion = "19.1";
      });
    } else if (version.contains("20.0")) {
      setState(() {
        targetVersion = "20.0";
      });
    };
  }

  removeFile() async{
    // This method is used a file that already exists
    if (File("sdcard/download/changelog.txt").existsSync()){
      File("sdcard/download/changelog.txt").deleteSync();
    }
  }

  downloadChangelog() async {
    // This dialog shows up when a new update is available
   await chooseVersion();
   print(targetVersion);
   await removeFile();

    // This method is used to download latest changelog if a new update is found
    String url = "https://raw.githubusercontent.com/Galaxy-J5-Unofficial-LineageOS-Sources/OTA-Updates/lineage-$targetVersion/changelog.txt";
    final download = await FlutterDownloader.enqueue(
      url: url,
      savedDir: "sdcard/download/",
      showNotification: true,
      openFileFromNotification: true,);

    while (!File("sdcard/download/changelog.txt").existsSync()){
      await download;
    }
   if (File("sdcard/download/changelog.txt").existsSync())
   readChangelog();
  }

  String getFileName(String url) {
    // In a full url string, the filename is placed after the last '/' character
    // Save this string into a variable for later operations
    String filename = "";
    int count = 0;

    // Get the count of all "/" characters
    for (String char in url.characters){
      if (char.contains("/")){
        count ++;
      }
    }

    int second_count = 0;

    // Get the filename
    for (String char in url.characters){
      if (char.contains("/")){
        second_count ++;
      }
      if (second_count == count){
        // Time to save filename into a variable
        setState(() {
          if (char != "\n" && char != "/" && char != " ") {
            filename += char;
          }
        });
      }
    }

    return filename;


  }

  removeJson() async {
    // Before downloading a new file check that no file with the same name exists
    setState(() {
      targetFile = File("sdcard/download/$jsonFileName");
    });

    if (targetFile.existsSync()){
      // Time to remove a file
      targetFile.deleteSync();
    }
  }

  decodeJson() async {
    // This method is used to save the download JSON content into a HashMap
     if (await File("sdcard/download/$jsonFileName").existsSync()){
       jsonString = targetFile.readAsStringSync(); // Read as string
       jsonDecoded = jsonDecode(jsonString); // Decode as JSON and save into a HashMap
       downloadFile();
    } else {
       // Force to load the file, this will take some time
       decodeJson();
     }

     print(jsonDecoded);
  }

  downloadJson() async {
    setState(() {
      jsonFileName = getFileName(targetJson);
    });

    await removeJson();
    final download = await FlutterDownloader.enqueue(
      url: targetJson,
      savedDir: "sdcard/download/",
      showNotification: true,
      openFileFromNotification: true,);

    decodeJson(); // Decode file only if exists
  }

  initializeDownloadsDirectory() async {
    // To download files into the device, we need a specific folder to contain all downloads
    // This folder will have a structure since it will be accessible to everyone
    String ver = version.replaceAll("LineageOS ", "");
    ver = version.replaceAll("", "_");
    ver = version.replaceAll(".", "_");

    setState(() {
      output = Directory("sdcard/download/j5Downloader"); // This path is constant
      subdir = Directory("${output.path}/$ver");
    });

    if (!output.existsSync()){
      // Create folder
      output.createSync();
    }

    if (!subdir.existsSync()){
      // Create folder
      subdir.createSync();
    }
  }

  replaceFile(String url, String path) async {
    // Remove uncompleted downloads or trash files on device external storage
    while(filename.isEmpty){
      setState((){
        filename = getFileName(url);
      });
    }

    if (File("$path/$filename").existsSync()){
      // Already exists. Time to delete it
      File("$path/$filename").deleteSync();
    }
  }

  addDownloadToMap() async{
    // Add new download to list if doesn't exist
    download.addDownloadToList(filename, subdir.path);
  }

  downloadFile() async {
    print("descargando");
    // Let download the ROM file into the device
    await initializeDownloadsDirectory(); // Await output folder creation if needed
    await replaceFile(jsonDecoded["response"]["url"], subdir.path); // Don't allow to download duplicated files
    final lineageBuild = await FlutterDownloader.enqueue(
        url: jsonDecoded["response"]["url"],
        savedDir: subdir.path,
      showNotification: true,
      openFileFromNotification: true,);
    setState(() async {
      await lineageBuild;
      downloading = false;
      addDownloadToMap();
    });
  }

  setColorStates() async {
    // This method is used to assign a color to every changelog line
    for (String line in changelog.split("\n")) {
      if (line.contains("new")) {
        setState(() {
          changelogColors.add(green);
        });
      } else if (line.contains("fix")) {
        setState(() {
          changelogColors.add(red);
        });
      } else {
        changelogColors.add(Colors.black);
      }
    }

    print(changelogColors.length);
    print(changelogLines.length);
  }

  splitChangelog(String changelog) async{
    // This method will split the changelog into separated lines
    for (String line in changelog.split("\n")){
      setState(() async {
        if (line.length > 1 && !changelogLines.contains(line)) // This is used to prevent empty & duplicated lines
        changelogLines.add(line);
      });
    }
    print(changelogLines);
    setColorStates();
  }

  readChangelog() async {
    setState(() async {
      changelog = File("sdcard/download/changelog.txt").readAsStringSync();
      if(changelogLines.isEmpty)
      await splitChangelog(changelog);
    });
  }

  getBootanimationEntries(){
    // Since we've a folder with all bootanimation images
    // We need to add the images into a list of images before loading it on user screen

    int count  = int.parse(min);

    while(count < int.parse(max)){
      // Max number of availables images
      animationImages.add("assets/animation/00$count.png");
      count ++;
    }

    print(animationImages);


  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: [
            if(state)
            Expanded(
              child : Column (
                  children: [

                    // Banner
                    Image.asset("assets/icon/banner_updateFound.png"),
                    SizedBox(height: 20,),

                    // Changelog
                    Align(
                      alignment : Alignment.center,
                    child : Column(
                      children: [
                        Text("Changelog", style: TextStyle(
                            color: Color.fromRGBO(22, 124, 128, 100),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),),
                        ])),
                        SizedBox(height: 20,),
                        Expanded(
                            child: ListView.builder(
                            itemCount: changelogLines.length ,
                            itemBuilder: (context, index){
                              return InkWell(
                                onTap: (){
                                  // Empty action to enable highlight on press
                                },
                                  child : Card(
                                color: changelogColors[index],
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text(changelogLines[index], textAlign: TextAlign.center, style : TextStyle(
                                          color: Colors.white, fontSize: 15)),
                                    )
                                  ],
                                ),
                              )
                              );
                            }
                        ),
                        ),
                      SizedBox(height: 50,),
                      ]

                    )
                    ),
                    // Button
                  TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Color.fromRGBO(
                                  22, 124, 128, 100)
                          ),
                          onPressed: () {
                            // Download desired file for user
                            downloadJson();
                            setState(() {
                              downloading = true;
                              getBootanimationEntries();
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => DownloadScreen(animations: animationImages, version: version,)));
                            });
                          },
                          child: Text("Download",
                            style: TextStyle(color: Colors.white),))
                  ]

                )
            );
    }
  }