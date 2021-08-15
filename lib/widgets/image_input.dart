import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  @override 
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  late File _storedImage;
  late String _storedImagePath; // this needs to be used by parent widget
  bool _storedImageInitialised = false;

  Future<bool> _getPictureFrom(source) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? _imageFile = await _picker.pickImage(
      source: source == "camera" 
        ? ImageSource.camera 
        : ImageSource.gallery,
      maxWidth: 600
    );

    setState(() {
      if (_imageFile != null) {
        _storedImage = File(_imageFile.path);
        _storedImagePath = _imageFile.path;
        _storedImageInitialised = true;
      }
    });

    return true;
  }

  @override 
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 200, 
          height: 200, 
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey)
          ),
          child: _storedImageInitialised
            ? Image.file(
              _storedImage, 
              fit: BoxFit.cover, 
              width: double.infinity
            ) 
            : Text(
              "No Image Taken",
              textAlign: TextAlign.center,
            ),
          alignment: Alignment.center,
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.camera_alt),
              label: Text("Take Photo"),
              onPressed: () => {
                _getPictureFrom("camera")
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.only(left: 20, right: 20)
                )
              )
            ),
            SizedBox(height: 20.0),
            TextButton.icon(
              icon: Icon(Icons.image),
              label: Text("Choose Photo"),
              onPressed: () => {
                _getPictureFrom("gallery")
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.only(left: 20, right: 20)
                )
              )
            )
          ]
        )
      ],
    );
  }
}