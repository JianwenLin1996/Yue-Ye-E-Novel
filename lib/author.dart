import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Author extends StatefulWidget {
  @override
  _AuthorState createState() => _AuthorState();
}

class _AuthorState extends State<Author> {
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        flexibleSpace: Container(
            decoration: new BoxDecoration(
                gradient: new LinearGradient(
                    colors: [Colors.blue[300], Colors.white]))),
        title: new Text(
          "关于作者",
          style: TextStyle(
              color: Colors.black87,
              fontFamily: 'Mandarin',
              fontSize: 30.0,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(children: <Widget>[
        new Container(
            child: new Center(
                child: new Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(
                  0, MediaQuery.of(context).size.height / 40, 0, 0),
            ),
            //new Image.asset('assets/author.JPG')
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CircleAvatar(
                  radius: 65.0,
                  backgroundImage: AssetImage('assets/author.JPG'),
                ),
                Column(
                  children: <Widget>[
                    new Text(
                      "点击关注",
                      style: TextStyle(
                          fontFamily: 'Mandarin',
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          0, MediaQuery.of(context).size.height / 20, 0, 0),
                    ),
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Image.asset("assets/facebook.png",
                            width: MediaQuery.of(context).size.height / 25,
                            height: MediaQuery.of(context).size.height / 25),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                        ),
                        new GestureDetector(
                          child: new Text(
                            "@旭浩 Xu Hao",
                            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 18.0,color: Colors.blueAccent)
                          ),
                          onTap: () => {
                                _launchURL(
                                    "https://www.facebook.com/XuHaoWrites/")
                              },
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          0, MediaQuery.of(context).size.height / 35, 0, 0),
                    ),
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Image.asset("assets/instagram.png",
                            width: MediaQuery.of(context).size.height / 25,
                            height: MediaQuery.of(context).size.height / 25),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                        ),
                        new GestureDetector(
                          child: new Text("@xuhaowrites",
                              style: TextStyle(fontStyle: FontStyle.italic,fontSize: 18.0, color: Colors.blueAccent)),
                          onTap: () => {
                                _launchURL(
                                    "https://www.instagram.com/xuhaowrites/?hl=en")
                              },
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(
                    0, MediaQuery.of(context).size.height / 16, 0, 0)),
            new Text(
              "张旭浩，1997年11月9日生，暂无笔名，马来西亚人。\n",
              style: TextStyle(fontFamily: 'Mandarin', fontSize: 18.0),
            ),
            new Text(
              "活在这个画面感十足的电视剧比文绉绉的小说更吸引人的年代，却没有想要放弃当一个作家的念想。\n",
              style: TextStyle(fontFamily: 'Mandarin', fontSize: 18.0),
            ),
            new Text(
              "无法压抑那股内心的渴望，忍不住写了《月夜》，也写了各种各样的文章，只为抒发心中所想。\n\n我不相信命中注定，却相信运气使然。\n\n“越努力，越幸运！”\n",
              style: TextStyle(fontFamily: 'Mandarin', fontSize: 18.0),
            ),
            new Text(
              "这个世界最幸运的人，一定是那个默默耕耘，最努力之人。\n",
              style: TextStyle(fontFamily: 'Mandarin', fontSize: 18.0),
            ),
          ],
        ))),
      ]),
    );
  }
}
