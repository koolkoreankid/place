import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  // expect to get data from other file
  final Function onSelectImage;

  ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;



  Future<void> _takePicture() async {
    final imageFile =
        await ImagePicker.pickImage(
          source: ImageSource.camera,
          maxWidth: 600
        );
        if(imageFile == null) {
          // if stopped without taking pic, return nth
          return;
        }
    setState(() {
      _storedImage = imageFile;
    });

    final appDir = await syspaths.getApplicationDocumentsDirectory();
    // imageFile.path is the place where its stored temporary before
    // includes folders and name of the file
    // and "fileName" gets it by use of basename
    // then put it into copy
    // then put file directory in the saved image 
    // future, needs time to finish, await asynchronously

    final fileName = path.basename(imageFile.path);
    final savedImage = await imageFile.copy('${appDir.path}/$fileName');
    // widget from the top of stateful
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Container(
        width: 150,
        height: 100,
        decoration:
            BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
        child: _storedImage != null
            ? Image.file(
                _storedImage,
                fit: BoxFit.cover,
                width: double.infinity,
              )
            : Text(
                "no image ",
                textAlign: TextAlign.center,
              ),
        alignment: Alignment.center,
      ),
      SizedBox(
        width: 10,
      ),
      Expanded(
          child: FlatButton.icon(
        icon: Icon(
          Icons.camera,
          color: Colors.pinkAccent,
        ),
        label: Text("Take Picute"),
        onPressed: _takePicture,
      ))
    ]);
  }
}
