import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import '../Widgets/navBar.dart';
import '../About/about.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

class Download extends StatefulWidget{

  Download({
    required this.about,
   super.key,
});

  final About about;
  @override
  DownloadState createState() => DownloadState(about : this.about);
}

class DownloadState extends State<Download>{

  DownloadState({
    required this.about
});

  final About about;
  late NavBar downloadsNavBar;
  String jsonString = "";
  String devicePath = "/data/user/0/com.daviiid99.galaxy_j5_downloader/app_flutter";
  late File downloadsFile;
  List<String> downloadsTitle = [];
  List<String> downloadsPath = [];
  List<String> downloadsProgress = [];
  Map<dynamic, dynamic> lastDownloads = {};

  void initState() async{
    downloadsNavBar = NavBar(); // Initalize navBar
    recoverLastDownloads(); // Read last downloads
    downloadsFile = File("$devicePath/downloads.json");
    super.initState();
  }

  decodeJsonFile(){
    setState(() async {
      jsonString = await File("${devicePath}/downloads.json").readAsStringSync();
      lastDownloads = jsonDecode(jsonString);
    });
  }

  bool checkJSONFileExists() {
    // Check if the file path exists before attempt to writing to it
    return File("${devicePath}/downloads.json").existsSync();
  }

  createJSONFile(){
    // File doesn't exists, create it
    Map<dynamic,dynamic> example = {"example" : "example"};
    jsonString = jsonEncode(example);
    File("${devicePath}/downloads.json").writeAsStringSync(jsonString);
    LastDownloadsToList();
  }

  recoverLastDownloads() async {
    // This method reads a JSON file and recover last downloads
    bool exists = await checkJSONFileExists();

    if (exists){
      // Add downloads to list
      LastDownloadsToList();
    } else {
      // Create file
      createJSONFile();
    }
  }

  LastDownloadsToList() async {
    // This method adds last downloads to list
    await decodeJsonFile(); // Read file and update map

    print(lastDownloads);

    for (String download in lastDownloads.keys){
      if (!downloadsTitle.contains(download)){
        // Download title
        setState(() {
          downloadsTitle.add(download);
        });
      };

      if (!downloadsPath.contains(lastDownloads[download])){
        // Download path
        setState(() {
          downloadsPath.add(lastDownloads[download]);
        });
      };
    }

  }

  addDownloadToList(String title, String path){

    print("Title : $title");
    print("Path : $path");

    setState(() {
      downloadsTitle.add(title);
      downloadsPath.add(path);
      addDownloadToMap();
    });

  }

  addDownloadToMap() async {
    // This method adds a new download to the last downloads list
    for (String download in downloadsTitle){
          int index = downloadsTitle.indexOf(download);
          print("""
          File Name : ${downloadsTitle[index]},
          File Path : ${downloadsPath[index]},
          Index : $index,
          """);
          lastDownloads[download] = "example"; // Initialize hashmap entry
          lastDownloads[download] = downloadsPath[index];
    }
    jsonString = jsonEncode(lastDownloads);
    File("${devicePath}/downloads.json").writeAsStringSync(jsonString);
  }

  deleteDownload(String path, String file) async {
    // This method will receive the selected download path and name
    // Will remove it from the device. That's it

    File download = File("$path/$file");

    if (download.existsSync()) {
      // Time to remove
      download.deleteSync();
    } else{
      if(downloadsTitle.contains(file) && downloadsPath.contains(path)){
        deleteDownloadMap(file);
        deleteDownloadLists(file, path);
      }
    }
  }

    deleteDownloadLists(String currentDownloadName, String currentDownloadPath) async {
      // This method will delete a download from current lists
        setState(() {
          downloadsTitle.remove(currentDownloadName);
          downloadsPath.remove(currentDownloadPath);
        });
    }


  deleteDownloadMap(String download) async {
    // This method will delete a downlaod from hashMap entry

    // 1.- Delete from current map
    lastDownloads.remove(download);

    //2.- Overrite json file
    jsonString = jsonEncode(lastDownloads);
    downloadsFile.writeAsStringSync(jsonString);

  }

  Expanded currentDownloads() {
    // A widget that returns current and last downloads

    return Expanded(
        child: ListView.builder(
            itemCount: downloadsTitle.length,
            itemBuilder: (context, index){
              return ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(24),
                  topLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                  bottomLeft: Radius.circular(24),
                ),
                  child : InkWell(
                    onTap: (){},
                    onLongPress : ()
                    {
                     deleteDownload(downloadsPath[index], downloadsTitle[index]);
                    },
              child : Card(
                    color: Colors.black,
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.download_rounded, color: Color.fromRGBO(22, 124, 128, 100)),
                      trailing: IconButton(icon : Icon(Icons.delete_rounded, color: Colors.redAccent, ),
                        onPressed: (){
                        // User choosed to remove current entry
                          deleteDownload(downloadsPath[index], downloadsTitle[index]);

                      },),
                      title: Text(downloadsTitle[index], style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
                      subtitle: Column(
                        children: [
                          Row(
                            children : [
                            Text(downloadsPath[index], style: TextStyle(color: Colors.white, fontSize: 15),),
                          ]
                    )
                        ],
                        )
                      ),
                ]
                    )
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
          //Banner
          if(downloadsTitle.isNotEmpty)
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
          child: SizedBox(
            child : Image.asset("assets/icon/banner_downloads.png"))),

          SizedBox(height: 50,),

          // Body
          if(downloadsTitle.isNotEmpty) // Show listview
          currentDownloads(),

          if(downloadsTitle.isEmpty)
            Expanded(
             child: Column(
              children: [
                //Banner
                Image.asset("assets/icon/banner_no_downloads.png", alignment: Alignment.center, width: 150, height: 150,),
                Text("No downloads available!", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 20),),
              ],
            )
            ),

          // NavBar
          downloadsNavBar.NavigationBar(context, about, "downloads"),


        ],
      ),
    );
  }
}