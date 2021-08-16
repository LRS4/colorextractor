import 'dart:io';
import 'package:colorextractor/providers/image_details.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ImageInput extends StatefulWidget {
  @override 
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  @override 
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<ImageDetailsProvider>(context);

    return Row(
      children: <Widget>[
        Container(
          width: 200, 
          height: 200, 
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey)
          ),
          child: imageProvider.storedImageInitialised
            ? Image.file(
              imageProvider.storedImage, 
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
                imageProvider.getPictureFrom("camera")
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
                imageProvider.getPictureFrom("gallery")
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