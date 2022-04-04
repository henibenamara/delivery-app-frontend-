import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../utility.dart';


class SaveImageDemo extends StatefulWidget {
  SaveImageDemo() : super();

  final String title = "Flutter Save Image in Preferences";

  @override
  _SaveImageDemoState createState() => _SaveImageDemoState();
}

class _SaveImageDemoState extends State<SaveImageDemo> {
  //
   Future<File>? imageFile;
   Image ?imageFromPreferences;

  pickImageFromGallery(ImageSource source) {
    setState(() {
      imageFile = ImagePicker().pickImage(source: source) as Future<File>? ;
    });
  }

  loadImageFromPreferences() {
    ImageSharedPrefs.loadImageFromPrefs().then((img) {
      if (null == img) {
        return;
      }
      setState(() {
        imageFromPreferences = ImageSharedPrefs.imageFrom64BaseString(img);
      });
    });
  }

  Widget imageFromGallery() {
    return FutureBuilder<File>(
      future: imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          print("teest");
          print(snapshot.data!.path);
          ImageSharedPrefs.saveImageToPrefs(
              ImageSharedPrefs.base64String(snapshot.data!.readAsBytesSync()));
          return Image.file(
            snapshot.data!,
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              pickImageFromGallery(ImageSource.gallery);
              setState(() {

                imageFromPreferences = null;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              loadImageFromPreferences();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            imageFromGallery(),
            SizedBox(
              height: 20.0,
            ),
            null == imageFromPreferences ? Container() : imageFromPreferences!,
          ],
        ),
      ),
    );
  }
}