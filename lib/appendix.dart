import 'package:flutter/material.dart';
import './page.dart';
import './globals.dart' as globals;
//import 'dart:io';

class Appendix extends StatefulWidget {
  Appendix(List<dynamic> this.file);
  final List<dynamic> file;
  @override
  _AppendixState createState() => _AppendixState(file);
}

class _AppendixState extends State<Appendix> {
  _AppendixState(List<dynamic> this.appenFile);
  List<dynamic> appenFile;
  List<String> chapterName = new List();
  List<String> chapterContent = new List();
  int fileLength;
  @override
  void initState() {
    super.initState();
    setState(() {
      fileLength = appenFile.length;

      for (int i = 0; i < fileLength; i++) {
        chapterName.add(
            appenFile[i]["Chapter Name"].toString().replaceAll("\\n", "\n"));
        chapterContent.add(
            appenFile[i]["Chapter Content"].toString().replaceAll("\\n", "\n"));
      }
    });
  }

  Widget chapter(int k) {
    return SizedBox(
      height: 30.0,
      width: 70.0,
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            border: Border.all(
                width: globals.bookmark == k ? 3.0 : 1.0,
                color: Colors.blueAccent),
          ),
          child: Center(
              child: GestureDetector(
                  onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) =>
                          new Page(chapterName, chapterContent, k - 1))),
                  child: new Text(
                    "第$k章",
                    style: TextStyle(fontFamily: 'Mandarin', fontSize: 15.0),
                  )))),
    );
  }

  Widget line(int j) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        chapter(j + 1),
        new Padding(
          padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width / 8, 0, 0, 0),
        ),
        chapter(j + 2),
        new Padding(
          padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width / 8, 0, 0, 0),
        ),
        chapter(j + 3)
      ],
    );
  }

  List<Widget> lastline(int remainder) {
    List<Widget> lastlist = new List();
    lastlist.add(new Padding(
      padding:
          EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 16, 0, 0, 0),
    ));
    for (int j = 0; j < remainder; j++) {
      lastlist.add(chapter(fileLength - (remainder - 1) + j));
      lastlist.add(new Padding(
        padding: EdgeInsets.fromLTRB(
            MediaQuery.of(context).size.width / 16, 0, 0, 0),
      ));
    }
    return lastlist;
  }

  List<Widget> appendixWidgets() {
    List<Widget> list = new List();
    list.add(new Padding(
        padding: EdgeInsets.fromLTRB(
            0, MediaQuery.of(context).size.height / 12, 0, 0)));
    if (fileLength < 1)
      list.add(new Text("Please connect to internet."));
    else {
      for (int i = 0; i <= (fileLength / 3) - 1; i++) {
        list.add(line(i * 3));
        list.add(new Padding(
            padding: EdgeInsets.fromLTRB(
                0, MediaQuery.of(context).size.height / 12, 0, 0)));
      }

      list.add(new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: lastline(fileLength % 3)));
    }

    list.add(new Padding(
        padding: EdgeInsets.fromLTRB(
            0, MediaQuery.of(context).size.height / 12, 0, 0)));

    return list;
  }

  Widget layout() {
    return ListView(children: appendixWidgets());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        flexibleSpace: Container(
            decoration: new BoxDecoration(
                gradient: new LinearGradient(
                    colors: [Colors.purple[300], Colors.white]))),
        title: new Text(
          "目录",
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Mandarin',
              fontSize: 30.0,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: new Container(child: layout()),
    );
  }
}
