import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:screenshot/screenshot.dart';
import 'package:social_share/social_share.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Screenshot(
        controller: screenshotController,
        child: Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: () async {
                  File file = await ImagePicker.pickImage(
                      source: ImageSource.gallery);
                  SocialShare.shareInstagramStory(file.path, "#ffffff",
                      "#000000", "https://deep-link-url")
                      .then((data) {
                    print(data);
                  });
                },
                child: Text("Share On Instagram Story"),
              ),
              RaisedButton(
                onPressed: () async {
                  await screenshotController.capture().then((image) async {
                    SocialShare.shareInstagramStorywithBackground(image.path,
                        "#ffffff", "#000000", "https://deep-link-url",
                        backgroundImagePath: image.path)
                        .then((data) {
                      print(data);
                    });
                  });
                },
                child: Text("Share On Instagram Story with background"),
              ),
              RaisedButton(
                onPressed: () async {
                  SocialShare.shareTwitter(
                      "This is Social Share twitter example",
                      hashtags: ["hello", "world", "foo", "bar"],
                      url: "https://google.com/#/hello",
                      trailingText: "\nhello")
                      .then((data) {
                    print(data);
                  });
                },
                child: Text("Share on twitter"),
              ),
              RaisedButton(
                onPressed: () async {
                  SocialShare.shareSms("This is Social Share Sms example",
                      url: "\nhttps://google.com/",
                      trailingText: "\nhello")
                      .then((data) {
                    print(data);
                  });
                },
                child: Text("Share on Sms"),
              ),
              RaisedButton(
                onPressed: () async {
                  SocialShare.shareWhatsapp(
                      "Hello World \n https://google.com")
                      .then((data) {
                    print(data);
                  });
                },
                child: Text("Share on Whatsapp"),
              ),
              RaisedButton(
                onPressed: () async {
                  SocialShare.shareTelegram(
                      "Hello World \n https://google.com")
                      .then((data) {
                    print(data);
                  });
                },
                child: Text("Share on Telegram"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
