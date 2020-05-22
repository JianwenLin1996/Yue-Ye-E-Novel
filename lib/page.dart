import 'dart:io';
import 'package:flutter/material.dart';
import './globals.dart' as globals;
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

class Page extends StatefulWidget {
  Page(List<String> this.a, List<String> this.b, int this.nom);
  final List<String> a, b;
  final int nom;

  @override
  _PageState createState() => _PageState(a, b, nom);
}

class _PageState extends State<Page> {
  _PageState(List<String> this.name, List<String> this.desc, int this.nom);
  List<String> name;
  List<String> desc;
  int nom;
  String titleDisplayed;
  String contentDisplayed;

  ScrollController scrollController = new ScrollController();
  File bookmarkFile;
  Directory dir;
  String bookmarkName = "bookmark.json";
  bool bookmarkFileExistance = false;

  void update(String b) {
    switch (b) {
      case "back":
        if (nom != 0) {
          nom--;
          titleDisplayed = name[nom];
          contentDisplayed = desc[nom];
          scrollController.jumpTo(0.0);
        } else {
          Fluttertoast.showToast(
            msg: "You are already in the first page",
            backgroundColor: Colors.black54,
            textColor: Colors.white,
          );
        }
        break;

      case "next":
        if (nom != name.length - 1) {
          nom++;
          titleDisplayed = name[nom];
          contentDisplayed = desc[nom];
          scrollController.jumpTo(0.0);
        } else {
          Fluttertoast.showToast(
            msg: "You are already in the last page",
            backgroundColor: Colors.black54,
            textColor: Colors.white,
          );
        }
        break;
    }

    this.setState(() => {});
  }

  @override
  void initState() {
    super.initState();
    titleDisplayed = name[nom];
    contentDisplayed = desc[nom];
    //print("got it1");

    getApplicationDocumentsDirectory().then((Directory directory) {
      dir = directory;
      bookmarkFile = new File(dir.path + "/" + bookmarkName);
     // print("got it");
    });

    this.setState(() => {});
  }

  Future<bool> saveBookMark() {
    globals.bookmark = nom + 1;
    bookmarkFile.writeAsStringSync(
      json.encode(globals.bookmark),
      mode: FileMode.write,
    );
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: saveBookMark,
      child: Scaffold(
        appBar: new AppBar(
          leading: new GestureDetector(
              onTap: () => setState(() {
                    saveBookMark();
                    Navigator.of(context).pop();
                  }),
              child: new Icon(Icons.home)),
          flexibleSpace: Container(
            decoration: new BoxDecoration(
                gradient: new LinearGradient(
                    colors: [Colors.purple[300], Colors.white],)),
                    
          ),
          title: new Text("第 ${nom + 1} 章 - " + titleDisplayed,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'FanTi',
                fontSize: 20.0,
              )),
        ),
        body: new ListView(
          controller: scrollController,
          children: <Widget>[
            new Container(
              color: Colors.yellow[50],
                child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      15.0,
                      20.0,
                      15.0,
                      0,
                    ),
                    child: new Text(contentDisplayed,
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w200))))
          ],
        ),
        bottomNavigationBar: new BottomAppBar(
          elevation: 10.0,
          child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                GestureDetector(
                    onTap: () => update("back"),
                    child: SizedBox(
                        height: 50.0,
                        width: 30.0,
                        child: new Icon(
                          Icons.arrow_back,
                          size: 30.0,
                        ))),
                GestureDetector(                  
                    onTap: () => update("next"),
                    child: SizedBox(
                        height: 50.0,
                        width: 30.0,
                        child: new Icon(
                          Icons.arrow_forward,
                          size: 30.0,
                        ))),
              ]),
        ),
      ),
    );
  }
}
