import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Image Picker Example',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Image Picker'),
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
  var _image = null;

  AlertDialog alert;

  var state = '';

  List<Asset> assets = List<Asset>();
  String _error = 'No Error Dectected';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      endDrawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DrawerHeader(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    // showImageSelectionOptions();
                    //getImageFromCamera();
                  },
                  child: _image == null
                      ? CircleAvatar(
                          radius: 40,
                          backgroundColor: Color(0xff83AE45),
                          child: Icon(
                            Icons.account_circle,
                            color: Color(0xffffffff),
                          ),
                        )
                      : ClipOval(
                          child: Image.file(
                            _image,
                            fit: BoxFit.cover,
                            width: 40.0,
                            height: 40.0,
                          ),
                        ),
                ),
                Text(
                  "9959323979",
                  style: TextStyle(
                    color: Color(0xff999999),
                    fontSize: 26,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            )),
            ListTile(
              title: Text(
                '     - Single Image Picker',
                style: TextStyle(
                  color: Color(0xff555555),
                  fontSize: 20,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {
                showImageSelectionOptions();
              },
            ),
            ListTile(
              title: Text(
                '     - Multiple Image Picker',
                style: TextStyle(
                  color: Color(0xff555555),
                  fontSize: 20,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: loadAssets,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: ListTile(
                  contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 25.0, 30.0),
//                  leading: Image.asset(
//                    'images/logout.png',
//                    height: 60,
//                    width: 60,
//                    color: Color(0xff83AE45),
//                  ),
                  title: Text(
                    'Logout',
                    style: TextStyle(
                      color: Color(0xff83AE45),
                      fontSize: 15,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  onTap: () {
                    // clearUserDetails();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Text(
          'IMAGE PICKER',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void showImageSelectionOptions() {
    alert = AlertDialog(
      elevation: 10.0,

//      content:
      title: Text(
        "Pick From:",
        style: TextStyle(
            fontSize: 16.0,
            fontFamily: "MontserratReg",
            color: Color(0xFF000000)),
      ),
      actions: [
        SizedBox(width: 10.0),
        ButtonTheme(
          minWidth: 100,
          height: 40,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            color: Color(0xFF50E3C2),
            child: Text(
              "CAMERA",
              style: TextStyle(
                  fontSize: 12.0,
                  fontFamily: "MontserratBold",
                  color: Color(0xFFFFFFFF)),
            ),
            onPressed: () {
              getImageFromCamera();
            },
          ),
        ),
        SizedBox(width: 10.0),
        ButtonTheme(
          minWidth: 100,
          height: 40,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            color: Color(0xFF50E3C2),
            child: Text(
              "GALLERY",
              style: TextStyle(
                  fontSize: 12.0,
                  fontFamily: "MontserratBold",
                  color: Color(0xFFFFFFFF)),
            ),
            onPressed: () {
              getImageFromGallery();
            },
          ),
        ),
        SizedBox(width: 10.0),
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future getImageFromCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
      Navigator.pop(context, "result");
    });
  }

  Future getImageFromGallery() async {
//    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
//    setState(() {
//      _image = image;
//      Navigator.pop(context, "result");
//    });

    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    // var file = await uploadImage(image.path, "");
    setState(() {
      _image = image;
      Navigator.pop(context, "result");
//      state = file;
      print("res" + image.toString());
    });
  }

  Future<String> uploadImage(filename, url) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('picture', filename));
    var res = await request.send();
    print("responseee" + res.toString());
    return res.reasonPhrase;
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: assets,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
      //////////////
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'http://139.59.17.219:9099/imedihubhims/openapi/prescription/uploadfile'));
      List<MultipartFile> multipart = List<MultipartFile>();

      for (int i = 0; i < assets.length; i++) {
        var path =
            await FlutterAbsolutePath.getAbsolutePath(assets[i].identifier);
//        multipart
//            .add(await MultipartFile.fromFile(path, filename: 'myfile.jpg'));
        multipart.add(
            await http.MultipartFile.fromPath('picture', assets[i].toString()));
      }

      request.files.addAll(multipart);

//      FormData imageFormData = FormData.fromMap({
//        "files": multipart,
//      });
//      FormData imageFormData = FormData.fromMap(<String, dynamic>{
//        "files": multipart,
//      });
      ////////////////
    } on Exception catch (e) {
      error = e.toString();
    }
    if (!mounted) return;

    setState(() {
      print('imagessss' + resultList.toString());
      print('imagessss' + assets.toString());
      assets = resultList;
      _error = error;
    });
  }
}
