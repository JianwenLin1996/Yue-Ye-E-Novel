import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import './globals.dart' as globals;
import './appendix.dart';
import './author.dart';
import './support.dart';

void main() {
  runApp(new MaterialApp(home: HomePage()));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StreamSubscription<DocumentSnapshot> subscription;

  final CollectionReference collectionReference =
      Firestore.instance.collection("Yue Ye");

  Directory dir;
  File jsonFile;
  String fileName = "yueye_content.json";
  bool fileExistance = false;

  File bookmarkFile;
  String bookmarkName = "bookmark.json";
  bool bookmarkFileExistance = false;

  List<dynamic> fileContentList = new List();
  String content = "";
  @override
  void initState() {
    super.initState();

    fetch();
    getApplicationDocumentsDirectory().then((Directory directory) {
      dir = directory;
      jsonFile = new File(dir.path + "/" + fileName);
      fileExistance = jsonFile.existsSync();
      bookmarkFile = new File(dir.path + "/" + bookmarkName);
      bookmarkFileExistance = bookmarkFile.existsSync();
      if (fileExistance) {
        List<dynamic> jsonFileContent =
            json.decode(jsonFile.readAsStringSync());
        jsonFileContent.clear();
        jsonFileContent.addAll(fileContentList);
        jsonFile.writeAsStringSync(json.encode(jsonFileContent));
      } else {
        createFile();
      }

      if (bookmarkFileExistance) {
        String bookmarkContent =
            json.decode(bookmarkFile.readAsStringSync()).toString();
        //print(bookmarkContent.toString());
        globals.bookmark = int.parse(bookmarkContent);
        print(globals.bookmark.toString());
      } else {
        File file = new File(dir.path + "/" + bookmarkName);
        file.createSync();
        bookmarkFileExistance = true;
        file.writeAsStringSync(json.encode(globals.bookmark));
      }
    });
  }

  void fetch() {
    collectionReference.getDocuments().then((data) {
      setState(() {
        for (int i = 0; i < data.documents.length; i++)
        //print(i.toString() + "/" + data.documents.length.toString());
        // print(data.documents[i].data.toString());
        {
          fileContentList.add(data.documents[i].data);
        }
      });
      // print(fileContentList.toString());
    });
  }

  void createFile() {
    File file = new File(dir.path + "/" + fileName);
    file.createSync();
    fileExistance = true;
    file.writeAsStringSync(json.encode(fileContentList));
  }

  void navigate(String title) {
    switch (title) {
      case "目录":
        Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => Appendix(fileContentList)));
        break;

      case "关于作者":
        Navigator.of(context).push(
            new MaterialPageRoute(builder: (BuildContext context) => Author()));
        break;

      case "支持":
        Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => Support()));
        break;

      case "退出":
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');

        break;
    }
  }

  Widget option(String title) {
    return new SizedBox(
        height: 40.0,
        width: 150.0,
        child: new GestureDetector(
          child: new Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                border: Border.all(width: 2.5, color: Colors.black)),
            child: new Center(
              child: new Material(
                type: MaterialType.transparency,
                child: new Text(title,
                    style: TextStyle(fontSize: 20.0, fontFamily: 'Mandarin')),
              ),
            ),
          ),
          onTap: () => navigate(title),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: RadialGradient(
                radius: 1.5, colors: [Colors.white, Colors.indigo[700]])),
        child: new Center(
            child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Material(
              type: MaterialType.transparency,
              child: new Text("月夜",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 80.0,
                      fontFamily: 'Mandarin')),
            ),
            new Padding(
              padding: EdgeInsets.fromLTRB(
                  0, MediaQuery.of(context).size.height / 15, 0, 0),
            ),
            option("目录"),
            new Padding(
              padding: EdgeInsets.fromLTRB(
                  0, MediaQuery.of(context).size.height / 25, 0, 0),
            ),
            option("关于作者"),
            new Padding(
              padding: EdgeInsets.fromLTRB(
                  0, MediaQuery.of(context).size.height / 25, 0, 0),
            ),
            option("支持"),
            new Padding(
              padding: EdgeInsets.fromLTRB(
                  0, MediaQuery.of(context).size.height / 25, 0, 0),
            ),
            option("退出"),
            new Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.height / 20),
            ),
            /*new RaisedButton(
              child: new SizedBox(
                height: 20.0,
                width: 50.0,
              ),
              onPressed: () => writeToFileList(storylist),
            )*/
          ],
        )));
  }
}
